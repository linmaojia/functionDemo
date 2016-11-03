//
//  Users+CoreDataClass.h
//  
//
//  Created by LXY on 16/11/3.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

NS_ASSUME_NONNULL_BEGIN

@interface Users : NSManagedObject
//插入数据
+(BOOL)insertGifModel:(NSDictionary *)gifmodelDic;
//查找所有数据
+(NSMutableArray *)find;
//根据条件删除数据
+(BOOL)deleteGifModel:(NSFetchRequest *)fetchRequst;
//删除所有数据
+(BOOL)deleteAll;
//根据条件查找所有数据
+(NSMutableArray *)findWithFetchRequest:(NSFetchRequest *)request;


+(BOOL)deleteGifModelWithString:(NSString *)string;
@end

NS_ASSUME_NONNULL_END

#import "Users+CoreDataProperties.h"
