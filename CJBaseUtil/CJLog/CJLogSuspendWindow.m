//
//  CJLogSuspendWindow.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJLogSuspendWindow.h"

@interface CJLogSuspendWindow () {
    
}
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *clickButton;

@end




@implementation CJLogSuspendWindow

static CJLogSuspendWindow __strong *_sharedInstance = nil;
static dispatch_once_t onceToken;

+ (CJLogSuspendWindow *)sharedInstance {
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[CJLogSuspendWindow alloc] initWithFrame:CGRectZero];
    });
    return _sharedInstance;
}

///显示
+ (void)showWithFrame:(CGRect)frame {
    [[CJLogSuspendWindow sharedInstance] setFrame:frame];
}

///移除
+ (void)removeFromScreen {
    _sharedInstance.hidden = YES;
    _sharedInstance.rootViewController = nil;
    
    onceToken = 0;
    _sharedInstance = nil;
}

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
    self.rootViewController = [[UIViewController alloc] init];
    self.backgroundColor = [UIColor lightGrayColor];
    
    self.cjDragEnable = YES;
    [self setCjDragBeginBlock:^(UIView *view) {
        NSLog(@"开始拖曳CJLogSuspendWindow");
    }];
    [self setCjDragEndBlock:^(UIView *view) {
        NSLog(@"结束拖曳CJLogSuspendWindow");
        [view cjKeepBounds];
    }];
    
    [self setupViews];
}

- (void)setupViews {
    UIWindow *currentKeyWindow = [UIApplication sharedApplication].keyWindow;
    
    [self makeKeyAndVisible]; //显示
    
    UIButton *clickButton = [[UIButton alloc] initWithFrame:CGRectZero];
    clickButton.userInteractionEnabled = YES;
    clickButton.backgroundColor = [UIColor colorWithRed:0.21f green:0.45f blue:0.88f alpha:1.00f];
    clickButton.alpha = .7;
    clickButton.titleLabel.font = [UIFont systemFontOfSize:14];
    clickButton.layer.borderColor = [UIColor whiteColor].CGColor;
    clickButton.layer.borderWidth = 1.0;
    clickButton.clipsToBounds = YES;
    [clickButton setTitle:NSLocalizedString(@"显示Log", nil) forState:UIControlStateNormal];
     [clickButton setTitle:NSLocalizedString(@"隐藏Log", nil) forState:UIControlStateSelected];
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


#pragma mark - Event
- (void)clickWindow:(UIButton *)clickButton {
    clickButton.selected = !clickButton.isSelected;
    
    BOOL shouldHideLog = clickButton.selected;
    if (shouldHideLog) {
        [CJLogViewWindow show:YES];
    } else {
        [CJLogViewWindow show:NO];
    }
    
    if (self.clickWindowBlock) {
        self.clickWindowBlock(clickButton);
    }
}

- (void)closeWindow:(UIButton *)closeButton {
    [CJLogViewWindow show:NO];
    if (self.closeWindowBlock) {
        self.closeWindowBlock();
    }
    
    [CJLogSuspendWindow removeFromScreen];
}

@end
