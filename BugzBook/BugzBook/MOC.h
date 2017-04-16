//
//  MOC.h
//  BugzBook
//
//  Created by SaTHYa on 11/04/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface MOC : NSObject


typedef void (^SuccessBlock)(id responseObjects);
typedef void (^FailureBlock)(NSString* failureReason);
+ (MOC *)sharedInstance;
- (NSManagedObjectContext *)childManagedObjectContext;
- (NSManagedObjectContext *)child2ManagedObjectContext;
- (NSManagedObjectContext *)newManagedObjectContext;
- (void)saveMasterContext:(SuccessBlock)successBlock error:(FailureBlock)failureBlock;
- (void)saveChildContext:(SuccessBlock)successBlock error:(FailureBlock)failureBlock;
- (void)saveChild2Context:(SuccessBlock)successBlock error:(FailureBlock)failureBlock;
- (void)readDataInContext:(NSManagedObjectContext*)managedObjectContext fetchRequest:(NSFetchRequest*)fetchRequest withSuccess:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;
- (void)flushTable:(NSString*)tableName inManagedContext:(NSManagedObjectContext*)managedObjectContext withSuccess:(SuccessBlock)successBlock failure:(FailureBlock)failureBlock;
@end
