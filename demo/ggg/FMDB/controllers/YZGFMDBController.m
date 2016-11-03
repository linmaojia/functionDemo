//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGFMDBController.h"
#import "WordOBJ.h"
#import "YZGFMDBController.h"
@interface YZGFMDBController ()

@end

@implementation YZGFMDBController
#pragma mark ************** 懒加载控件

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setNav];//设置导航栏
    
    [self addSubviewsForView];
    
    [self addConstraintsForView];
    
    [self getData];
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
- (IBAction)insert:(id)sender {
    WordOBJ *wordModel = [WordOBJ new];
    
    wordModel.name=self.textFied.text;
    wordModel.text=@"啊哈哈";
    wordModel.age=@"23";
    
    BOOL n=[WordOBJ insertWordToLocalDB:wordModel];//写入数据
    if(n){
        NSLog(@"插入成功");
      
    }else{
        NSLog(@"插入失败");
    }
   
}
- (IBAction)select:(id)sender {
    
    NSMutableArray *array =[WordOBJ selectWordFormLocalDB];
    if(array > 0)
    {
      NSArray *dataArray = [WordOBJ mj_objectArrayWithKeyValuesArray:array];
      WordOBJ *word = dataArray[0];
        
      self.textView.text = word.name;
    }
    NSLog(@"---%@",array);
}

- (IBAction)delete:(id)sender {
    BOOL n=[WordOBJ deleteWordFormLocalDB:self.textFied.text];//写入数据
    if(n){
        NSLog(@"删除成功");
    }else{
        NSLog(@"删除失败");
    }
}

#pragma mark ************** 获取数据
- (void)getData
{
    
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
