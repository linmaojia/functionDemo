//
//  Users+CoreDataClass.m
//  
//
//  Created by LXY on 16/11/3.
//
//

#import "Users+CoreDataClass.h"
#import "CoreDataManager.h"

#define kManagedObjectContext [CoreDataManager sharedInstance].managedObjectContext
@implementation Users

/*插入数据*/
+(BOOL)insertModel:(NSMutableDictionary *)model
{
     BOOL flag = NO;
    
    //获取模型
    Users *courseEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:kManagedObjectContext];
    
    courseEntity.name = model[@"name"];
    
    courseEntity.age = model[@"age"];
    
    courseEntity.createtime = [NSDate date];
    
    courseEntity.tableName = model[@"tableName"];//用于分辨多个表
    
    [[CoreDataManager sharedInstance] saveContext]; //插入 保存
    
    NSError *error = nil;
    
    if ([kManagedObjectContext save:&error])
    {
        NSLog(@"msg = 插入成功");
        flag = YES;
    }
    else
    {
        NSLog(@"error = %@",error.debugDescription);
        flag = NO;
    }
    return flag;

}
/*查询所有数据*/
+(NSMutableArray *)selectAllDataWithTableName:(NSString *)tableName
{
    NSMutableArray *array = [NSMutableArray array];
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:kManagedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setIncludesPropertyValues:NO];
    
    [request setEntity:description];
    
    //查询条件
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"tableName = %@ " ,tableName];//按条件查询
    
    [request setPredicate:predicate];

    //根据创建时间倒序查询
    NSSortDescriptor* sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"createtime" ascending:NO];//ascending 是否升序,NO 为降序
    [request setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
    
    
    NSError *error = nil;
    
    NSArray *datas = [kManagedObjectContext executeFetchRequest:request error:&error];
    
    if (!error)
    {
        [array addObjectsFromArray:datas];
    }
    return array;
}


/**
 删除某条数据

 @param string 字段名称

 @return BOOL 布尔类型
 */
+(BOOL)deleteModel:(NSDictionary *)model
{
    NSString *tableName = model[@"tableName"];
    
    NSString *name = model[@"name"];

    
    BOOL flag = NO;
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:kManagedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setIncludesPropertyValues:NO];
    
    [request setEntity:description];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name = %@ && tableName = %@ " ,name,tableName];//按条件查询
    
    [request setPredicate:predicate];
    
    flag = [self deleteGifModel:request];
    
    return flag;

}


/**
  删除某条数据

 @param fetchRequst 请求体

 @return BOOL 布尔类型
 */
+(BOOL)deleteGifModel:(NSFetchRequest *)fetchRequst
{
    BOOL flag = NO;

    NSError *error = nil;
    
    NSArray *datas = [kManagedObjectContext executeFetchRequest:fetchRequst error:&error];
    
    if (!error && datas.count > 0)
    {
        for (int i = 0; i < datas.count; i++)
        {
            //删除满足条件的gifmodel
            [kManagedObjectContext deleteObject:datas[i]];
            
            [[CoreDataManager sharedInstance] saveContext]; //插入 保存
            
            if ([kManagedObjectContext save:&error])
            {
                NSLog(@"msg = 删除成功");
                flag = YES;
            }
            else
            {
                NSLog(@"error = %@",error.debugDescription);
                flag = NO;
            }
        }
        
    }
    
    return flag;
}
+(BOOL)deleteAllData
{
    BOOL flag = NO;
   
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:kManagedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    
    [request setIncludesPropertyValues:NO];
    
    [request setEntity:description];
    
    flag = [self deleteGifModel:request];
    
    return flag;
}


+(NSMutableArray *)findWithFetchRequest:(NSFetchRequest *)request
{
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSError *error = nil;
    NSArray *datas = [kManagedObjectContext executeFetchRequest:request error:&error];
    if (!error) {
        [array addObjectsFromArray:datas];
    }
    return array;
}


@end
