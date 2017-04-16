//
//  SyncEngine.h
//  BugzBook
//
//  Created by SaTHYa on 12/04/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MOC.H"

@interface SyncEngine : NSObject

+ (SyncEngine *)sharedInstance;
- (void)fetchFilesAsynchronouslyWithURL:(NSString*)urlString withSuccess:(SuccessBlock)successBlock;
- (void)saveIssues:(NSArray*) dataArray withSuccess:(SuccessBlock)successBlock;
- (void)saveComments:(NSArray*) dataArray withSuccess:(SuccessBlock)successBlock;
@end
