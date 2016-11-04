//
//  YZGUserSettingViewController.m
//  yzg
//
//  Created by LXY on 16/6/2.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGCoreController.h"
#import "Users+CoreDataClass.h"
#import "YZGCoreTableView.h"
@interface YZGCoreController ()
@property (strong, nonatomic) IBOutlet UITextField *textFild;
@property (nonatomic, strong) YZGCoreTableView *tableView;

@end

@implementation YZGCoreController

#pragma mark ************** 懒加载控件
- (YZGCoreTableView *)tableView
{
    if (!_tableView)
    {
        ESWeakSelf;
        _tableView = [[YZGCoreTableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.cellClickBlack = ^(NSString *text){
            __weakSelf.textFild.text = text;
        };
    }
    return _tableView;
}
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
#pragma mark ************** 获取数据
- (void)getData
{
    
}
- (IBAction)insert:(id)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.textFild.text forKey:@"name"];
    [dic setValue:@"gg" forKey:@"age"];
    [dic setValue:@"table_1" forKey:@"tableName"];

    [Users insertModel:dic];
}
- (IBAction)select:(id)sender {
    
    NSMutableArray *array =  [Users selectAllDataWithTableName:@"table_1"];
    Users *gif = array[0];
    
    _tableView.dataArray = array;
    NSLog(@"-------%@",gif.tableName);
}
- (IBAction)delete:(id)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.textFild.text forKey:@"name"];
    [dic setValue:@"table_1" forKey:@"tableName"];
    
    [Users deleteModel:dic];
    
    _tableView.dataArray = [Users selectAllDataWithTableName:@"table_1"];
}

///////////////////////////////////////////////////////////
- (IBAction)inser2:(id)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.textFild.text forKey:@"name"];
    [dic setValue:@"table_2" forKey:@"tableName"];
    
    [Users insertModel:dic];
}
- (IBAction)selec2:(id)sender {
    
    NSMutableArray *array =  [Users selectAllDataWithTableName:@"table_2"];
    
    _tableView.dataArray = array;
}
- (IBAction)delete2:(id)sender {
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    [dic setValue:self.textFild.text forKey:@"name"];
    [dic setValue:@"table_2" forKey:@"tableName"];
    
    [Users deleteModel:dic];
    
    _tableView.dataArray = [Users selectAllDataWithTableName:@"table_2"];
}



#pragma mark ************** 添加子控件
- (void)addSubviewsForView
{
   
    [self.view addSubview:self.tableView];
    
    
   
}
#pragma mark ************** 添加约束
- (void)addConstraintsForView
{
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.height.equalTo(@(200));
    }];
}
@end
