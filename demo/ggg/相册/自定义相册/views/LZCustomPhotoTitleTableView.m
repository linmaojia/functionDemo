//
//  YZGShopProduductTableView.m
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import "LZCustomPhotoTitleTableView.h"
#import "LZCustomPhotoTitleTableCell.h"
#import "LZPhotoModel.h"
#import <Photos/Photos.h>
@interface LZCustomPhotoTitleTableView ()<UITableViewDelegate,UITableViewDataSource>


@end
@implementation LZCustomPhotoTitleTableView

#pragma ******************* init
- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    if (self = [super initWithFrame:frame style:style])
    {
        self.delegate = self;
        self.dataSource = self;
        
        [self registerClass:[LZCustomPhotoTitleTableCell class] forCellReuseIdentifier:NSStringFromClass([self class])];

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
    
    LZCustomPhotoTitleTableCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class]) forIndexPath:indexPath];
    cell.model = self.dataArray[indexPath.row];
    return cell;
    
}
#pragma ******************* UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for(LZPhotoModel *model in self.dataArray)
    {
       model.isSelect = NO;
    }
    
    LZPhotoModel *model = self.dataArray[indexPath.row];
    
    model.isSelect = YES;


    if(self.cellClickBlack)
    {
        self.cellClickBlack(indexPath.row);
    }

}

@end
