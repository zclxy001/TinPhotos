//
//  TINALAssetsGroup.m
//  TINPhotosDemo
//
//  Created by 张灿 on 16/5/31.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import "TINALAssetsGroup.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "TINALAsset.h"

@implementation TINALAssetsGroup

+(instancetype)groupWithResult:(id)result name:(NSString *)name{

    TINALAssetsGroup* group = [[TINALAssetsGroup alloc]init];
    group.result = result;
    group.name = name;
    ALAssetsGroup* assetsGroup = (ALAssetsGroup*)result;
    group.count = [assetsGroup numberOfAssets];
    
    return group;
}

-(void)getPostImageWithWithCompletion:(void (^)(UIImage *))completion{

    ALAssetsGroup* assetsGroup = (ALAssetsGroup*)self.result;
    UIImage* postImage = [UIImage imageWithCGImage:assetsGroup.posterImage];
    if (completion) {
        completion(postImage);
    }
}

-(void)getAssetsWithCompletion:(void (^)(NSArray<TINAsset *> *))completion{
    NSMutableArray* mulAssersArr = [[NSMutableArray alloc]init];
    ALAssetsGroup* assetsGroup = (ALAssetsGroup*)self.result;
    [assetsGroup setAssetsFilter:[ALAssetsFilter allPhotos]];
    [assetsGroup enumerateAssetsUsingBlock:^(ALAsset *result, NSUInteger index, BOOL *stop) {
        if (result == nil) {
            if (completion) {
                completion(mulAssersArr);
            }
        }
        
        [mulAssersArr addObject:[TINALAsset assetWithAssetResult:result]];
    }];
}

@end
