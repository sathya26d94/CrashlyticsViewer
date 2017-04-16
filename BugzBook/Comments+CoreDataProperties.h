//
//  Comments+CoreDataProperties.h
//  BugzBook
//
//  Created by SaTHYa on 11/04/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Comments.h"

NS_ASSUME_NONNULL_BEGIN

@interface Comments (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *body;
@property (nullable, nonatomic, retain) NSString *login;

@end

NS_ASSUME_NONNULL_END
