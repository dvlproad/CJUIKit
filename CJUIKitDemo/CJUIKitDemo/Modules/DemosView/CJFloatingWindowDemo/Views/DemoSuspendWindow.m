//
//  DemoSuspendWindow.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoSuspendWindow.h"
#import "DemoSuspendWindowRootViewController.h"
#import "CJSuspendWindowManager.h"


@interface DemoSuspendWindow () {
    
}
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *clickButton;

@end




@implementation DemoSuspendWindow

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.windowLevel = 1000000;
    self.clipsToBounds = YES;
    
    self.backgroundColor = [UIColor lightGrayColor];
    self.cjDragEnable = YES;
    [self setCjDragBeginBlock:^(UIView *view) {
        
    }];
    [self setCjDragEndBlock:^(UIView *view) {
        [view cjKeepBounds];
    }];
    
    
    UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
    
    self.rootViewController = [[DemoSuspendWindowRootViewController alloc] init];
    [self makeKeyAndVisible];
    
    UIButton *clickButton = [[UIButton alloc] initWithFrame:CGRectZero];
    clickButton.userInteractionEnabled = YES;
    clickButton.backgroundColor = [UIColor colorWithRed:0.21f green:0.45f blue:0.88f alpha:1.00f];
    clickButton.alpha = .7;
    clickButton.titleLabel.font = [UIFont systemFontOfSize:14];
    clickButton.layer.borderColor = [UIColor whiteColor].CGColor;
    clickButton.layer.borderWidth = 1.0;
    clickButton.clipsToBounds = YES;
    [clickButton setTitle:@"悬浮球" forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(clickWindow:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:clickButton];
    self.clickButton = clickButton;
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectZero];
    closeButton.userInteractionEnabled = YES;
    closeButton.backgroundColor = [UIColor colorWithRed:0.97 green:0.30 blue:0.30 alpha:1.00];
    closeButton.alpha = .7;
    closeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    closeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    closeButton.layer.borderWidth = 1.0;
    closeButton.clipsToBounds = YES;
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeWindow:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:closeButton];
    self.closeButton = closeButton;
    
    // Keep the original keyWindow and avoid some unpredictable problems
//    UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
    [currentKeyWindow makeKeyWindow];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.frame);
    CGFloat height = CGRectGetHeight(self.frame);
    
    //clickButton
    self.clickButton.frame = CGRectMake(0, 0, width, height);
    CGFloat shortLength = MIN(CGRectGetWidth(self.clickButton.frame), CGRectGetHeight(self.clickButton.frame));
    self.clickButton.layer.cornerRadius = shortLength / 2.0;
    
    //closeButton
    self.closeButton.frame = CGRectMake(width-44, 0, 44, 44);
}

- (void)removeFromScreen {
    self.hidden = YES;
    self.rootViewController = nil;
}


#pragma mark - Event
- (void)clickWindow:(UIButton *)clickButton {
    if (self.clickWindowBlock) {
        self.clickWindowBlock(clickButton);
    }
}

- (void)closeWindow:(UIButton *)closeButton {
    if (self.closeWindowBlock) {
        self.closeWindowBlock();
    }
}

@end
