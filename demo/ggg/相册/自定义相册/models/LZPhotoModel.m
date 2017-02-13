//
//  YZGProductDetailModel.m
//  yzg
//
//  Created by EDS on 16/6/13.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "LZPhotoModel.h"

@implementation LZPhotoModel

+ (instancetype)productListModelWithDict:(NSDictionary *)dict
{
    return [[LZPhotoModel alloc] initWithDict:dict];
}
- (instancetype)initWithDict:(NSDictionary *)dict
{
    if (self = [super init])
    {
        if (![dict isKindOfClass:[NSNull class]])
        {
            [self setValuesForKeysWithDictionary:dict];
        }
    }
    return self;
}
//避免出现键值对不匹配导致崩溃
- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

@end
