//
//  FloatingWindowViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "FloatingWindowViewController.h"

#import "DemoFloatingWindow.h"
#import "AppDelegate.h"
#import "UIView+CJDragAction.h"

@interface FloatingWindowViewController ()

@property (nonatomic, strong) UIWindow *window;

@end

@implementation FloatingWindowViewController

- (void)dealloc {
    NSLog(@"%@ dealloc", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.cjFloatingWindow == nil) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        window.windowLevel = UIWindowLevelAlert + 1;  //如果想在 alert 之上，则改成 + 2
        [window makeKeyAndVisible];
        
        window.backgroundColor = [UIColor redColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, 100, 100)];
        [button setCenter:CGPointMake(CGRectGetWidth(window.frame)/2, CGRectGetHeight(window.frame)/2)];
        button.layer.cornerRadius = 50;
        button.layer.masksToBounds = YES;
        [button setTitle:@"关闭悬浮按钮" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont systemFontOfSize:14]];
        [button addTarget:self action:@selector(closeFloatingWindow:) forControlEvents:UIControlEventTouchUpInside];//若target写为self,会由于返回时候self被释放而无法执行按钮操作，所以按钮的target应该定为一个不会被释放的。这里我们把button的添加写到window里。
        [button setBackgroundColor:[UIColor orangeColor]];
        [window addSubview:button];
        
//        self.window = window;
        appDelegate.cjFloatingWindow = window;
    }
    appDelegate.cjFloatingWindow.cjDragEnable = YES;
}

- (void)closeFloatingWindow:(UIButton *)button {
    //TODO:[UIWindow无法释放的问题。求助大神](http://www.cocoachina.com/bbs/read.php?tid-1702416.html)
    //知识点：直接makeKeyAndVisible的UIWindow是没有superView的，所以不能removeFromSuperView
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelegate.cjFloatingWindow.hidden = YES;
    appDelegate.cjFloatingWindow = nil;
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
