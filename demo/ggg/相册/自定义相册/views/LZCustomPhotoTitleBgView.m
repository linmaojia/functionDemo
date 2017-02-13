//
//  YZGMineTableHeadView.m
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZCustomPhotoTitleBgView.h"
#import "LZCustomPhotoTitleTableView.h"
@interface LZCustomPhotoTitleBgView()<UIGestureRecognizerDelegate>
{
    
    CGFloat self_width,self_height,tableView_H;//按钮背景高度
}
@property (nonatomic, strong) UIView *btnBgView;   /**< 按钮背景 */
@property (nonatomic, strong) LZCustomPhotoTitleTableView *tableView;

@end

@implementation LZCustomPhotoTitleBgView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
       
        self.backgroundColor = RGBA(0, 0, 0, 0);
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismiss)];
        
        self.userInteractionEnabled = YES;
        
        tap.delegate = self;
        
        [self addGestureRecognizer:tap];
        
        self_width = self.frame.size.width;
        
        self_height = self.frame.size.height;

        [self addSubviewsForView];
        
        [self addConstraintsForView];

    }
    return self;
}
#pragma mark ************** 懒加载控件
- (LZCustomPhotoTitleTableView *)tableView
{
    if (!_tableView)
    {
        ESWeakSelf;
        _tableView = [[LZCustomPhotoTitleTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.cellClickBlack = ^(NSInteger index){
            if( __weakSelf.cellClickBlack)
            {
                __weakSelf.cellClickBlack(index);
            }
            
            [__weakSelf dismissTableView];
         
        };
    }
    return _tableView;
}

#pragma mark ************** 创建按钮
- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    _tableView.dataArray = dataArray;
    
    [self show];
    
}


#pragma mark ************** 消失
- (void)dismiss
{
    [UIView animateWithDuration:0.4f  animations:^{
        
        [self setBackgroundColor:RGBA(0, 0, 0, 0)];
        
        _tableView.frame = CGRectMake(0, -tableView_H, self_width, tableView_H);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
    
    if(self.bgClickBlack)
    {
        self.bgClickBlack();
    }

}
- (void)dismissTableView
{
    [UIView animateWithDuration:0.4f  animations:^{
        
        [self setBackgroundColor:RGBA(0, 0, 0, 0)];
        
        _tableView.frame = CGRectMake(0, -tableView_H, self_width, tableView_H);
        
    } completion:^(BOOL finished) {
        
        [self removeFromSuperview];
        
    }];
}
#pragma mark ************** 显示
- (void)show
{
    
    [UIView animateWithDuration:0.3f animations:^{
        
       self.backgroundColor = RGBA(0, 0, 0, 0.5);
        
       _tableView.frame = CGRectMake(0, 0, self_width, tableView_H);
        
        
    } completion:nil];
    
    
}
#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   [self addSubview:self.tableView];
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
     tableView_H = (SCREEN_HEIGHT - 64)/2;
    
     _tableView.frame = CGRectMake(0, -tableView_H, self_width, tableView_H);
    
}
#pragma mark ************** 手势和TableView 点击起冲突
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch
{
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]) {
        return NO;
    }
    return  YES;
}
@end
