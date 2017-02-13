//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface LZCustomPhotoTitleView : UIView

@property (nonatomic,copy) void(^titleClickBlack)(BOOL flag);   

@property (nonatomic, strong) NSString *photoName;  

@property (nonatomic, strong) UILabel *titleLab;      /**<  标题 */

- (void)showImgAnimations;
@end
