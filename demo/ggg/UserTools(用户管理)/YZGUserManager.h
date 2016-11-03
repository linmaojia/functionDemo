//
//  UserManager.h
//  Masonry
//
//  Created by LXY on 16/5/28.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "YZGUser.h"
@interface YZGUserManager : NSObject

/*保存用户模型*/
+ (void)saveUser:(YZGUser *)user;

/*取出用户模型*/
+ (YZGUser *)user;

@end
