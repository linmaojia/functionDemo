//
//  YZGShopProduductTableView.h
//  YZGShopInformation
//
//  Created by 李超 on 16/6/9.
//  Copyright © 2016年 lichao. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface LZCustomPhotoTitleTableView : UITableView

@property (nonatomic, strong) NSMutableArray *dataArray;  

@property (nonatomic,copy) void(^cellClickBlack)(NSInteger index);

@end
