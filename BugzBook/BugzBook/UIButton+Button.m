//
//  UIButton+Button.m
//  BugzBook
//
//  Created by SaTHYa on 13/04/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//

#import "UIButton+Button.h"

@implementation UIButton (Button)

-(void)setDefaultTheme{
    self.backgroundColor = [UIColor colorWithRed:35/255 green:77/255 blue:109/255 alpha:1.0];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}
@end
