//
//  TestPresentViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/8/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "TestPresentViewController.h"
#import "UIViewControllerCJHelper.h"

@interface TestPresentViewController ()

@end

@implementation TestPresentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"cjBackBarButtonItem"] forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    [self.view addSubview:closeButton];
//    [closeButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view).mas_offset(23);
//        make.top.mas_equalTo(self.view).mas_offset(statusHeight);
//        make.width.mas_equalTo(44);
//        make.height.mas_equalTo(44);
//    }];
    UIBarButtonItem *leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:closeButton];
    self.navigationItem.leftBarButtonItems = @[leftBarButtonItem];
    
    
    UIButton *cjTestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cjTestButton setBackgroundColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.4 alpha:0.5]];
    [cjTestButton setTitle:@"获取当前显示的视图控制器" forState:UIControlStateNormal];
    [cjTestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cjTestButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [cjTestButton addTarget:self action:@selector(printCurrentShowingViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cjTestButton];
    [cjTestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(44);
    }];
}

- (void)printCurrentShowingViewController {
    UIViewController *currentShowViewController1 = [UIViewControllerCJHelper findCurrentShowingViewController];
    NSLog(@"currentShowViewController1 = %@", NSStringFromClass([currentShowViewController1 class]));
    
    UIViewController *currentShowViewController2 = [UIViewControllerCJHelper findCurrentShowingViewControllerFrom:self];
    NSLog(@"currentShowViewController2 = %@", NSStringFromClass([currentShowViewController2 class]));
    
    UIViewController *belongViewController = [UIViewControllerCJHelper findBelongViewControllerForView:self.view];
    NSLog(@"belongViewController = %@", NSStringFromClass([belongViewController class]));
}

- (void)goBack {
//    if (self.presentingViewController) {
//        [self dismissViewControllerAnimated:YES completion:^{
//
//        }];
//    } else {
//        [self.navigationController popViewControllerAnimated:YES];
//    }
    
    UIViewController *currentShowViewController = [UIViewControllerCJHelper findCurrentShowingViewControllerFrom:self];
    if ([currentShowViewController isKindOfClass:[TestPresentViewController class]]) {
        [currentShowViewController dismissViewControllerAnimated:YES completion:nil];
    }
}


//获取Window当前显示的ViewController
- (UIViewController*)currentViewController{
    //获得当前活动窗口的根视图
    UIViewController* vc = [UIApplication sharedApplication].keyWindow.rootViewController;
    while (1)
    {
        //根据不同的页面切换方式，逐步取得最上层的viewController
        if ([vc isKindOfClass:[UITabBarController class]]) {
            vc = ((UITabBarController*)vc).selectedViewController;
        }
        if ([vc isKindOfClass:[UINavigationController class]]) {
            vc = ((UINavigationController*)vc).visibleViewController;
        }
        if (vc.presentedViewController) {
            vc = vc.presentedViewController;
        }else{
            break;
        }
    }
    return vc;
}

//获取当前屏幕显示的viewcontroller
- (UIViewController *)getCurrentVC
{
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
        result = nextResponder;
    else
        result = window.rootViewController;
    
    return result;
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
