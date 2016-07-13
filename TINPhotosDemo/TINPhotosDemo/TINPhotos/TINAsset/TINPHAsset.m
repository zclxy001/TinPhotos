//
//  TINPHAsset.m
//  TINPhotosDemo
//
//  Created by 张灿 on 16/5/31.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import "TINPHAsset.h"
#import <Photos/Photos.h>
static CGSize AssetGridThumbnailSize;

@implementation TINPHAsset

-(instancetype)init{

    if (self = [super init]) {
        CGFloat thumbnailWidth = [UIScreen mainScreen].bounds.size.width/4;
        AssetGridThumbnailSize = CGSizeMake(thumbnailWidth, thumbnailWidth);
    }
    return self;
}

+(instancetype)assetWithAssetResult:(id)assetResult{
    TINPHAsset* asset = [[TINPHAsset alloc]init];
    asset.assetResult = assetResult;
    return asset;
}

- (NSString *)assetIdentifier{
    PHAsset* asset = self.assetResult;
    return asset.localIdentifier;
}

-(void)getThumbnailPhotoWithCompletion:(void (^)(UIImage *thumbnail))completion{
    PHAsset* asset = self.assetResult;
    PHCachingImageManager* cachingImageManager = [[PHCachingImageManager alloc]init];
    cachingImageManager.allowsCachingHighQualityImages = NO;
    [cachingImageManager requestImageForAsset:asset
                                   targetSize:AssetGridThumbnailSize
                                  contentMode:PHImageContentModeAspectFill
                                      options:nil
                                resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
    {
        if (result && completion) {
             completion(result);
        }
    }];
}

-(void)getPhotoWithCompletion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isInCloud))completion{
    [[PHImageManager defaultManager] requestImageForAsset:self.assetResult
                                               targetSize:PHImageManagerMaximumSize
                                              contentMode:PHImageContentModeAspectFill
                                                  options:nil
                                            resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info)
    {
        UIImage* photo = result;
        NSDictionary* photoInfo = info;
        BOOL isInCloud = (!photo)&&([[photoInfo objectForKey:PHImageResultIsInCloudKey]boolValue]);
        if (completion) {
            completion(photo,photoInfo,isInCloud);
        }
    }];
}

@end
