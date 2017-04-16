//
//  NSArray+Array.m
//  BugzBook
//
//  Created by SaTHYa on 11/04/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//

#import "NSDate+Date.h"

@implementation NSDate(Date)

static NSDateFormatter *GITFormat;

- (void)setGITDateFormat {
        NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
        formatter.calendar = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierISO8601];
        formatter.locale = [NSLocale  localeWithLocaleIdentifier:@"en_US_POSIX"];
        formatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX";
        GITFormat = formatter;
}

- (NSString*)getGITDateString {
    [self setGITDateFormat];
    return [GITFormat stringFromDate:self];
}

@end
