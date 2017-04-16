//
//  Issues+CoreDataProperties.h
//  BugzBook
//
//  Created by SaTHYa on 11/04/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Issues.h"

NS_ASSUME_NONNULL_BEGIN

@interface Issues (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *body;
@property (nullable, nonatomic, retain) NSString *comments_url;
@property (nullable, nonatomic, retain) NSString *title;
@property (nullable, nonatomic, retain) NSString *updated_at;

@end

NS_ASSUME_NONNULL_END
