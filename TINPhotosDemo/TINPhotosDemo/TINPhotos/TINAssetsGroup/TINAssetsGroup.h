//
//  TINAssetsGroup.h
//  TINPhotosDemo
//
//  Created by 张灿 on 16/5/30.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TINAsset.h"
@interface TINAssetsGroup : NSObject

@property (nonatomic, strong) NSString *name;        ///< The album name
@property (nonatomic, assign) NSInteger count;       ///< Count of photos the group contain
@property (nonatomic, strong) id result; ///< PHFetchResult<PHAsset> or ALAssetsGroup<ALAsset>

+(instancetype)groupWithResult:(id)result name:(NSString*)name;

-(void)getPostImageWithWithCompletion:(void (^)(UIImage *postImage))completion;

- (void)getAssetsWithCompletion:(void (^)(NSArray<TINAsset *> *assets))completion;



@end
