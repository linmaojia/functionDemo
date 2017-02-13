//
//  clodeViewController.h
//  ggg
//
//  Created by LXY on 17/2/11.
//  Copyright © 2017年 AVGD. All rights reserved.
//

#import "YZGRootViewController.h"

@interface PhotoViewController : YZGRootViewController
/**图片回调*/
@property (nonatomic,copy) void(^selectImgBlock)(UIImage *image);
@end
