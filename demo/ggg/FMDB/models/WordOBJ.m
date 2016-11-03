//
//  WordOBJ.m
//  FMDB
//
//  Created by ibokan on 16/1/26.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import "WordOBJ.h"
#import "FMDB.h"
#define TableName @"CollectionTable"
#define docPath [ NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0]
#define dbName @"long.db"



@implementation WordOBJ



/*查询数据*/
+(NSMutableArray *)selectWordFormLocalDB
{
    NSMutableArray *array=[NSMutableArray arrayWithCapacity:10];
  
    NSString *dbPath=[docPath stringByAppendingPathComponent:dbName];
    
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    
    if ([db open])
    {
        //order by name desc 按名称倒序查询
        NSString * sql = [NSString stringWithFormat:
                          @"SELECT * FROM %@ order by name desc",TableName];
        FMResultSet * rs = [db executeQuery:sql];
        while ([rs next])
        {
            
            NSString * name = [rs stringForColumn:@"name"];
            NSString * text = [rs stringForColumn:@"text"];
            NSString * age = [rs stringForColumn:@"age"];
            
            NSDictionary *dic=@{@"name":name,@"text":text,@"age":age};
            [array addObject:dic];
            
        }
        [db close];
    }
    return array;
}

/*插入数据库*/
+(BOOL)insertWordToLocalDB:(WordOBJ *)word
{
   BOOL res;
   NSString *dbPath=[docPath stringByAppendingPathComponent:dbName];
    NSLog(@"%@",dbPath);
    //创建数据库  当数据库文件不存在时，fmdb会自己创建一个。
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open])
    {//打开数据库：
      
    NSUserDefaults *user=[NSUserDefaults standardUserDefaults];
        NSString *str= [user objectForKey:@"isFirst"];
        if(str==nil)
        {
          [user setObject:@"1" forKey:@"isFirst"];
            
           NSString *sqlCreateTable =  [NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS '%@' ('%@' text PRIMARY KEY , '%@' TEXT, '%@'TEXT)",TableName,@"name",@"text",@"age"];
            res = [db executeUpdate:sqlCreateTable];//创建表
            //PRIMARY KEY 主键 不能有重复值
            if (!res)
            {
                NSLog(@"error when creating db table");
            }
            else
            {
                NSLog(@"success to creating db table");
            }
      
        }
        
        //插入数据到数据库
        NSString *insertSql= [NSString stringWithFormat:
                              @"INSERT INTO '%@' ('%@', '%@', '%@') VALUES ('%@', '%@', '%@')",TableName,@"name",@"text",@"age", word.name, word.text, word.age];
        res = [db executeUpdate:insertSql];
        [db close];//关闭数据库
   
    }
      return res;
    
}
/*删除数据*/
+(BOOL)deleteWordFormLocalDB:(NSString *)wordName
{
    BOOL res;
    NSString *dbPath=[docPath stringByAppendingPathComponent:dbName];
    FMDatabase *db = [FMDatabase databaseWithPath:dbPath];
    if ([db open])
    {
        
        NSString *deleteSql = [NSString stringWithFormat:
                               @"delete from %@ where %@ = '%@'",
                               TableName, @"name", wordName];
        res = [db executeUpdate:deleteSql];
        
        if (!res)
        {
            NSLog(@"error when delete db table");
        }
        else
        {
            NSLog(@"success to delete db table");
        }
        [db close];
        
    }
    return res;
}

@end
