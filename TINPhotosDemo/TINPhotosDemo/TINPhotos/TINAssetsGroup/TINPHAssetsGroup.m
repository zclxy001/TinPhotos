//
//  TINPHAssetsGroup.m
//  TINPhotosDemo
//
//  Created by 张灿 on 16/5/31.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import "TINPHAssetsGroup.h"
#import <Photos/Photos.h>
#import "TINPHAsset.h"

@implementation TINPHAssetsGroup

+(instancetype)groupWithResult:(id)result name:(NSString*)name{

    TINPHAssetsGroup* group = [[TINPHAssetsGroup alloc]init];
    group.result = result;
    group.name = name;
    PHFetchResult<PHAsset *> * fetchResult = (PHFetchResult<PHAsset *> *)result;
    group.count = fetchResult.count;
    
    return group;
}

-(void)getPostImageWithWithCompletion:(void (^)(UIImage *postImage))completion{

    PHFetchResult<PHAsset *> * fetchResult = (PHFetchResult<PHAsset *> *)self.result;
    PHAsset* newestAsset = fetchResult.lastObject;
    TINPHAsset* tpAsset = [TINPHAsset assetWithAssetResult:newestAsset];
    [tpAsset getThumbnailPhotoWithCompletion:^(UIImage *thumbnail) {
        if (completion) {
            completion(thumbnail);
        }
    }];
}

- (void)getAssetsWithCompletion:(void (^)(NSArray<TINAsset *> *assets))completion{
    PHFetchResult<PHAsset *> * fetchResult = (PHFetchResult<PHAsset *> *)self.result;
    NSMutableArray* mulAssersArr = [[NSMutableArray alloc]init];
    [fetchResult enumerateObjectsUsingBlock:^(PHAsset * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [mulAssersArr addObject:[TINPHAsset assetWithAssetResult:obj]];
    }];
    if (completion) {
        completion([mulAssersArr copy]);
    }
}



@end
