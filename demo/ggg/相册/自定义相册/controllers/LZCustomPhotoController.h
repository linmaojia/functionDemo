//
//  YZGUserSettingViewController.h
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"
/**< 商品详情 */
@interface LZCustomPhotoController : YZGRootViewController
/**图片回调*/
@property (nonatomic,copy) void(^selectImgBlock)(UIImage *image);


@end
