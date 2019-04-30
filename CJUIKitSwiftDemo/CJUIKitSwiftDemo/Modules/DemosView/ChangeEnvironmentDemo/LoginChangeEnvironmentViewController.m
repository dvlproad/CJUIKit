//
//  LoginChangeEnvironmentViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/12.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "LoginChangeEnvironmentViewController.h"
#import <CJPopupView/CJPopoverListView.h>
#import "UIView+CJShowExtendView.h"
#import "DemoChangeEnvironmentViewModel.h"

@interface LoginChangeEnvironmentViewController ()

@property (nonatomic, strong) UIButton *cjTestButton1;
@property (nonatomic, strong) UIButton *cjTestButton2;

/**< 改变环境按钮 */
@property (nonatomic, strong) UIButton *changeEnvironmentButton;
@property (nonatomic, strong) DemoChangeEnvironmentViewModel *changeEnvironmentViewModel;

@end

@implementation LoginChangeEnvironmentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"ChangeEnvironment(在登录的时候改变app环境)", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *cjTestButton1 = [DemoButtonFactory blueButton];
    [cjTestButton1 setTitle:NSLocalizedString(@"改变app环境", nil) forState:UIControlStateNormal];
    [cjTestButton1 addTarget:self action:@selector(popItemChoose1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cjTestButton1];
    [cjTestButton1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(44);
    }];
    self.cjTestButton1 = cjTestButton1;
    
    UIButton *cjTestButton2 = [DemoButtonFactory blueButton];
    [cjTestButton2 setTitle:NSLocalizedString(@"改变app环境", nil) forState:UIControlStateNormal];
    [cjTestButton2 addTarget:self action:@selector(popItemChoose2:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cjTestButton2];
    [cjTestButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(cjTestButton1.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(44);
    }];
    self.cjTestButton2 = cjTestButton2;
    
    
    UIButton *changeEnvironmentButton = [DemoButtonFactory blueButton];
    [self.view addSubview:changeEnvironmentButton];
    [changeEnvironmentButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(cjTestButton2.mas_bottom).mas_offset(40);
        make.height.mas_equalTo(44);
    }];
    self.changeEnvironmentButton = changeEnvironmentButton;
    
    DemoChangeEnvironmentViewModel *changeEnvironmentViewModel = [[DemoChangeEnvironmentViewModel alloc] init];
    changeEnvironmentViewModel.changeEnvironmentButton = self.changeEnvironmentButton;
    self.changeEnvironmentViewModel = changeEnvironmentViewModel;
}

- (void)updateCurrentEnvironment:(NSString *)currentEnvironment {
    self.currentEnvironment = currentEnvironment;
    if ([self.currentEnvironment isEqualToString:@"xxx.xxx.com"]) {
        self.cjTestButton1.hidden = YES;
        self.cjTestButton2.hidden = YES;
    } else {
        self.cjTestButton1.hidden = NO;
        self.cjTestButton2.hidden = NO;
    }
}

- (void)popItemChoose1:(UIButton *)button {
    CGPoint point_origin = CGPointMake(button.center.x, button.center.y + button.frame.size.height/2);
    CGPoint point = [button.superview convertPoint:point_origin toView:self.view];
    
    
    NSArray *titles = @[@"Product(生产环境)",
                        @"PreProduct(预生产环境)",
                        @"Develop1(开发环境1)",
                        @"Develop2(开发环境2)"
                        ];
    
    CJPopoverListView *pop = [[CJPopoverListView alloc] initWithPoint:point titles:titles images:nil];
    
    __weak typeof(self)weakSelf = self;
    pop.selectRowAtIndex = ^(NSInteger index){
        NSLog(@"select index:%zd", index);
        
        NSString *currentEnvironment = titles[index];
        [button setTitle:currentEnvironment forState:UIControlStateNormal];
        
        [weakSelf updateCurrentEnvironment:currentEnvironment];
    };
    [pop showPopoverView];
}

- (void)popItemChoose2:(UIButton *)button {
    NSArray *titles = @[@"Product(生产环境)",
                        @"PreProduct(预生产环境)",
                        @"Develop1(开发环境1)",
                        @"Develop2(开发环境2)"
                        ];
    CJPopoverListView *pop = [[CJPopoverListView alloc] initWithPoint:CGPointZero titles:titles images:nil];
    
    __weak typeof(self)weakSelf = self;
    __weak typeof(pop)weakPopoverView = pop;
    pop.selectRowAtIndex = ^(NSInteger index){
        NSLog(@"select index:%zd", index);
        
        NSString *currentEnvironment = titles[index];
        [button setTitle:currentEnvironment forState:UIControlStateNormal];
        
        [weakPopoverView dismissPopoverView:YES];
        [weakSelf updateCurrentEnvironment:currentEnvironment];
    };
    
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    [button cj_showExtendView:pop inView:self.view locationAccordingView:button relativePosition:CJPopupViewPositionBelow blankBGColor:blankBGColor showComplete:^{
        
    } tapBlankComplete:^{
        [pop dismissPopoverView:YES];
    }];
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
