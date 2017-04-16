//
//  SyncEngine.m
//  BugzBook
//
//  Created by SaTHYa on 12/04/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//

#import "SyncEngine.h"

@implementation SyncEngine

#pragma mark -Sigleton method
+ (SyncEngine *)sharedInstance {
    static dispatch_once_t once;
    static SyncEngine *syncObject;
    dispatch_once(&once, ^{
        syncObject = [[self alloc] init];
    });
    return syncObject;
}

#pragma mark -class initialization method
- (id)init {
    self = [super init];
    return self;
}

- (void)fetchFilesAsynchronouslyWithURL:(NSString*)urlString withSuccess:(SuccessBlock)successBlock{
    NSCharacterSet *set = [NSCharacterSet URLQueryAllowedCharacterSet];
    NSString *encodedUrlAsString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:set];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    [[session dataTaskWithURL:[NSURL URLWithString:encodedUrlAsString]
            completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                NSLog(@"RESPONSE: %@",response);
                NSLog(@"DATA: %@",data);
                if (!error) {
                    if ([response isKindOfClass:[NSHTTPURLResponse class]]) {
                        NSError *jsonError;
                        NSDictionary *jsonResponse = [NSJSONSerialization JSONObjectWithData:data options:0 error:&jsonError];
                        if (jsonError) {
                            NSLog(@"Json Error");
                        } else {
                            dispatch_async(dispatch_get_main_queue(), ^{
                                    successBlock(jsonResponse);
                            });
                        }
                    }  else {
                        NSLog(@"web service returning a error");
                    }
                } else {
                    NSLog(@"error : %@", error.description);
                }
            }] resume];
}

- (void)saveIssues:(NSArray*) dataArray withSuccess:(SuccessBlock)successBlock{
     [[MOC sharedInstance] flushTable:@"Issues" inManagedContext:[[MOC sharedInstance]childManagedObjectContext] withSuccess:^(id responseObjects) {
         for (NSDictionary* dict in dataArray) {
            NSManagedObject *transaction = [NSEntityDescription insertNewObjectForEntityForName:@"Issues" inManagedObjectContext:[[MOC sharedInstance]childManagedObjectContext]];
            [transaction setValue:[dict valueForKey:@"title"] forKey:@"title"];
            [transaction setValue:[dict valueForKey:@"body"] forKey:@"body"];
            [transaction setValue:[dict valueForKey:@"comments_url"] forKey:@"comments_url"];
            [transaction setValue:[dict valueForKey:@"updated_at"] forKey:@"updated_at"];
            [[MOC sharedInstance] saveChildContext:^(id responseObjects) {
            } error:^(NSString *failureReason) {
            }];
        }
         successBlock(@"Success");
    } failure:^(NSString *failureReason) {
        
    }];
}

- (void)saveComments:(NSArray*) dataArray withSuccess:(SuccessBlock)successBlock{
    [[MOC sharedInstance] flushTable:@"Comments" inManagedContext:[[MOC sharedInstance]child2ManagedObjectContext] withSuccess:^(id responseObjects) {
        for (NSDictionary* dict in dataArray) {
            NSManagedObject *transaction = [NSEntityDescription insertNewObjectForEntityForName:@"Comments" inManagedObjectContext:[[MOC sharedInstance]child2ManagedObjectContext]];
            [transaction setValue:[[dict valueForKey:@"user"] valueForKey:@"login"] forKey:@"login"];
            [transaction setValue:[dict valueForKey:@"body"] forKey:@"body"];
            
            [[MOC sharedInstance] saveChild2Context:^(id responseObjects) {
            } error:^(NSString *failureReason) {
            }];
        }
        successBlock(@"Success");
    } failure:^(NSString *failureReason) {
        
    }];
}
@end
