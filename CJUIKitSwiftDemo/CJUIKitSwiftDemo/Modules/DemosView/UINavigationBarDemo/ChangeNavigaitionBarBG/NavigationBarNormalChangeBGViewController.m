//
//  NavigationBarNormalChangeBGViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "NavigationBarNormalChangeBGViewController.h"
#import "UINavigationBar+CJChangeBG.h"

@interface NavigationBarNormalChangeBGViewController () {
    
}
@property (nonatomic, assign, readonly) BOOL oldTranslucent;

@end

@implementation NavigationBarNormalChangeBGViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    self.navigationController.navigationBar.translucent = self.oldTranslucent;
    [self.navigationController.navigationBar cj_resetBackgroundColor];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    _oldTranslucent = self.navigationController.navigationBar.translucent;
    if (_oldTranslucent == NO) { //translucent若为YES，则设置背景无效
        self.navigationController.navigationBar.translucent = YES;
    }
    [self.navigationController.navigationBar cj_hideUnderline:YES];
    [self.navigationController.navigationBar cj_setBackgroundColor:[UIColor clearColor]];
    self.navigationItem.title = @"";
    //self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[UIView new]];//可以隐藏backBarButtonItem,但会导致不能拖动侧滑
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"登录(改变背景色以隐藏导航栏)", nil);
    self.view.backgroundColor = [UIColor greenColor];
    
    UIButton *blueButton = [DemoButtonFactory blueButton];
    [blueButton setTitle:@"goNextViewController" forState:UIControlStateNormal];
    [blueButton addTarget:self action:@selector(goNextViewController) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:blueButton];
    [blueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(44);
    }];
}

- (void)goNextViewController {
    UIViewController *viewController = [[UIViewController alloc] init];
    viewController.title = NSLocalizedString(@"忘记密码", nil);
    viewController.view.backgroundColor = [UIColor whiteColor];
    [self.navigationController pushViewController:viewController animated:YES];
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
