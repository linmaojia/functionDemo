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

/*插入数据*/
+(BOOL)insertModel:(NSMutableDictionary *)model;

/*删除某条数据*/
+(BOOL)deleteModel:(NSMutableDictionary *)model;

/*查找所有数据*/
+(NSMutableArray *)selectAllDataWithTableName:(NSString *)tableName;

/*删除所有数据*/
+(BOOL)deleteAllData;



/*根据条件查找数据*/
+(NSMutableArray *)findWithFetchRequest:(NSFetchRequest *)request;



@end

NS_ASSUME_NONNULL_END

#import "Users+CoreDataProperties.h"
