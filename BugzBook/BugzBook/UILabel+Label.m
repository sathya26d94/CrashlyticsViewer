//
//  UILabel+Label.m
//  BugzBook
//
//  Created by SaTHYa on 13/04/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//

#import "UILabel+Label.h"

@implementation UILabel(Label)

-(void)setTitleCellTheme {
    self.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    self.textColor = [UIColor blackColor];
    [self applyFontAutoShrink];
    [self applyLineBreak];
}

-(void)setBodyCellTheme {
    self.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    self.textColor = [UIColor colorWithRed:(float)115/255 green:(float)115/255 blue:(float)115/255 alpha:1.0];
    [self applyFontAutoShrink];
    [self applyLineBreak];
}

-(void)applyFontAutoShrink {
    self.adjustsFontSizeToFitWidth = true;
    self.minimumScaleFactor = 0.90;
}

-(void)applyLineBreak {
    self.lineBreakMode =NSLineBreakByWordWrapping;
    self.numberOfLines = 0;
}

-(void)setTitleTheme {
    self.font = [UIFont fontWithName:@"HelveticaNeue" size:14];
    self.textColor = [UIColor whiteColor];
    self.backgroundColor = [UIColor colorWithRed: 35/255 green: 77/255 blue: 109/255 alpha: 1.0];
    self.textAlignment = NSTextAlignmentCenter;
    [self applyFontAutoShrink];
    [self applyLineBreak];
}

- (void)attributedText:(NSString*)firstText firstTextFont: (UIFont*)firstTextFont firstTextColor:(UIColor*)firstTextColor secondText:(NSString*)secondText secondTextFont: (UIFont*)secondTextFont secondTextColor:(UIColor*)secondTextColor {
    NSRange firstTextRange = NSMakeRange(0, firstText.length);
    NSRange secondTextRange = NSMakeRange(firstText.length, secondText.length);
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString: [NSString stringWithFormat:@"%@%@",firstText,secondText]];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:firstTextColor range:firstTextRange];
    [attributedStr addAttribute:NSFontAttributeName value:firstTextFont range:firstTextRange];
    [attributedStr addAttribute:NSForegroundColorAttributeName value:secondTextColor range:secondTextRange];
    [attributedStr addAttribute:NSFontAttributeName value:secondTextFont range:secondTextRange];
    self.attributedText = attributedStr;
}

@end