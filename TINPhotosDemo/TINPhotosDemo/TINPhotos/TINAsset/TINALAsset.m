//
//  TINALAsset.m
//  TINPhotosDemo
//
//  Created by 张灿 on 16/5/31.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import "TINALAsset.h"
#import <AssetsLibrary/AssetsLibrary.h>

@implementation TINALAsset

- (NSString *)assetIdentifier{
    ALAsset* asset = (ALAsset*)self.assetResult;
    return asset.defaultRepresentation.url.absoluteString;
}

+(instancetype)assetWithAssetResult:(id)assetResult{
    TINALAsset* asset = [[TINALAsset alloc]init];
    asset.assetResult = assetResult;
    return asset;
}

-(void)getThumbnailPhotoWithCompletion:(void (^)(UIImage *thumbnail))completion{
    ALAsset* asset = (ALAsset*)self.assetResult;
    if (completion) {
        completion([UIImage imageWithCGImage:asset.thumbnail]);
    }
}

-(void)getPhotoWithCompletion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isInCloud))completion{
    ALAsset* asset = (ALAsset*)self.assetResult;
    if (completion) {
        UIImage* photo = [UIImage imageWithCGImage:asset.defaultRepresentation.fullResolutionImage];
        completion(photo,nil,NO);
    }
}

@end
