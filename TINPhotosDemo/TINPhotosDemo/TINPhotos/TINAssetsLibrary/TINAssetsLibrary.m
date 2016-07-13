//
//  TINAssetsLibrary.m
//  TINPhotosDemo
//
//  Created by 张灿 on 16/5/30.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import "TINAssetsLibrary.h"
#import "TINALAssetsLibrary.h"
#import "TINPHAssetsLibrary.h"
#import "TINPhotos.h"


@implementation TINAssetsLibrary

+(instancetype)alloc{

    if ([self class] == [TINAssetsLibrary class]) {
        
        if (iOS8Later) {
         
            return [TINPHAssetsLibrary alloc];
            
        }else{
        
            return [TINALAssetsLibrary alloc];
        }
    }else{
    
        return [super alloc];
    }
    
}

//virtual Method
- (void)getAllAssetsGroupsWithCompletion:(void (^)(NSArray<TINAssetsGroup *> *groups))completion{}
- (BOOL)authorizationStatusAuthorized{return NO;};


@end
