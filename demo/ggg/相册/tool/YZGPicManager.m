//
//  GetOrderList.m
//  ggg
//
//  Created by LXY on 16/9/24.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGPicManager.h"

@interface YZGPicManager ()

@end
@implementation YZGPicManager

- (CGFloat)getHeightWithImgArray:(NSArray *)imgArray
{
    CGFloat height = 0;
    
    CGFloat space = 10;
    
    CGFloat cellWidth = (SCREEN_WIDTH - 40)/3;
    
    NSInteger imgCount = imgArray.count;
    
    NSInteger row = 0;
    if(imgCount>0 &&imgCount<=3)
    {
        row = 1;
    }
    else if(imgCount>3 &&imgCount<=6)
    {
        row = 2;
    }
    else if(imgCount>6 &&imgCount<=9)
    {
        row = 3;
    }
   
    height = (cellWidth + space) *row + space;
    
    return height;
}

@end
