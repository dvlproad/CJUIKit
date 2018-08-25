//
//  ViewController1.m
//  ZYSuspensionViewDemo
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 2017/3/7.
//  Copyright © 2017年 ripper. All rights reserved.
//

#import "ViewController1.h"

#import "UIView+CJDragAction.h"
#import "UIView+CJKeepBounds.h"

#import "ZYSuspensionView.h"

@interface ViewController1 ()<ZYSuspensionViewDelegate>

@property (nonatomic, strong) ZYSuspensionView *susView;

@end

@implementation ViewController1

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.susView removeFromScreen];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [self.susView setFrame:CGRectMake(10, 200, 100, 100)];
    [self.susView show];
    
    CJSuspendWindow *suspendWindow = self.susView.containerWindow;
    suspendWindow.backgroundColor = [UIColor lightGrayColor];
    suspendWindow.cjDragEnable = YES;
    [suspendWindow setCjDragBeginBlock:^(UIView *view) {
        NSLog(@"开始拖曳橙色视图");
    }];
    [suspendWindow setCjDragEndBlock:^(UIView *view) {
        NSLog(@"结束拖曳橙色视图");
        [view cjKeepBounds];
    }];
}

- (ZYSuspensionView *)susView {
    if (_susView == nil) {
        ZYSuspensionView *susView = [[ZYSuspensionView alloc] initWithFrame:CGRectZero];
        susView.backgroundColor = [UIColor colorWithRed:0.97 green:0.30 blue:0.30 alpha:1.00];
        susView.delegate = self;
        susView.leanType = ZYSuspensionViewLeanTypeEachSide;
        [susView setTitle:@"JSUT" forState:UIControlStateNormal];
        
//        susView.cjDragEnable = YES;
//        [susView setCjDragBeginBlock:^(UIView *view) {
//            NSLog(@"开始拖曳橙色视图");
//        }];
//        [susView setCjDragEndBlock:^(UIView *view) {
//            NSLog(@"结束拖曳橙色视图");
//            [view cjKeepBounds];
//        }];
        
        _susView = susView;
    }
    
    return _susView;
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

#pragma mark - ZYSuspensionViewDelegate
- (void)suspensionViewClick:(ZYSuspensionView *)suspensionView
{
    NSLog(@"click %@",suspensionView.titleLabel.text);
}

@end
