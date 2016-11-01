//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGPublishController.h"
#import "YZGPicManager.h"
#import "YZGPictuersCollectionView.h"
@interface YZGPublishController ()
@property (nonatomic, strong) YZGPicManager *manager;
@property (nonatomic, strong) YZGPictuersCollectionView  *pictuersView; /* 下边collectionView*/

@end

@implementation YZGPublishController

#pragma mark ************** 懒加载控件
- (YZGPictuersCollectionView *)pictuersView
{
    if (_pictuersView == nil)
    {
        ESWeakSelf;
        CGFloat cellWidth = (self.view.frame.size.width - 40)/3;
        CGFloat cellHeight = cellWidth;
        
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.sectionInset = UIEdgeInsetsMake(10.0f, 10.0f, 0.0f, 10.0f);
        layout.minimumInteritemSpacing = 10;
        layout.minimumLineSpacing = 10;
        layout.itemSize = CGSizeMake(cellWidth, cellHeight);//cell的大小
        _pictuersView = [[YZGPictuersCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        
        _pictuersView.didClick = ^(NSIndexPath *indexPath){
            
            //[__weakSelf actionBtn:indexPath];
        };
        
    }
    return _pictuersView;
}
- (YZGPicManager *)manager {
    if (!_manager) {
        _manager = [[YZGPicManager alloc]init];
    }
    return _manager;
}
- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
    [self getData];
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"新建/编辑收货地址";
    self.view.backgroundColor = RGB(235, 235, 241);
    UIButton  *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftBtn setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(backAction) forControlEvents:UIControlEventTouchUpInside];
    leftBtn.frame = CGRectMake(0, 0, 40, 40);
    [leftBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //将leftItem设置为自定义按钮
    leftBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -40, 0, 0);
    UIBarButtonItem  *leftItem =[[UIBarButtonItem alloc]initWithCustomView: leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    self.navigationController.interactivePopGestureRecognizer.delegate = (id)self;
}
- (void)backAction
{
    [self dismissViewControllerAnimated:YES completion:^{}];
}
#pragma mark ************** 获取数据
- (void)getData
{
    CGFloat picHeight = [self.manager getHeightWithImgArray:self.imgArray];
    
    [_pictuersView updateConstraints:^(MASConstraintMaker *make) {

        make.height.equalTo(@(picHeight));
    }];
    
    self.pictuersView.dataArray = self.imgArray;
}


#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   
    [self.view addSubview:self.pictuersView];
   
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_pictuersView makeConstraints:^(MASConstraintMaker *make) {
      
        make.top.equalTo(self.view).offset(20);
        make.left.right.equalTo(self.view);
        make.height.equalTo(@200);
    }];
}
@end
