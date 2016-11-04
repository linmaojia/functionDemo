//
//  CoreDataManager.h
//  ggg
//
//  Created by LXY on 16/11/4.
//  Copyright © 2016年 AVGD. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreDataManager : NSObject

@property (nonatomic, strong, readonly)NSManagedObjectContext *managedObjectContext;

@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;

@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (CoreDataManager *)sharedInstance;

- (void)saveContext;

@end
