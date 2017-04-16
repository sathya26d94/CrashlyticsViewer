//
//  ProgressHUD.m
//  BugzBook
//
//  Created by SaTHYa on 11/04/17.
//  Copyright © 2017 SaTHYa. All rights reserved.
//

#import <Foundation/Foundation.h>
//
//  ProgressHUD.m
//  MyClassTest
//
//  Created by cocoa on 13-9-6.
//  Copyright (c) 2013年 cocoajin. All rights reserved.
//

#import "ProgressHUD.h"

#define kWindow [[UIApplication sharedApplication].windows objectAtIndex:0]


@interface ProgressHUD ()

@end

@implementation ProgressHUD

{
    UIActivityIndicatorView *activiView;
    UIViewController *rootVC;
}

+ (ProgressHUD *)sharedHud {
    static ProgressHUD *sharedHud = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedHud = [[self alloc]initWithFrame:CGRectZero];
    });
    return  sharedHud;
}


- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        rootVC = [self getRootViewController];
        [self setUpUI];
        [self addHudOnWindow];
    }
    return self;
}


+ (void)showHUD {
    [[ProgressHUD sharedHud] show];
}

+ (void)closeHUD {
    [[ProgressHUD sharedHud] close];
}

- (void)show {
    self.alpha = 1;
    [activiView startAnimating];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    rootVC.view.userInteractionEnabled = NO;
    rootVC.view.alpha = 0.7;
}

- (void)close {
    rootVC.view.userInteractionEnabled = YES;
    [self closeAnimation];
    rootVC.view.alpha = 1;
}

- (void)closeAnimation {
    [UIView animateWithDuration:0.4 animations:^{
        self.alpha = 0;
        
    }];
    [NSTimer scheduledTimerWithTimeInterval:0.4 target:self selector:@selector(closeTheActivi) userInfo:nil repeats:NO];
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
}

- (void)closeTheActivi {
    [activiView stopAnimating];
}

- (void)setUpUI {
    int top = [self marginTop];
    self.frame = CGRectMake(140, top, 110, 35);
    self.backgroundColor = [UIColor clearColor];
    self.alpha = 0;
    
    activiView  =[[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(23, 17.5, 0, 0)];
    activiView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhite;
    activiView.color = [UIColor whiteColor];
    [self addSubview:activiView];
    
}

- (UIViewController *)getRootViewController {
    return ((UIWindow *)[[UIApplication sharedApplication].windows objectAtIndex:0]).rootViewController;
}

- (void)addHudOnWindow {
    [kWindow addSubview:self];
}

- (CGFloat)marginTop {
    return [UIScreen mainScreen].bounds.size.height/2 + kMarginTop;
}

- (void)drawRect:(CGRect)rect {
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    UIGraphicsPushContext(context);
    
    CGRect boxRect = self.bounds;
    float radius = 10.0f;
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect));
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMinY(boxRect) + radius, radius, 3 * (float)M_PI / 2, 0, 0);
    CGContextAddArc(context, CGRectGetMaxX(boxRect) - radius, CGRectGetMaxY(boxRect) - radius, radius, 0, (float)M_PI / 2, 0);
    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMaxY(boxRect) - radius, radius, (float)M_PI / 2, (float)M_PI, 0);
    CGContextAddArc(context, CGRectGetMinX(boxRect) + radius, CGRectGetMinY(boxRect) + radius, radius, (float)M_PI, 3 * (float)M_PI / 2, 0);
    CGContextClosePath(context);
    CGContextFillPath(context);
    UIGraphicsPopContext();
}


- (void)lifeCycle {
    activiView=nil;
    rootVC = nil;
}

- (void)dealloc {

}

@end