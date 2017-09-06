//
//  CountDownTimeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CountDownTimeViewController.h"

@interface CountDownTimeViewController ()

@end

@implementation CountDownTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.countDownTimeButton.backgroundColor = [UIColor cyanColor];
    [self.countDownTimeButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.countDownTimeButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.countDownTimeButton addTarget:self action:@selector(countDownTimeButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.countDownTimeButton setTitle:@"发送验证码(5s)" forState:UIControlStateNormal];
    [self.countDownTimeButton setEnabled:YES];

}

- (IBAction)countDownTimeButtonAction:(id)sender {
    [[MyCountDownTimeManager sharedInstance] beginCountDownWithPeriodDuration:5 timeZeroBlock:^NSInteger(NSTimer *timer) {
        
        NSInteger currentSecond = 5;
        [self.countDownTimeButton setTitle:@"发送验证码(5s)" forState:UIControlStateNormal];
        [self.countDownTimeButton setEnabled:YES];
        
        //是否要结束计时器
        [timer invalidate];
        timer = nil;
        
        return currentSecond;
        
    } timeNoZeroBlock:^(NSInteger currentSecond) {
        NSString *title = [NSString stringWithFormat:@"倒计时(%lds)", currentSecond];
        [self.countDownTimeButton setTitle:title forState:UIControlStateNormal];
        [self.countDownTimeButton setEnabled:NO];
        
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
