//
//  TINPHAssetsLibrary.m
//  TINPhotosDemo
//
//  Created by 张灿 on 16/5/30.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import "TINPHAssetsLibrary.h"
#import "TINPHAssetsGroup.h"
#import <Photos/Photos.h>

@implementation TINPHAssetsLibrary

-(instancetype)init{

    if (self = [super init]) {
        
        [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        }];
    }
    return self;
}

-(void)getAllAssetsGroupsWithCompletion:(void (^)(NSArray<TINAssetsGroup *> *))completion{
    NSMutableArray* assetsGroups = [[NSMutableArray alloc]init];
    PHFetchOptions* options = [[PHFetchOptions alloc]init];
    options.predicate = [NSPredicate predicateWithFormat:@"mediaType == %ld", PHAssetMediaTypeImage];
    options.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"creationDate" ascending:YES]];
    
//    //全部相册
//    PHFetchResult* allPhotos = [PHAsset fetchAssetsWithOptions:options];
//    if (allPhotos.count>0) {
//        [assetsGroups addObject:[TINPHAssetsGroup groupWithResult:allPhotos name:@"全部照片"]];
//    }
    //系统智能相册
    PHFetchResult* smartAlbums = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeSmartAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection* collection in smartAlbums) {
        PHFetchResult* fetchResult  = [PHAsset fetchAssetsInAssetCollection:collection options:options];
        if (fetchResult.count < 1) continue;
        [assetsGroups addObject:[TINPHAssetsGroup groupWithResult:fetchResult name:collection.localizedTitle]];
    }
    //用户创建相册
    PHFetchResult* topLevelUserCollections = [PHCollectionList fetchTopLevelUserCollectionsWithOptions:nil];
    for (PHAssetCollection* collection in topLevelUserCollections) {
        PHFetchResult* fetchResult  = [PHAsset fetchAssetsInAssetCollection:collection options:options];
        if (fetchResult.count < 1) continue;
        [assetsGroups addObject:[TINPHAssetsGroup groupWithResult:fetchResult name:collection.localizedTitle]];
    }
    //完成回调
    completion(assetsGroups);
}

- (BOOL)authorizationStatusAuthorized{
    return [PHPhotoLibrary authorizationStatus] == PHAuthorizationStatusAuthorized;
}

@end
