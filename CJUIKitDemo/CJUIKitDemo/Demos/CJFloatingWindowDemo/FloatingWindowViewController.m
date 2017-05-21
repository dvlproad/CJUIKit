//
//  FloatingWindowViewController.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "FloatingWindowViewController.h"

#import "AppDelegate.h"
#import "UIView+CJDragAction.h"

@interface FloatingWindowViewController ()

@property (nonatomic, strong) UIWindow *window;

@end

@implementation FloatingWindowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (appDelegate.cjFloatingWindow == nil) {
        UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(100, 100, 200, 200)];
        window.windowLevel = UIWindowLevelAlert + 1;  //如果想在 alert 之上，则改成 + 2
        [window makeKeyAndVisible];
        
        window.backgroundColor = [UIColor redColor];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setFrame:CGRectMake(0, 0, 80, 80)];
        [button setCenter:CGPointMake(CGRectGetWidth(window.frame)/2, CGRectGetHeight(window.frame)/2)];
        button.layer.cornerRadius = 40;
        button.layer.masksToBounds = YES;
        [button setTitle:@"悬浮按钮" forState:UIControlStateNormal];
        [button setBackgroundColor:[UIColor orangeColor]];
        [window addSubview:button];
        
//        self.window = window;
        appDelegate.cjFloatingWindow = window;
    }
    appDelegate.cjFloatingWindow.cjDragEnable = YES;
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
