//
//  WBCoreDataStack.h
//  Weiben
//
//  Created by wenguang pan on 12/3/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

@interface WBCoreDataStack : NSObject

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (instancetype)shareStack;
+ (void)setup;
+ (void)setupWithStoreURL:(NSURL *)storeURL modelURL:(NSURL *)modelURL iCloudContainerID:(NSString *)iCloudContainerID;

- (void)saveContext;

@end
