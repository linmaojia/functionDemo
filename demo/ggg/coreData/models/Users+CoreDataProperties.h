//
//  Users+CoreDataProperties.h
//  
//
//  Created by LXY on 16/11/3.
//
//

#import "Users+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface Users (CoreDataProperties)

+ (NSFetchRequest<Users *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *name;
@property (nullable, nonatomic, copy) NSString *age;

@end

NS_ASSUME_NONNULL_END
