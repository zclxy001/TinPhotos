//
//  PhotoGridCollectionViewCell.m
//  TINPhotosDemo
//
//  Created by 张灿 on 16/6/2.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import "PhotoGridCollectionViewCell.h"


@interface PhotoGridCollectionViewCell ()
@property (strong,readwrite,nonatomic) UIImageView* imageView;
@end
@implementation PhotoGridCollectionViewCell

-(instancetype)initWithFrame:(CGRect)frame{

    if (self = [super initWithFrame:frame]) {
        
        [self addSubview:self.imageView];
    }
    return self;
}


-(void)layoutSubviews{
    [super layoutSubviews];
     self.imageView.frame = self.bounds;
    
}


-(UIImageView *)imageView{
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc]init];
        _imageView.contentMode = UIViewContentModeScaleAspectFill;
        _imageView.clipsToBounds = YES;
    }
    return _imageView;
}
@end
