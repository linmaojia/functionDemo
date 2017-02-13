//
//  GetOrderList.h
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LZCustomPhotoManager : NSObject

@property (nonatomic,strong) NSMutableArray * assetNameArr;//相片集名称数组

/* 获取所有图片*/
- (NSMutableArray *)getAllPhotoArr;
@end
