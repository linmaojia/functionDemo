//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGDataController.h"
#import "YZGPhoneTableView.h"
#import "YZGUserManager.h"
#import "YZGUser.h"

#define PHONE_LIST @"PHONE_LIST"

@interface YZGDataController ()
@property (nonatomic, strong) YZGUser *user;      /**< 用户数据 */
@property(nonatomic, strong) YZGPhoneTableView *phoneTableView;

@end

@implementation YZGDataController

#pragma mark ************** 懒加载控件

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
   
}
#pragma mark ************** 设置导航栏
- (void)setNav
{
    self.title = @"新建/编辑收货地址";
    self.view.backgroundColor = RGB(235, 235, 241);

}
- (void)backAction
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark ************** 归档
- (IBAction)saveBtn:(id)sender {
    
    _user.userlogno = self.textFied.text;
    
    [YZGUserManager saveUser:_user];
}
#pragma mark ************** 反归档
- (IBAction)readBtn:(id)sender {
    
    _user = [YZGUserManager user];

    if(!_user)
    {
        _user = [[YZGUser alloc]init];
    }
    self.textFied.text = _user.userlogno;
}
#pragma mark ************** 保存电话号码
- (IBAction)saveNS:(id)sender {
    
    
    NSMutableArray *phoneListArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:PHONE_LIST]];
    
    if(!phoneListArray)
    {
        phoneListArray = [NSMutableArray new];
    }
    
    if ([phoneListArray containsObject:self.textFied.text])
    {
        [phoneListArray removeObject:self.textFied.text];
        [phoneListArray insertObject:self.textFied.text atIndex:0];
    }
    else
    {
        [phoneListArray insertObject:self.textFied.text atIndex:0];
    }
    
    [[NSUserDefaults standardUserDefaults] setObject:phoneListArray forKey:PHONE_LIST];
    [[NSUserDefaults standardUserDefaults] synchronize];

    
}
#pragma mark ************** 读取电话号码
- (IBAction)readNs:(id)sender
{
    
    NSMutableArray *phoneListArray = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:PHONE_LIST]];
    
    if(!phoneListArray)
    {
        phoneListArray = [NSMutableArray new];
    }
    _phoneTableView = [[YZGPhoneTableView alloc]initWithView:self.textFied titleArray:phoneListArray];
    [self.view addSubview: _phoneTableView];
    [_phoneTableView showDropDow];
    ESWeakSelf;
    _phoneTableView.showBlock = ^(NSString *text){
        
        __weakSelf.textFied.text = text;
    };
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
    if([self.view.subviews containsObject:_phoneTableView])
    {
        [_phoneTableView hideDropDown];
    }
}


#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   

}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    
}
@end
