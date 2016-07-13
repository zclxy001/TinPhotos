//
//  TINAsset.m
//  TINPhotosDemo
//
//  Created by 张灿 on 16/5/30.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import "TINAsset.h"
#import "TINPhotos.h"
#import "TINALAsset.h"
#import "TINPHAsset.h"
#import <Photos/Photos.h>

@implementation TINAsset

+(instancetype)alloc{
    
    if ([self class] == [TINAsset class]) {
        
        if (iOS8Later) {
            
            return [TINPHAsset alloc];
            
        }else{
            
            return [TINALAsset alloc];
        }
    }else{
        
        return [super alloc];
    }
    
}

+(instancetype)assetWithAssetResult:(id)assetResult{

    if (iOS8Later) {
        
        return [TINPHAsset assetWithAssetResult:assetResult];
        
    }else{
        
        return [TINALAsset assetWithAssetResult:assetResult];
    }

    
}

#pragma mark- Virtual method
- (NSString *)assetIdentifier{return nil;}
-(void)getThumbnailPhotoWithCompletion:(void (^)(UIImage *thumbnail))completion{}
-(void)getPhotoWithCompletion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isInCloud))completion{}

@end
