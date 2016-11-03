//
//  YZGShopProduductTableView.h
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YZGPhoneTableView : UITableView
@property (nonatomic, copy) void (^showBlock)(NSString *text);
@property (nonatomic, strong) NSArray *phones;

- (instancetype)initWithView:(UIView *)view titleArray:(NSArray *)titleArray;

- (void)showDropDow;

//隐藏
-(void)hideDropDown;

@end
