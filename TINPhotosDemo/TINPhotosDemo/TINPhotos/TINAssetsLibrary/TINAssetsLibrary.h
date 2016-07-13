//
//  TINAssetsLibrary.h
//  TINPhotosDemo
//
//  Created by 张灿 on 16/5/30.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TINAssetsGroup.h"



@interface TINAssetsLibrary : NSObject

//是否获得了访问相册的授权，YES已获得，NO未获得
- (BOOL)authorizationStatusAuthorized;
//获得所有相册分组
- (void)getAllAssetsGroupsWithCompletion:(void (^)(NSArray<TINAssetsGroup *> *groups))completion;

@end
