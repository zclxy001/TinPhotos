//
//  TINAssetsGroup.m
//  TINPhotosDemo
//
//  Created by 张灿 on 16/5/30.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import "TINAssetsGroup.h"
#import "TINPhotos.h"
#import "TINPHAssetsGroup.h"
#import "TINALAssetsGroup.h"
#import <Photos/Photos.h>
#import <AssetsLibrary/AssetsLibrary.h>

@implementation TINAssetsGroup

+(instancetype)alloc{
    
    if ([self class] == [TINAssetsGroup class]) {
        
        if (iOS8Later) {
            
            return [TINPHAssetsGroup alloc];
            
        }else{
            
            return [TINALAssetsGroup alloc];
        }
    }else{
        
        return [super alloc];
    }
    
}

+(instancetype)groupWithResult:(id)result name:(NSString*)name{

    if (iOS8Later) {
        
        return [TINPHAssetsGroup groupWithResult:result name:name];
        
    }else{
        
        return [TINALAssetsGroup groupWithResult:result name:name];
    }
    
}

#pragma mark- Virtual method
-(void)getPostImageWithWithCompletion:(void (^)(UIImage *postImage))completion{}

- (void)getAssetsWithCompletion:(void (^)(NSArray<TINAsset *> *assets))completion{}


@end
