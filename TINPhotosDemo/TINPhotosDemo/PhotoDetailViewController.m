//
//  PhotoDetailViewController.m
//  TINPhotosDemo
//
//  Created by 张灿 on 16/6/3.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import "PhotoDetailViewController.h"


@interface PhotoDetailViewController ()

@property (strong,nonatomic) UIImageView* imgv;
@property (strong,nonatomic) TINAsset* asset;

@end


@implementation PhotoDetailViewController

-(instancetype)initWithAsset:(TINAsset*)asset{

    if (self = [super init]) {
        _asset = asset;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.imgv];
    __weak PhotoDetailViewController* weakSelf = self;
    [self.asset getPhotoWithCompletion:^(UIImage *photo, NSDictionary *info, BOOL isInCloud) {
        weakSelf.imgv.image = photo;
    }];
}

-(UIImageView *)imgv{

    if (_imgv == nil) {
        
        _imgv = [[UIImageView alloc]initWithFrame:self.view.bounds];
    }
    return _imgv;
}

@end
