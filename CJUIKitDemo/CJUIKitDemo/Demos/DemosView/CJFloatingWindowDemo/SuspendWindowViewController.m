//
//  SuspendWindowViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "SuspendWindowViewController.h"

#import "UIView+CJDragAction.h"
#import "UIView+CJKeepBounds.h"

#import "DemoSuspendWindow.h"
#import "CJSuspendWindowManager.h"

@interface SuspendWindowViewController ()

@property (nonatomic, strong) DemoSuspendWindow *suspendWindow;

@end

@implementation SuspendWindowViewController

//- (void)viewWillDisappear:(BOOL)animated {
//    [super viewWillDisappear:animated];
//
////    [self.suspendWindow removeFromScreen];
//    [CJSuspendWindowManager destroyWindowForKey:self.suspendWindow.windowIdentifier];
//}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    DemoSuspendWindow *suspendWindow = (DemoSuspendWindow *)[CJSuspendWindowManager windowForKey:@"testWindow"];
    if (suspendWindow == nil) {
        suspendWindow = [[DemoSuspendWindow alloc] initWithFrame:CGRectZero];
        suspendWindow.windowIdentifier = @"testWindow";
        suspendWindow.backgroundColor = [UIColor lightGrayColor];
        suspendWindow.cjDragEnable = YES;
        [suspendWindow setCjDragBeginBlock:^(UIView *view) {
            NSLog(@"开始拖曳Window");
        }];
        [suspendWindow setCjDragEndBlock:^(UIView *view) {
            NSLog(@"结束拖曳Window");
            [view cjKeepBounds];
        }];
        
        __weak typeof(suspendWindow)weakSuspendWindow = suspendWindow;
        [suspendWindow setCloseWindowBlock:^{
            //[weakSuspendWindow removeFromScreen];
            [CJSuspendWindowManager destroyWindowForKey:weakSuspendWindow.windowIdentifier];
        }];
        [suspendWindow setClickWindowBlock:^(UIButton *clickButton) {
            NSLog(@"click %@", clickButton.titleLabel.text);
        }];
        
        self.suspendWindow = suspendWindow;
        
        [CJSuspendWindowManager saveWindow:suspendWindow forKey:suspendWindow.windowIdentifier];
    }
    [suspendWindow setFrame:CGRectMake(10, 200, 100, 100)];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"悬浮框";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *cjTestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cjTestButton setFrame:CGRectMake(50, 100, 200, 40)];
    [cjTestButton setBackgroundColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.4 alpha:0.5]];
    [cjTestButton setTitle:@"进入下一页(测试)" forState:UIControlStateNormal];
    [cjTestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cjTestButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [cjTestButton addTarget:self action:@selector(goNextViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cjTestButton];
    [cjTestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(44);
    }];
}

- (void)goNextViewController {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
}


@end
