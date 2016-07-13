//
//  ViewController.m
//  TINPhotosDemo
//
//  Created by 张灿 on 16/5/30.
//  Copyright © 2016年 FDD. All rights reserved.
//

#import "ViewController.h"
#import "TINPhotos.h"
#import "PhotoGrideViewController.h"

@interface ViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (strong,nonatomic) UITableView* tableView;

@property (strong,nonatomic) TINAssetsLibrary* assetsLibrary;

@property (strong,nonatomic) NSArray<TINAssetsGroup*>* assetsGroups;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"相册列表";    
    [self.view addSubview:self.tableView];
    __weak ViewController* weakSelf = self;
    [self.assetsLibrary getAllAssetsGroupsWithCompletion:^(NSArray<TINAssetsGroup *> *groups) {
        weakSelf.assetsGroups = groups;
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark- UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.assetsGroups.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    NSString* cellid = @"cellid";
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellid];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.imageView.contentMode = UIViewContentModeScaleAspectFill;
        cell.imageView.clipsToBounds = YES;
    }
    TINAssetsGroup* assetsGroup = [self.assetsGroups objectAtIndex:indexPath.row];
    cell.textLabel.text = assetsGroup.name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%ld张",assetsGroup.count];
    [assetsGroup getPostImageWithWithCompletion:^(UIImage *postImage) {
        cell.imageView.image = postImage;
        [cell layoutSubviews];
    }];
   
    return cell;
}

#pragma mark- UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{

    return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

    TINAssetsGroup* assetsGroup = [self.assetsGroups objectAtIndex:indexPath.row];
    PhotoGrideViewController* vc = [[PhotoGrideViewController alloc]initWithAssetsGroup:assetsGroup];
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark- setter,getter Methods
-(UITableView *)tableView{

    if (!_tableView) {
        _tableView = [[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

-(TINAssetsLibrary *)assetsLibrary{

    if (!_assetsLibrary) {
        _assetsLibrary = [[TINAssetsLibrary alloc]init];
    }
    return _assetsLibrary;
}

-(NSArray<TINAssetsGroup *> *)assetsGroups{

    if (!_assetsGroups) {
        _assetsGroups = [[NSArray alloc]init];
    }
    return _assetsGroups;
}

@end
