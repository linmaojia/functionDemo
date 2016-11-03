//
//  YZGShopProduductTableView.m
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import "YZGCoreTableView.h"
#import "Users+CoreDataClass.h"
@interface YZGCoreTableView ()<UITableViewDelegate,UITableViewDataSource>


@end
@implementation YZGCoreTableView

#pragma ******************* init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor colorWithHexColorString:@"f9f9f9"];
        
    }
    return self;
}

- (void)setDataArray:(NSMutableArray *)dataArray
{
    _dataArray = dataArray;
    
    [self reloadData];
}

#pragma mark ************** UITableView 代理方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return  self.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 50;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIden = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIden];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:(UITableViewCellStyleValue1) reuseIdentifier:cellIden];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;//去掉点击效果
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;//右边尖括号
    
    Users *user = _dataArray[indexPath.row];
    cell.textLabel.text = user.name;
    return cell;
    
//    YZGProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ProductListCell" forIndexPath:indexPath];
//    cell.model = self.dataArray[indexPath.row];
//    return cell;
    
}
#pragma ******************* UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
//    ProductDetail *productDetail = self.dataArray[indexPath.row];
//    NSString *productId = productDetail.seqid;
//    
//    if(self.cellClickBlack)
//    {
//        self.cellClickBlack(productId);
//    }
}
@end
