//
//  UILabel+Label.h
//  BugzBook
//
//  Created by SaTHYa on 13/04/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel(Label)
-(void)setTitleTheme;
-(void)setTitleCellTheme;
-(void)setBodyCellTheme;
- (void)attributedText:(NSString*)firstText firstTextFont: (UIFont*)firstTextFont firstTextColor:(UIColor*)firstTextColor secondText:(NSString*)secondText secondTextFont: (UIFont*)secondTextFont secondTextColor:(UIColor*)secondTextColor;
@end
