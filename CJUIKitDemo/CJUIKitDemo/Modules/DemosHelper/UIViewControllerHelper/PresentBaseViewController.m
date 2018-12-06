//
//  PresentBaseViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/8/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "PresentBaseViewController.h"
#import "UIViewControllerCJHelper.h"

@interface PresentBaseViewController () {
    
}

@end

@implementation PresentBaseViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    NSLog(@"%@ viewWillAppear", NSStringFromClass([self class]));
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    NSLog(@"%@ viewDidAppear", NSStringFromClass([self class]));
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    NSLog(@"%@ viewWillDisappear", NSStringFromClass([self class]));
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    NSLog(@"%@ viewDidDisappear", NSStringFromClass([self class]));
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"获取present前的视图(UIViewControllerCJHelper)", nil);
    
    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton setImage:[UIImage imageNamed:@"closePresentVC"] forState:UIControlStateNormal];
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
    
    
    NSString *className = NSStringFromClass([self class]);
    UILabel *currentClassNameLabel = [DemoLabelFactory cyanLabelWithText:className];
    [self.view addSubview:currentClassNameLabel];
    [currentClassNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(44);
    }];
    
    
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
        make.top.mas_equalTo(currentClassNameLabel.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(44);
    }];
    
    UILabel *resultClassNameLabel = [DemoLabelFactory testLeftCyanLabel];
    resultClassNameLabel.text = @"点击'获取当前显示的视图控制器'按钮后所得的结果的显示位置";
    [self.view addSubview:resultClassNameLabel];
    [resultClassNameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(cjTestButton.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(200);
    }];
    self.resultClassNameLabel = resultClassNameLabel;
}


- (void)printCurrentShowingViewController {
    UIViewController *currentShowViewController1 = [UIViewControllerCJHelper findCurrentShowingViewController];
    NSString *codeMessage1 = [NSString stringWithFormat:@"[UIViewControllerCJHelper findCurrentShowingViewController]"];
    NSString *resultClassName1 = NSStringFromClass([currentShowViewController1 class]);
    NSString *message1 = [NSString stringWithFormat:@"%@\n返回的结果%@", codeMessage1, resultClassName1];
    NSAssert([resultClassName1 isEqualToString:NSStringFromClass([self class])], @"Error:获取到的控制器与实际结果不符合，请检查");
    
    UIViewController *currentShowViewController2 = [UIViewControllerCJHelper findCurrentShowingViewControllerFrom:self];
    NSString *codeMessage2 = [NSString stringWithFormat:@"[UIViewControllerCJHelper findCurrentShowingViewControllerFrom:self]"];
    NSString *resultClassName2 = NSStringFromClass([currentShowViewController2 class]);
    NSString *message2 = [NSString stringWithFormat:@"%@\n返回的结果%@", codeMessage2, resultClassName2];
    NSAssert([resultClassName2 isEqualToString:NSStringFromClass([self class])], @"Error:获取到的控制器与实际结果不符合，请检查");
    
    UIViewController *belongViewController = [UIViewControllerCJHelper findBelongViewControllerForView:self.view];
    NSString *codeMessage3 = [NSString stringWithFormat:@"[UIViewControllerCJHelper findBelongViewControllerForView:self.view]"];
    NSString *resultClassName3 = NSStringFromClass([belongViewController class]);
    NSString *message3 = [NSString stringWithFormat:@"%@\n返回的结果%@", codeMessage3, resultClassName3];
    NSAssert([resultClassName3 isEqualToString:NSStringFromClass([self class])], @"Error:获取到的控制器与实际结果不符合，请检查");
    
    
    NSString *message = [NSString stringWithFormat:@"\n%@\n---------------\n%@\n---------------\n%@", message1, message2, message3];
    NSLog(@"%@", message);
    self.resultClassNameLabel.text = message;
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
    if ([currentShowViewController isKindOfClass:[PresentBaseViewController class]]) {
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
