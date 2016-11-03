//
//  WordOBJ.h
//  FMDB
//
//  Created by ibokan on 16/1/26.
//  Copyright © 2016年 ibokan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WordOBJ : NSObject
@property (nonatomic,strong)NSString *name;
@property (nonatomic,strong)NSString *text;
@property (nonatomic,strong)NSString *age;

/*插入数据库*/
+(BOOL)insertWordToLocalDB:(WordOBJ *)word;

/*删除数据*/
+(BOOL)deleteWordFormLocalDB:(NSString *)wordName;

/*查询数据*/
+(NSMutableArray *)selectWordFormLocalDB;
@end
