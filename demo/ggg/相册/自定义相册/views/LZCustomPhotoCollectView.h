//
//  YZGMyCollectProduductFootView.h
//  ggg
//
//  Created by LXY on 16/9/6.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LZCustomPhotoCollectView : UICollectionView

@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic,copy) void(^cellClickBlack)(UIImage *editImage); /*cell点击*/
@end
