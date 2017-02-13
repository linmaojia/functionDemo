//
//  YZGProductDetailModel.h
//  yzg
//
//  Created by EDS on 16/6/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Photos/Photos.h>
@interface LZPhotoModel : NSObject

@property (nonatomic, strong) PHAssetCollection *PHAssetCollection;
@property (nonatomic, assign) BOOL isSelect;

+ (instancetype)productListModelWithDict:(NSDictionary *)dict;
@end
