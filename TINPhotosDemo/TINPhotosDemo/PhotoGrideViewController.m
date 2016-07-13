//
//  PhotoGrideViewController.m
//  TINPhotosDemo
//
//  Created by 张灿 on 16/6/2.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import "PhotoGrideViewController.h"
#import "PhotoGridCollectionViewCell.h"
#import "PhotoDetailViewController.h"

const NSString* CellReuseIdentifier = @"PhotoGridCollectionViewCellReuseIdentifier";
@interface PhotoGrideViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property (strong,nonatomic) TINAssetsGroup* assetsGroup;
@property (strong,nonatomic) UICollectionView* collectionView;
@property (strong,nonatomic) NSArray<TINAsset *> *assets;
@end

@implementation PhotoGrideViewController

-initWithAssetsGroup:(TINAssetsGroup*)assetsGroup{

    if (self = [super init]) {
        _assetsGroup = assetsGroup;
        }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.assetsGroup.name;
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.collectionView];
    
  
}

-(void)viewWillAppear:(BOOL)animated{

    [super viewWillAppear:animated];
      __weak PhotoGrideViewController* weakSelf = self;
    [self.assetsGroup getAssetsWithCompletion:^(NSArray<TINAsset *> *assets) {
        weakSelf.assets = assets;
        [weakSelf.collectionView reloadData];
    }];

}

#pragma mark- UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
     TINAsset *asset = [self.assets objectAtIndex:indexPath.item];
    PhotoDetailViewController* vc = [[PhotoDetailViewController alloc]initWithAsset:asset];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark- UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TINAsset *asset = self.assets[indexPath.item];
    // Dequeue an AAPLGridViewCell.
    PhotoGridCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellReuseIdentifier.copy forIndexPath:indexPath];
    
    [asset getThumbnailPhotoWithCompletion:^(UIImage *thumbnail) {
        cell.imageView.image = thumbnail;
//        [cell layoutSubviews];
    }];
    
    return cell;
}

-(UICollectionView *)collectionView{

    if (!_collectionView) {
        UICollectionViewFlowLayout* layout = [[UICollectionViewFlowLayout alloc]init];
        CGFloat itemSizeWidth = [UIScreen mainScreen].bounds.size.width/4-1;
        layout.itemSize = CGSizeMake(itemSizeWidth, itemSizeWidth);
        layout.minimumLineSpacing = 1;
        layout.minimumInteritemSpacing = 1;
        _collectionView = [[UICollectionView alloc]initWithFrame:self.view.bounds collectionViewLayout:layout];
        [_collectionView registerClass:[PhotoGridCollectionViewCell class] forCellWithReuseIdentifier:CellReuseIdentifier.copy];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
    }
    return _collectionView;
}

-(NSArray<TINAsset *> *)assets{

    if (!_assets) {
        _assets = [[NSArray alloc]init];
    }
    return _assets;
}


@end
