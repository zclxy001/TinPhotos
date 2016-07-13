//
//  TINALAssetsLibrary.m
//  TINPhotosDemo
//
//  Created by 张灿 on 16/5/30.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import "TINALAssetsLibrary.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "TINALAssetsGroup.h"

@interface TINALAssetsLibrary ()

@property (strong,nonatomic) ALAssetsLibrary* assetsLibrary;

@end
@implementation TINALAssetsLibrary
-(instancetype)init{

    if (self = [super init]) {
        _assetsLibrary = [self assetsLibrary];
    }
    return self;
}

-(void)getAllAssetsGroupsWithCompletion:(void (^)(NSArray<TINAssetsGroup *> *))completion{

    NSMutableArray* assetsGroups = [[NSMutableArray alloc]init];
    [self.assetsLibrary enumerateGroupsWithTypes:ALAssetsGroupAll usingBlock:^(ALAssetsGroup *group, BOOL *stop) {
        if (group == nil) {
            completion(assetsGroups);
        }
        if (group.numberOfAssets < 1) return ;
        NSString* name = [group valueForProperty:ALAssetsGroupPropertyName];
        [assetsGroups addObject:[TINALAssetsGroup groupWithResult:group name:name]];
    } failureBlock:^(NSError *error) {
        if (completion) {
            completion(assetsGroups);
        }
    }];
    
}

- (BOOL)authorizationStatusAuthorized{
    return [ALAssetsLibrary authorizationStatus] == ALAuthorizationStatusAuthorized;
}



#pragma mark- getter,setter Method
-(ALAssetsLibrary *)assetsLibrary{
    
    static dispatch_once_t pred = 0;
    static ALAssetsLibrary *library = nil;
    dispatch_once(&pred, ^{
        library = [[ALAssetsLibrary alloc] init];
    });
    _assetsLibrary = library;
    return _assetsLibrary;
}

@end
