//
//  TINAsset.h
//  TINPhotosDemo
//
//  Created by 张灿 on 16/5/30.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface TINAsset : NSObject

//assetResult is ALAsset(IOS7before) or PHAsset(IOS8Later)
@property (strong,nonatomic) id assetResult;
//asset的唯一标识别符号，PHAsset-localIdentifier or ALAsset-absoluteString
- (NSString *)assetIdentifier;

+(instancetype)assetWithAssetResult:(id)assetResult;

-(void)getThumbnailPhotoWithCompletion:(void (^)(UIImage *thumbnail))completion;

-(void)getPhotoWithCompletion:(void (^)(UIImage *photo,NSDictionary *info,BOOL isInCloud))completion;

@end
