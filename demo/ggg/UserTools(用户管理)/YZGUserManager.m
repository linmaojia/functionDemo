//
//  UserManager.m
//  Masonry
//
//  Created by LXY on 16/5/28.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import "YZGUserManager.h"

#define ETUserFilepath [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:@"YZGuser.data"]
@implementation YZGUserManager




/*保存用户模型*/
+ (void)saveUser:(YZGUser *)user
{
    [NSKeyedArchiver archiveRootObject:user toFile:ETUserFilepath];
}



/*取出用户模型*/
+ (YZGUser *)user
{
    YZGUser *user = [NSKeyedUnarchiver unarchiveObjectWithFile:ETUserFilepath];
    
    return user;
}

@end
