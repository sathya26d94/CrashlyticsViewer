//
//  MOC.m
//  BugzBook
//
//  Created by SaTHYa on 11/04/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//

#import "MOC.h"

@interface MOC()
@property(strong, nonatomic) NSManagedObjectContext *masterManagedObjectContext;
@property(strong, nonatomic) NSManagedObjectContext *childManagedObjectContext;
@property(strong, nonatomic) NSManagedObjectContext *child2ManagedObjectContext;
@property(strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property(strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(readonly, copy) NSDictionary *managedObjectModelEntities;
@end


@implementation MOC

@synthesize masterManagedObjectContext = _masterManagedObjectContext;
@synthesize childManagedObjectContext = _childManagedObjectContext;
@synthesize child2ManagedObjectContext = _child2ManagedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;


#pragma mark -Sigleton method
+ (MOC *)sharedInstance {
    static dispatch_once_t once;
    static MOC *dataBaseDAOObject;
    dispatch_once(&once, ^{
        dataBaseDAOObject = [[self alloc] init];
    });
    return dataBaseDAOObject;
}

#pragma mark -class initialization method
- (id)init {
    self = [super init];
    return self;
}

#pragma mark -Public methods
- (NSManagedObjectContext *)masterManagedObjectContext {
    if (_masterManagedObjectContext != nil) {
        return _masterManagedObjectContext;
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil) {
        _masterManagedObjectContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [_masterManagedObjectContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
        [_masterManagedObjectContext performBlockAndWait:^{
            [_masterManagedObjectContext setPersistentStoreCoordinator:coordinator];
        }];
    }
    return _masterManagedObjectContext;
}

- (NSManagedObjectContext *) childManagedObjectContext {
    if (_childManagedObjectContext != nil) {
        return _childManagedObjectContext;
    }
    _childManagedObjectContext = [self newManagedObjectContext];
    return _childManagedObjectContext;
}

- (NSManagedObjectContext *) child2ManagedObjectContext {
    if (_child2ManagedObjectContext != nil) {
        return _child2ManagedObjectContext;
    }
    _child2ManagedObjectContext = [self newManagedObjectContext];
    return _child2ManagedObjectContext;
}

- (NSManagedObjectContext *)newManagedObjectContext {
    NSManagedObjectContext *newContext = nil;
    NSManagedObjectContext *masterContext = [self masterManagedObjectContext];
    if (masterContext != nil) {
        newContext = [[NSManagedObjectContext alloc]initWithConcurrencyType:NSPrivateQueueConcurrencyType];
        [newContext setMergePolicy:NSMergeByPropertyObjectTrumpMergePolicy];
        [newContext performBlockAndWait:^{
            [newContext setParentContext:masterContext];
        }];
    }
    return newContext;
}

- (void)saveMasterContext:(SuccessBlock)successBlock error:(FailureBlock)failureBlock {
    [self.masterManagedObjectContext performBlock:^{
        NSError *error = nil;
        [self.masterManagedObjectContext save:&error];
        if (error) {
            failureBlock([error localizedDescription]);
        }else {
            successBlock(@"Success");
        }
    }];
}

- (void)saveChildContext:(SuccessBlock)successBlock error:(FailureBlock)failureBlock {
    [self.childManagedObjectContext performBlock:^{
        NSError *error = nil;
        [self.childManagedObjectContext save:&error];
        if (error) {
            failureBlock([error localizedDescription]);
        }else {
            successBlock(@"Success");
        }
    }];
}

- (void)saveChild2Context:(SuccessBlock)successBlock error:(FailureBlock)failureBlock {
    [self.child2ManagedObjectContext performBlock:^{
        NSError *error = nil;
        [self.child2ManagedObjectContext save:&error];
        if (error) {
            failureBlock([error localizedDescription]);
        }else {
            successBlock(@"Success");
        }
    }];
}

- (NSManagedObjectModel *)managedObjectModel {
    if (_managedObjectModel != nil) {
        return _managedObjectModel;
    }
    NSURL *managedObjectModelUrl = [[NSBundle bundleForClass:[self class]] URLForResource:@"BugzBook" withExtension:@"momd"];
    _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:managedObjectModelUrl];
    return _managedObjectModel;
}

- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
    if (_persistentStoreCoordinator != nil) {
        return _persistentStoreCoordinator;
    }
    
    _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    [self addPersistentStore];
    return _persistentStoreCoordinator;
}

- (void)readDataInContext:(NSManagedObjectContext *)managedObjectContext fetchRequest:(NSFetchRequest *)fetchRequest withSuccess:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    __block NSArray *recordsArray = nil;
    [managedObjectContext performBlock:^{
        NSError *error = nil;
        recordsArray = [managedObjectContext executeFetchRequest:fetchRequest error:&error];
        if (!error){
            successBlock(recordsArray);
        } else {
            failureBlock([error localizedDescription]);
        }
    }];
}

- (void)flushTable:(NSString *)tableName inManagedContext:(NSManagedObjectContext *)managedObjectContext withSuccess:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    [self batchDeleteForTable:tableName forPredicate:nil inManagedContext:managedObjectContext withSuccess:^(id responseObjects) {
        successBlock(responseObjects);
    } failure:^(NSString *failureReason) {
        failureBlock(failureReason);
    }];
}

- (void)batchDeleteForTable:(NSString *)tableName forPredicate:(NSPredicate *)predicate inManagedContext:(NSManagedObjectContext *)managedObjectContext withSuccess:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
        if(![self isEntityExists:tableName]) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock([NSString stringWithFormat:@"Table not found: %@`",tableName]);
            });
            return;
        }
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:tableName];
        if(predicate) {
            [fetchRequest setPredicate:predicate];
        }
        NSBatchDeleteRequest *deleteRequest =  [[NSBatchDeleteRequest alloc] initWithFetchRequest:fetchRequest];
        NSError *error = nil;
        [[self persistentStoreCoordinator] executeRequest:deleteRequest withContext:managedObjectContext error:&error];
        if(!error) {
            [self saveContextAndMasterContext:managedObjectContext success:^(id responseObjects) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    successBlock(responseObjects);
                });
            } error:^(NSString *failureReason) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    failureBlock(failureReason);
                });
            }];
        }else {
            dispatch_async(dispatch_get_main_queue(), ^{
                failureBlock([error localizedDescription]);
            });
        }
    });
}

- (void)saveContext:(NSManagedObjectContext*)managedObjectContext  success:(SuccessBlock)successBlock error:(FailureBlock)failureBlock {
    [managedObjectContext performBlock:^{
        NSError *error = nil;
        [managedObjectContext save:&error];
        if (error) {
            failureBlock([error localizedDescription]);
        }else {
            successBlock(@"success");
        }
    }];
}

- (void)saveContextAndMasterContext:(NSManagedObjectContext*)managedObjectContext success:(SuccessBlock)successBlock error:(FailureBlock)failureBlock {
    [self saveContext:managedObjectContext success:^(id responseObjects) {
        [self saveMasterContext:^(id responseObjects) {
            successBlock(responseObjects);
        } error:^(NSString *failureReason) {
            failureBlock(failureReason);
        }];
    } error:^(NSString *failureReason) {
        failureBlock(failureReason);
    }];
}

- (NSDictionary *)getModelEntities {
    if(!_managedObjectModelEntities) {
        _managedObjectModelEntities = [self managedObjectModel].entitiesByName;
    }
    return _managedObjectModelEntities;
}

- (BOOL)isEntityExists:(NSString*)entityName {
    return ([[self getModelEntities] objectForKey:entityName]!=nil);
}

#pragma mark -Private methods
- (void)addPersistentStore {
    NSURL *storeURL = [[[[NSFileManager defaultManager]URLsForDirectory:NSLibraryDirectory inDomains:NSUserDomainMask] lastObject] URLByAppendingPathComponent:[@"BugzBook" stringByAppendingPathExtension:@"sqlite"]];
    NSError *error = nil;
    NSDictionary *options = [NSDictionary dictionaryWithObjectsAndKeys:
                             [NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption,
                             [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
    
    if (![_persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:options error:&error]) {
        abort();
    }
    NSDictionary *fileAttributes = [NSDictionary dictionaryWithObject:NSFileProtectionComplete forKey:NSFileProtectionKey];
    [[NSFileManager defaultManager]setAttributes:fileAttributes ofItemAtPath:[storeURL path] error:nil];
    
}

@end