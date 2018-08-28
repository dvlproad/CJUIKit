//
//  CJLogViewWindow.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJLogViewWindow.h"
#import "CJLogView.h"

@interface CJLogViewWindow () {
    
}
@property (nonatomic, weak) CJLogView *logView;

@end

@implementation CJLogViewWindow

static CJLogViewWindow __strong *_sharedInstance = nil;

+ (CJLogViewWindow *)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
        CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
        CGRect windowFrame = CGRectMake(0, height-500, width, 500);
        _sharedInstance = [[CJLogViewWindow alloc] initWithFrame:windowFrame];
    });
    return _sharedInstance;
}

+ (void)cleanUp {
    _sharedInstance = nil;
}

/* 完整的描述请参见文件头部 */
+ (void)appendObject:(id)appendObject {
    dispatch_async(dispatch_get_main_queue(),^{
        [[CJLogViewWindow sharedInstance] appendObject:appendObject];
    });
}

/* 完整的描述请参见文件头部 */
+ (void)clear {
    dispatch_async(dispatch_get_main_queue(), ^{
        [[CJLogViewWindow sharedInstance] clear];
    });
}

+ (void)show:(BOOL)show {
    if (show) {
        [CJLogViewWindow sharedInstance].hidden = NO;
    } else {
        [CJLogViewWindow sharedInstance].hidden = YES;
    }
//    [CJLogViewWindow sharedInstance].rootViewController = nil;
}

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setupWindow];
    }
    return self;
}

- (void)setupWindow {
    self.rootViewController = [UIViewController new]; // suppress warning
    self.windowLevel = UIWindowLevelAlert; //是窗口保持在最前
    [self setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
    self.userInteractionEnabled = NO; //设为NO，使屏幕触摸事件会传递到下层的实际 view 上去，不会挡住测试的操作
    
    CJLogView *logView = [[CJLogView alloc] initWithFrame:CGRectZero];
    [self addSubview:logView];
    [logView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self);
    }];
    self.logView = logView;
}

#pragma mark - Print & Clear
///追加log到视图
- (void)appendObject:(id)appendObject {
    if (self.hidden) {
        self.hidden = NO;
    }
    
    CJLogView *logView = self.logView;
    [logView appendObject:appendObject];
}

///清空测试窗口
- (void)clear {
    [self.logView clear];
}

@end
