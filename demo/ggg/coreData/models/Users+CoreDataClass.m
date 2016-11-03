//
//  Users+CoreDataClass.m
//  
//
//  Created by LXY on 16/11/3.
//
//

#import "Users+CoreDataClass.h"
#import "AppDelegate.h"
@implementation Users
//插入数据
+(BOOL)insertGifModel:(NSDictionary *)gifmodelDic{
    BOOL flag = NO;
    
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    
    Users *footModel = [NSEntityDescription insertNewObjectForEntityForName:@"Users" inManagedObjectContext:context];
    
    footModel.name = gifmodelDic[@"name"];
    footModel.age = gifmodelDic[@"age"];
    
    [appdelegate saveContext];
    NSError *error = nil;
    if ([context save:&error])
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
//查询所有数据
+(NSMutableArray *)find{
    NSMutableArray *array = [NSMutableArray array];
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:description];
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error) {
        [array addObjectsFromArray:datas];
    }
    return array;
}
+(BOOL)deleteGifModelWithString:(NSString *)string
{
    BOOL flag = NO;
    
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:description];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name like %@ ",string];
    
    [request setPredicate:predicate];
    
    flag = [Users deleteGifModel:request];
    
    return flag;
}
+(BOOL)deleteGifModel:(NSFetchRequest *)fetchRequst
{
    BOOL flag = NO;
    
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:fetchRequst error:&error];
    if (!error && datas.count > 0) {
        for (int i = 0; i < datas.count; i++) {
            
            //删除满足条件的gifmodel
            [context deleteObject:datas[i]];
            [appdelegate saveContext];
            
            if ([context save:&error]) {
                NSLog(@"msg = 删除成功");
                flag = YES;
            }else{
                NSLog(@"error = %@",error.debugDescription);
                flag = NO;
            }
        }
        
    }
    
    return flag;
}
+(BOOL)deleteAll
{
    BOOL flag = NO;
    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    NSManagedObjectContext *context = delegate.managedObjectContext;
    NSEntityDescription *description = [NSEntityDescription entityForName:@"Users" inManagedObjectContext:context];
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setIncludesPropertyValues:NO];
    [request setEntity:description];
    flag = [Users deleteGifModel:request];
    
    return flag;
}
+(NSMutableArray *)findWithFetchRequest:(NSFetchRequest *)request
{
    
    
    NSMutableArray *array = [NSMutableArray array];
    AppDelegate *appdelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSManagedObjectContext *context = appdelegate.managedObjectContext;
    
    NSError *error = nil;
    NSArray *datas = [context executeFetchRequest:request error:&error];
    if (!error) {
        [array addObjectsFromArray:datas];
    }
    return array;
}


@end
