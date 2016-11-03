//
//  YZGShopProduductTableView.m
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import "YZGPhoneTableView.h"
@interface YZGPhoneTableView ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic, assign)CGRect viewRect;

@end
@implementation YZGPhoneTableView
#pragma ******************* init

- (instancetype)initWithView:(UIView *)view titleArray:(NSArray *)titleArray
{
    _viewRect = CGRectMake(view.frame.origin.x, view.frame.origin.y + view.frame.size.height, view.frame.size.width, 0);

    if (self = [super initWithFrame:_viewRect style:UITableViewStylePlain])
    {
        self.delegate = self;
        self.dataSource = self;
        
        self.backgroundColor = [UIColor grayColor];
        self.showsVerticalScrollIndicator = NO;
        
        self.phones = titleArray;
        
     
    }
    return self;
  
}
- (void)showDropDow
{
    
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frames = self.frame;
        
        frames.size.height = 100;
        
        self.frame = frames;
    }];
}
- (void)hideDropDown
{
  
    [UIView animateWithDuration:0.3 animations:^{
        
        CGRect frames = self.frame;
        
        frames.size.height = 0;
        
        self.frame = frames;
        
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
    
}
- (void)setProducts:(NSArray *)products
{
    _phones = products;
    [self reloadData];
}
#pragma ******************* UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.phones.count;
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellIden];
    }
    cell.textLabel.text = self.phones[indexPath.row];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//去掉点击效果
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 30;
}

#pragma ******************* UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.showBlock)
    {
        self.showBlock(self.phones[indexPath.row]);
        [self hideDropDown];
        
    }
}
@end
