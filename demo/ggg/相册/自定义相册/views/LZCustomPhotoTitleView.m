//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZCustomPhotoTitleView.h"

@interface LZCustomPhotoTitleView()
{
  CGFloat img_H;
}
@property (nonatomic, strong) UIImageView *leftImg;
@property (nonatomic, assign) BOOL flag;


@end

@implementation LZCustomPhotoTitleView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {

        img_H = 20;
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(titleClick)];
        [self addGestureRecognizer:tap];
        
        [self addSubviewsForView];
        
        [self addConstraintsForView];
        
    }
    return self;
}
#pragma mark ************** 懒加载控件
- (UIImageView *)leftImg {
    if (!_leftImg) {
        _leftImg = [[UIImageView alloc] init];
        _leftImg.image = [UIImage imageNamed:@"chu"];
    }
    return _leftImg;
}
- (UILabel *)titleLab {
    if (!_titleLab) {
        _titleLab = [[UILabel alloc] init];
        _titleLab.textAlignment = NSTextAlignmentRight;
        _titleLab.font = systemFont(16);
        _titleLab.text = @"查看详情";
        _titleLab.textColor = [UIColor whiteColor];
        
    }
    return _titleLab;
}
- (void)titleClick
{

   [self showImgAnimations];
    
    if(self.titleClickBlack)
    {
        self.titleClickBlack(_flag);
    }
    
}
- (void)setPhotoName:(NSString *)photoName
{
    _titleLab.text = photoName;

    [self showImgAnimations];
    
    
    //计算文本宽度
    CGFloat stringWidth = [_titleLab.text widthWithText:_titleLab.text constrainedToHeight:self.frame.size.height LabFont:_titleLab.font];
    
    stringWidth = stringWidth + 5;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        _titleLab.frame = CGRectMake((self.frame.size.width - stringWidth - img_H)/2, 0, stringWidth, self.frame.size.height);
        _leftImg.frame = CGRectMake(_titleLab.frame.origin.x + _titleLab.frame.size.width +5, (self.frame.size.height - img_H)/2, img_H, img_H);
        
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
    
}
- (void)showImgAnimations
{
     _flag = !_flag;
    
    [UIView animateWithDuration:0.3f animations:^{
        self.leftImg.transform = CGAffineTransformRotate(self.leftImg.transform,M_PI);
    } completion:^(BOOL finished) {
        if (finished) {
        }
    }];
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
    [self addSubview:self.titleLab];
    [self addSubview:self.leftImg];

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    
    _titleLab.frame = CGRectMake(0, 0, 100, self.frame.size.height);
    
    _leftImg.frame = CGRectMake(110, (self.frame.size.height - img_H)/2, img_H, img_H);
    
    NSLog(@"---%lf",_titleLab.center.y);
}

@end
