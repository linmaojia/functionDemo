//
//  CustomCamera.h
//  UI-Photo
//
//  Created by ibokan on 16/2/29.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import <UIKit/UIKit.h>
//协议
@class CustomCamera;
@protocol CustomCameraDelegate <NSObject>
@optional
-(void)CustomCamera:(CustomCamera *)camera Image:(UIImage *)image;

-(void)CustomCamera:(CustomCamera *)camera FailedWithError:(NSError *)error;

@end



@interface CustomCamera : NSObject

{
    //会话层
    AVCaptureSession *_session;
    //创建 配置输入设备
    AVCaptureDevice *_device;
    //输入信号
    AVCaptureDeviceInput *_deviceInput;
    //输出信号
    AVCaptureStillImageOutput *_deviceImageOutput;
    //显示层
    AVCaptureVideoPreviewLayer *_videoPreviewLayer;
    //图片朝向
    UIImageOrientation _imageOrientation;
}


@property (nonatomic,assign)id<CustomCameraDelegate>delegate;
@property (nonatomic,strong)AVCaptureDeviceInput *deviceInput;
//开始拍摄
-(void)startCamera;
//停止拍摄
-(void)stopCamera;
//将摄像头拍摄到画面 嵌入到view当中  layer层
-(void)embedLayerWithView:(UIView *)view;
//拍照
-(void)takePhoto;
//切换摄像头
-(void)toggleCamera:(AVCaptureDevicePosition)curDevicePosition;
//闪光灯
-(void)touchLightWithFlashMode:(AVCaptureFlashMode)flashMode;
@end
