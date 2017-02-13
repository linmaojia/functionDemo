//
//  YZGMineTableHeadView.h
//  yzg
//
//  Created by LXY on 16/6/1.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

/*标签View*/
@interface LZCustomPhotoTitleBgView : UIView

@property (nonatomic,copy) void(^cellClickBlack)(NSInteger index);

@property (nonatomic,copy) void(^bgClickBlack)();


@property (nonatomic, strong) NSMutableArray *dataArray;

- (void)dismissTableView;
@end
