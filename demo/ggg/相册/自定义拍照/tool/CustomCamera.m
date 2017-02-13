//
//  CustomCamera.m
//  UI-Photo
//
//  Created by ibokan on 16/2/29.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "CustomCamera.h"
#import <ImageIO/ImageIO.h>
@implementation CustomCamera




@synthesize deviceInput = _deviceInput;


//出事化CustomCamera
-(id)init{
    
    if (self = [super init]) {
        
        //生成会话，用来结合输入输出
        _session = [[AVCaptureSession alloc] init];
        
        //设置捕获照片的质量
        //AVCaptureSessionPreset1920x1080 为全屏的照片
        //AVCaptureSessionPresetPhoto 按比例分配
        [_session setSessionPreset:AVCaptureSessionPreset1920x1080];//输出图片的大小
        
        
        //创建设备 AVMediaTypeVideo  指明self.device代表视频，默认使用后置摄像头进行初始化
        _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
        
       //根据设备创建输入信号
        NSError *error;
        _deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:_device error:&error];
        
        //抛出异常
        if (error) {
            if (self.delegate && [self.delegate conformsToProtocol:@protocol(CustomCameraDelegate)]) {
                [self.delegate CustomCamera:self FailedWithError:error];
            }
        }
        
        //session添加设备输入信号
        if ([_session canAddInput:_deviceInput]) {
            [_session addInput:_deviceInput];
            
        }
        
        //添加 输出设备 默认 拍摄照片
        _deviceImageOutput = [[AVCaptureStillImageOutput alloc] init];
        
        //设置输出照片类型
        //[_deviceImageOutput setOutputSettings:@{AVVideoCodecKey:AVVideoCodecJPEG,AVVideoQualityKey:@(1.0)}];
        
        
        if ([_session canAddOutput:_deviceImageOutput]) {
            [_session addOutput:_deviceImageOutput];
        }
        
    }
    
    return self;
    
}


//初始化显示层
-(void)embedLayerWithView:(UIView *)view{
    
    if (_session == nil) {
        return;
    }
    _videoPreviewLayer = [AVCaptureVideoPreviewLayer layerWithSession:_session];
    //设置layer大小
    _videoPreviewLayer.frame = view.layer.bounds;
    //layer填充状态
    _videoPreviewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    //设置摄像头朝向
    _videoPreviewLayer.connection.videoOrientation = AVCaptureVideoOrientationPortrait;
    
    [view.layer addSublayer:_videoPreviewLayer];
   
}
-(void)startCamera{
    
    [_session startRunning];
}
-(void)stopCamera{
    
    [_session stopRunning];
}
-(void)setCameraOrientation:(UIDeviceOrientation)deviceOrientation{
    
    switch (deviceOrientation) {
        case UIDeviceOrientationPortrait:
        {
            _imageOrientation = UIImageOrientationRight;
        }
            break;
        case UIDeviceOrientationPortraitUpsideDown:
        {
            _imageOrientation = UIImageOrientationLeft;
        }
            break;
        case UIDeviceOrientationLandscapeLeft:
        {
            _imageOrientation = UIImageOrientationDown;
        }
            break;
        case UIDeviceOrientationLandscapeRight:
        {
            _imageOrientation = UIImageOrientationUp;
        }
            break;
            
        default:
            break;
    }
    
}
-(void)takePhoto{
    
     [self setCameraOrientation:[UIDevice currentDevice].orientation];
    
    AVCaptureConnection *conntion = [_deviceImageOutput connectionWithMediaType:AVMediaTypeVideo];
    [conntion setVideoOrientation:AVCaptureVideoOrientationPortrait];
    if (!conntion) {
        NSLog(@"拍照失败!");
        return;
    }
    [_deviceImageOutput captureStillImageAsynchronouslyFromConnection:conntion completionHandler:^(CMSampleBufferRef imageDataSampleBuffer, NSError *error) {
        if (imageDataSampleBuffer == nil) {
            return ;
        }
        NSData *imageData = [AVCaptureStillImageOutput jpegStillImageNSDataRepresentation:imageDataSampleBuffer];
        UIImage *image = [UIImage imageWithData:imageData];
        //UIImage * resutlImage = [[UIImage alloc]initWithCGImage:image.CGImage scale:1.0 orientation:_imageOrientation];
        [_session stopRunning];
  
        if(![YZGDataManage isCanUsePhotos])//没有访问权限
        {
            return;
        }
        
        if (self.delegate &&[self.delegate conformsToProtocol:@protocol(CustomCameraDelegate)]) {
              [self.delegate CustomCamera:self Image:image];
        }
     }];

}


//切换摄像头
-(void)toggleCamera:(AVCaptureDevicePosition)curDevicePosition{
    
    if (curDevicePosition == AVCaptureDevicePositionBack) {
        AVCaptureDevice *changeDevice;
        for (AVCaptureDevice *theDevice in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
            if (theDevice.position == AVCaptureDevicePositionFront) {
                changeDevice = theDevice;
            }
        }
        [_session beginConfiguration];
        [_session removeInput:self.deviceInput];
        
        self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:changeDevice error:nil];
        if ([_session canAddInput:self.deviceInput]) {
            [_session addInput:self.deviceInput];
        }
        
        [_session commitConfiguration];
        
    }else if(curDevicePosition == AVCaptureDevicePositionFront){
        AVCaptureDevice *changeDevice;
        for (AVCaptureDevice *theDevice in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
            if (theDevice.position == AVCaptureDevicePositionBack) {
                changeDevice = theDevice;
            }
        }
        [_session beginConfiguration];
        [_session removeInput:self.deviceInput];
        
        self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:changeDevice error:nil];
        if ([_session canAddInput:self.deviceInput]) {
            [_session addInput:self.deviceInput];
        }
        [_session commitConfiguration];
    }else{
        AVCaptureDevice *changeDevice;
        for (AVCaptureDevice *theDevice in [AVCaptureDevice devicesWithMediaType:AVMediaTypeVideo]) {
            if (theDevice.position == AVCaptureDevicePositionBack) {
                changeDevice = theDevice;
            }
        }
        [_session beginConfiguration];
        [_session removeInput:self.deviceInput];
        
        self.deviceInput = [AVCaptureDeviceInput deviceInputWithDevice:changeDevice error:nil];
        if ([_session canAddInput:self.deviceInput]) {
            [_session addInput:self.deviceInput];
        }
        [_session commitConfiguration];
    }
    
}

//打开闪光灯
-(void)touchLightWithFlashMode:(AVCaptureFlashMode)flashMode{
    //改变设备的所有设置之前必须要加此句代码：_device lockForConfiguration:&error
    NSError *error;
    if ( [self.deviceInput.device lockForConfiguration:&error]) {
        [self.deviceInput.device setFlashMode:flashMode];
        
    }else{
        NSLog(@"error = %@",error.debugDescription);
    }
    
}


@end



