//
//  LogViewViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/5/25.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "LogViewViewController.h"

#import "CJLogView.h"
#import "UIView+CJPopupInSuspendWindow.h"

@interface LogViewViewController () {
    
}
@property (nonatomic, strong) UIWindow *suspendWindow;
@property (nonatomic, strong) CJLogView *logView;

@end



@implementation LogViewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //suspendWindow
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGRect suspendWindowFrame = CGRectMake(0, height-200, width, 200);
    UIWindow *suspendWindow = [[UIWindow alloc] initWithFrame:suspendWindowFrame];
    suspendWindow.rootViewController = [UIViewController new]; // suppress warning
    suspendWindow.windowLevel = UIWindowLevelAlert; //是窗口保持在最前
    [suspendWindow setBackgroundColor:[UIColor colorWithWhite:0 alpha:0.3]];
    suspendWindow.userInteractionEnabled = NO; //设为NO，使屏幕触摸事件会传递到下层的实际 view 上去，不会挡住测试的操作
    suspendWindow.hidden = NO; //显示窗口
    self.suspendWindow = suspendWindow;
    
    //logView
    CJLogView *logView = [[CJLogView alloc] initWithFrame:CGRectZero];
    logView.backgroundColor = [UIColor lightGrayColor];
    CGRect viewFrame = CGRectMake(0, 0, CGRectGetWidth(suspendWindowFrame), CGRectGetHeight(suspendWindowFrame));
    [logView setFrame:viewFrame];
    [suspendWindow addSubview:logView];
    self.logView = logView;
}

- (IBAction)appendLog:(id)sender {
    [self.logView appendObject:@"this is a test log"];
}

- (IBAction)removeLogFile:(id)sender {
    [self.logView clear];
}

- (IBAction)removeLogDirectory:(id)sender {
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
