//
//  DemoSuspendWindowRootViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DemoSuspendWindowRootViewController.h"

@interface DemoSuspendWindowRootViewController () {
    
}
@property (nonatomic, strong) UIButton *closeButton;
@property (nonatomic, strong) UIButton *clickButton;

@end



@implementation DemoSuspendWindowRootViewController

- (BOOL)prefersStatusBarHidden
{
    return NO;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews {
    self.view.clipsToBounds = YES;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *clickButton = [[UIButton alloc] initWithFrame:CGRectZero];
    clickButton.userInteractionEnabled = YES;
    clickButton.backgroundColor = [UIColor colorWithRed:0.21f green:0.45f blue:0.88f alpha:1.00f];
    clickButton.alpha = .7;
    clickButton.titleLabel.font = [UIFont systemFontOfSize:14];
    clickButton.layer.borderColor = [UIColor whiteColor].CGColor;
    clickButton.layer.borderWidth = 1.0;
    clickButton.clipsToBounds = YES;
    [clickButton setTitle:@"悬浮球" forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(clickWindow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickButton];
    self.clickButton = clickButton;
    
    UIButton *closeButton = [[UIButton alloc] initWithFrame:CGRectZero];
    closeButton.userInteractionEnabled = YES;
    closeButton.backgroundColor = [UIColor colorWithRed:0.97 green:0.30 blue:0.30 alpha:1.00];
    closeButton.alpha = .7;
    closeButton.titleLabel.font = [UIFont systemFontOfSize:14];
    closeButton.layer.borderColor = [UIColor whiteColor].CGColor;
    closeButton.layer.borderWidth = 1.0;
    closeButton.clipsToBounds = YES;
    [closeButton setTitle:@"关闭" forState:UIControlStateNormal];
    [closeButton addTarget:self action:@selector(closeWindow:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:closeButton];
    self.closeButton = closeButton;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    //clickButton
    self.clickButton.frame = CGRectMake(0, 0, width, height);
    CGFloat shortLength = MIN(CGRectGetWidth(self.clickButton.frame), CGRectGetHeight(self.clickButton.frame));
    self.clickButton.layer.cornerRadius = shortLength / 2.0;
    
    //closeButton
    self.closeButton.frame = CGRectMake(width-44, 0, 44, 44);
}


#pragma mark - Event
- (void)clickWindow:(UIButton *)clickButton {
    !self.clickWindowBlock ?: self.clickWindowBlock(clickButton);
}

- (void)closeWindow:(UIButton *)closeButton {
    !self.closeWindowBlock ?: self.closeWindowBlock();
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
