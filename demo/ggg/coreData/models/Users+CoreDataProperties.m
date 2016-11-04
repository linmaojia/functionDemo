//
//  Users+CoreDataProperties.m
//  
//
//  Created by LXY on 16/11/3.
//
//

#import "Users+CoreDataProperties.h"

@implementation Users (CoreDataProperties)

+ (NSFetchRequest<Users *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"Users"];
}

@dynamic name;
@dynamic age;
@dynamic createtime;
@dynamic tableName;


@end
