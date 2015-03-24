//
//  WBCoreDataStack.m
//  Weiben
//
//  Created by wenguang pan on 12/3/14.
//  Copyright (c) 2014 wenguang. All rights reserved.
//

#import "WBCoreDataStack.h"
#import "WBUtility.h"

static dispatch_once_t oneToken;
static WBCoreDataStack *shareStack = nil;

@interface WBCoreDataStack()

@property (strong, nonatomic) NSURL *storeURL;
@property (strong, nonatomic) NSURL *modelURL;
@property (copy, nonatomic) NSString *iCloudContainerID;

- (void)configure;

@end

@implementation WBCoreDataStack

+ (instancetype)shareStack
{
    return shareStack;
}

#pragma mark - Setup

+ (void)setup
{
    dispatch_once(&oneToken, ^{
        
        shareStack = [[WBCoreDataStack alloc] init];
        shareStack.storeURL = [[WBUtility applicationDocumentsDirectory] URLByAppendingPathComponent:@"Weiben.sqlite"];
        [shareStack configure];
    });
}

+ (void)setupWithStoreURL:(NSURL *)storeURL modelURL:(NSURL *)modelURL iCloudContainerID:(NSString *)iCloudContainerID
{
    dispatch_once(&oneToken, ^{
        
        shareStack = [[WBCoreDataStack alloc] init];
        shareStack.storeURL = storeURL;
        shareStack.modelURL = modelURL;
        shareStack.iCloudContainerID = iCloudContainerID;
        [shareStack configure];
    });
}

#pragma mark - Private methods

- (void)configure
{
    // Create model
    if (_modelURL)
    {
        _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:_modelURL];
    }
    else
    {
        _managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
    }
    
    // Create coordinator
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:_managedObjectModel];
    
    
    // iCloud notification subscriptions
    if (_iCloudContainerID)
    {
        NSNotificationCenter *dc = [NSNotificationCenter defaultCenter];
        [dc addObserver:self
               selector:@selector(storesWillChange:)
                   name:NSPersistentStoreCoordinatorStoresWillChangeNotification
                 object:_persistentStoreCoordinator];
        
        [dc addObserver:self
               selector:@selector(storesDidChange:)
                   name:NSPersistentStoreCoordinatorStoresDidChangeNotification
                 object:_persistentStoreCoordinator];
        
        [dc addObserver:self
               selector:@selector(persistentStoreDidImportUbiquitousContentChanges:)
                   name:NSPersistentStoreDidImportUbiquitousContentChangesNotification
                 object:_persistentStoreCoordinator];
    }
    
    NSError *error = nil;
    NSString *failureReason = @"There was an error creating or loading the application's saved data.";
    BOOL succeed;
    
    // Add store
    if (_iCloudContainerID)
    {
        succeed = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                            configuration:nil
                                                                      URL:_storeURL
                                                                  options:@{ NSPersistentStoreUbiquitousContentNameKey : _iCloudContainerID }
                                                                    error:&error];
    }
    else
    {
        succeed = [_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType
                                                            configuration:nil
                                                                      URL:_storeURL
                                                                  options:nil
                                                                    error:&error];
    }
    if (!succeed)
    {
        // Report any error we got.
        NSMutableDictionary *dict = [NSMutableDictionary dictionary];
        dict[NSLocalizedDescriptionKey] = @"Failed to initialize the application's saved data";
        dict[NSLocalizedFailureReasonErrorKey] = failureReason;
        dict[NSUnderlyingErrorKey] = error;
        error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
        // Replace this with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
    
    // Create context
    _managedObjectContext = [[NSManagedObjectContext alloc] initWithConcurrencyType:NSMainQueueConcurrencyType];
    _managedObjectContext.undoManager = nil;
    [_managedObjectContext setPersistentStoreCoordinator:_persistentStoreCoordinator];
}


#pragma mark - iCloud notification responses

// Subscribe to NSPersistentStoreDidImportUbiquitousContentChangesNotification
- (void)persistentStoreDidImportUbiquitousContentChanges:(NSNotification*)note
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSLog(@"%@", note.userInfo.description);
    
    NSManagedObjectContext *moc = self.managedObjectContext;
    [moc performBlock:^{
        [moc mergeChangesFromContextDidSaveNotification:note];
        
        // you may want to post a notification here so that which ever part of your app
        // needs to can react appropriately to what was merged.
        // An exmaple of how to iterate over what was merged follows, although I wouldn't
        // recommend doing it here. Better handle it in a delegate or use notifications.
        // Note that the notification contains NSManagedObjectIDs
        // and not NSManagedObjects.
        NSDictionary *changes = note.userInfo;
        NSMutableSet *allChanges = [NSMutableSet new];
        [allChanges unionSet:changes[NSInsertedObjectsKey]];
        [allChanges unionSet:changes[NSUpdatedObjectsKey]];
        [allChanges unionSet:changes[NSDeletedObjectsKey]];
        
        for (NSManagedObjectID *objID in allChanges) {
            // do whatever you need to with the NSManagedObjectID
            // you can retrieve the object from with [moc objectWithID:objID]
        }
        
    }];
}

// Subscribe to NSPersistentStoreCoordinatorStoresWillChangeNotification
// most likely to be called if the user enables / disables iCloud
// (either globally, or just for your app) or if the user changes
// iCloud accounts.
- (void)storesWillChange:(NSNotification *)note {
    NSManagedObjectContext *moc = self.managedObjectContext;
    [moc performBlockAndWait:^{
        NSError *error = nil;
        if ([moc hasChanges]) {
            [moc save:&error];
        }
        
        [moc reset];
    }];
    
    // now reset your UI to be prepared for a totally different
    // set of data (eg, popToRootViewControllerAnimated:)
    // but don't load any new data yet.
}

// Subscribe to NSPersistentStoreCoordinatorStoresDidChangeNotification
- (void)storesDidChange:(NSNotification *)note {
    // here is when you can refresh your UI and
    // load new data from the new store
}

#pragma mark - API

- (void)saveContext
{
    NSManagedObjectContext *moc = self.managedObjectContext;
    if (moc != nil)
    {
        NSError *error = nil;
        if ([moc hasChanges])
        {
            BOOL succeed = [moc save:&error];
            if (succeed)
            {
                NSLog(@"CoreData Stack save succeeded");
            }
            else
            {
                NSLog(@"CoreData Stack unresolved error %@, %@", error, [error userInfo]);
                //abort();
            }
        }
    }
}

@end
