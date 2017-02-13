//
//  clodeViewController.m
//  ggg
//
//  Created by LXY on 17/2/11.
//  Copyright © 2017年 AVGD. All rights reserved.
//

#import "PhotoViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "CustomCamera.h"
#import <Photos/Photos.h>
@interface PhotoViewController ()<CustomCameraDelegate>
{
    CustomCamera *_camera;
}
@property (nonatomic, strong) UIView *rightView;    /**< 右侧背景 */
@property (nonatomic, strong) UIButton *takePictureButton;    /**< 拍照按钮 */
@end

@implementation PhotoViewController
- (UIView *)rightView{
    if (_rightView == nil){
        _rightView = [[UIView alloc] init];
        _rightView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.4];
    }
    return _rightView;
}
- (UIButton *)takePictureButton{
    if (_takePictureButton == nil){
        _takePictureButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_takePictureButton setImage:[UIImage imageNamed:@"pld-queren"] forState:UIControlStateNormal];
        [_takePictureButton addTarget:self action:@selector(takePictureButtonAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _takePictureButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];

     [self customCamera];
    
    [self setVIew];
    
   
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}
#pragma mark - 自定义相机
- (void)customCamera
{
    
    UIView *carmeraView = [[UIView alloc] initWithFrame:self.view.bounds];
    [self.view insertSubview:carmeraView atIndex:0];
    
    _camera = [[CustomCamera alloc] init];
    _camera.delegate = self;
    [_camera embedLayerWithView:carmeraView];
    [_camera startCamera];
}
- (void)takePictureButtonAction{

    [_camera takePhoto];
}
-(void)CustomCamera:(CustomCamera *)camera Image:(UIImage *)image{
   
    //保存到相册
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);

}
-(void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *msg = nil ;
    if(error){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
        [self.navigationController popViewControllerAnimated:YES];
        if(self.selectImgBlock)
            self.selectImgBlock(image);
        
    }
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"        message:msg delegate:self  cancelButtonTitle:@"确定" otherButtonTitles:nil];
//    [alert show];
}

- (void)setVIew
{
    [self.view addSubview:self.rightView];
    [self.rightView addSubview:self.takePictureButton];
    
    [self.rightView makeConstraints:^(MASConstraintMaker *make) {
        make.right.left.bottom.equalTo(self.view);
        make.height.mas_equalTo(100);
    }];
    [self.takePictureButton makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.rightView);
        make.size.mas_equalTo(CGSizeMake(80, 80));
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
