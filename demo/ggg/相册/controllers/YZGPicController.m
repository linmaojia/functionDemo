//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGPicController.h"
#import "YZGPicManager.h"
#import "CustomAlertView.h"
#import "TZImagePickerController.h"
 #import "YZGPublishController.h"
#import "YZGRootNavigationController.h"
@interface YZGPicController ()<TZImagePickerControllerDelegate>
@property (nonatomic, strong) YZGPicManager *manager;
@property (nonatomic, strong) UIImageView *titleImg;         /**<  图片 */

@end

@implementation YZGPicController

#pragma mark ************** 懒加载控件

- (UIImageView *)titleImg {
    if (!_titleImg) {
        _titleImg = [[UIImageView alloc] init];
        _titleImg.image = [UIImage imageNamed:@"xiangji"];
        _titleImg.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleImgClick:)];
        [_titleImg addGestureRecognizer:tap];
        
    }
    return _titleImg;
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
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ************** 获取数据
- (void)getData
{
    
}
#pragma mark ************** 个人背景被点击
-(void)titleImgClick:(UITapGestureRecognizer *)sender
{
    [CustomAlertView showAlertViewWithTitleArray:@[@"拍照",@"从手机相册选择"] TitleBtnBlock:^(NSString *title) {
        if([title isEqualToString:@"拍照"])
        {
            NSLog(@"拍照");
        }
        else if([title isEqualToString:@"从手机相册选择"])
        {
            NSLog(@"从手机相册选择");
            [self openPhotoAlbum];
        }
    }];
}
#pragma mark ************** 打开手机相册
- (void)openPhotoAlbum
{

    ESWeakSelf;
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:9 delegate:self];
    imagePickerVc.barItemTextColor = [UIColor blackColor];//设置导航栏的按钮文字颜色
    imagePickerVc.navigationBar.tintColor =  [UIColor blackColor];//设置导航栏的按钮图片颜色
    imagePickerVc.allowPickingOriginalPhoto=NO;
    imagePickerVc.allowPickingVideo=NO;
    [self presentViewController:imagePickerVc animated:YES completion:nil];
    
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos,NSArray *assets,BOOL isSelectOriginalPhoto) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
              [__weakSelf puchViewController:photos];
        });
      
        
    }];
    

    
}
- (void)puchViewController:(NSArray *)imgArray
{
    YZGPublishController *vc = [[YZGPublishController alloc]init];
    vc.imgArray = imgArray;
    YZGRootNavigationController *nav = [[YZGRootNavigationController alloc] initWithRootViewController:vc];
    
    [self presentViewController:nav animated:YES completion:^{}];
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self.view addSubview:self.titleImg];
    
   

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_titleImg makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.equalTo(@100);
        make.left.top.equalTo(self.view).offset(20);
    }];
}
@end
