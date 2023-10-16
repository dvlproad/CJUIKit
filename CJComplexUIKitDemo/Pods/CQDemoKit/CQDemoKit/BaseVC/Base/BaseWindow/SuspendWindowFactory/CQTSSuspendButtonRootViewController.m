//
//  CQTSSuspendButtonRootViewController.m
//  CQDemoKit
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQTSSuspendButtonRootViewController.h"

@interface CQTSSuspendButtonRootViewController () {
    
}
@property (nonatomic, strong) UIButton *button;
@property (nonatomic, copy, readonly) NSString *buttonTitle;
@property (nonatomic, copy, readonly) void(^buttonClickHandle)(void);

@end



@implementation CQTSSuspendButtonRootViewController


- (instancetype)initWithButtonTitle:(NSString *)buttonTitle
                  buttonClickHandle:(void(^)(void))buttonClickHandle
{
    self = [super initWithNibName:nil bundle:nil];
    if (self) {
        _buttonTitle = buttonTitle;
        _buttonClickHandle = buttonClickHandle;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}


- (void)setupViews {
    self.view.clipsToBounds = YES;
    
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UIButton *clickButton = [[UIButton alloc] initWithFrame:CGRectZero];
    clickButton.backgroundColor = [UIColor colorWithRed:0.21f green:0.45f blue:0.88f alpha:1.00f];
    clickButton.alpha = .7;
    clickButton.titleLabel.font = [UIFont systemFontOfSize:14];
    clickButton.layer.borderColor = [UIColor whiteColor].CGColor;
    clickButton.layer.borderWidth = 1.0;
    clickButton.clipsToBounds = YES;
    [clickButton setTitle:self.buttonTitle forState:UIControlStateNormal];
    [clickButton addTarget:self action:@selector(buttonClickAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:clickButton];
    self.button = clickButton;
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    
    CGFloat width = CGRectGetWidth(self.view.frame);
    CGFloat height = CGRectGetHeight(self.view.frame);
    
    //clickButton
    self.button.frame = CGRectMake(0, 0, width, height);
    CGFloat shortLength = MIN(width, height);
    self.button.layer.cornerRadius = shortLength / 2.0;
}


#pragma mark - Event
- (void)buttonClickAction:(UIButton *)clickButton {
    !self.buttonClickHandle ?: self.buttonClickHandle();
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
