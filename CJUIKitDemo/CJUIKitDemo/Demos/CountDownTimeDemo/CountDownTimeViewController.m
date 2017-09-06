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
    if ([MyCountDownTimeManager sharedInstance].timer == nil) {
        NSLog(@"这里将会创建定时器");
        [[MyCountDownTimeManager sharedInstance] createCountDownWithPeriodDuration:5 timeZeroBlock:^NSInteger(void) {
            
            NSInteger currentSecond = 5;
            [self.countDownTimeButton setTitle:@"发送验证码(5s)" forState:UIControlStateNormal];
            [self.countDownTimeButton setEnabled:YES];
            
            //是否要结束计时器
            /* //错误的销毁计时器的方法
            [timer invalidate];
            timer = nil;
            */
            [[MyCountDownTimeManager sharedInstance].timer invalidate];
            [MyCountDownTimeManager sharedInstance].timer = nil;
            //或[[MyCountDownTimeManager sharedInstance] invalidateCountDownWithCompleteBlock:nil];
            
            return currentSecond;
            
        } timeNoZeroBlock:^(NSInteger currentSecond) {
            NSString *title = [NSString stringWithFormat:@"倒计时(%lds)", currentSecond];
            [self.countDownTimeButton setTitle:title forState:UIControlStateNormal];
            [self.countDownTimeButton setEnabled:NO];
            
        }];
    }
    
    [[MyCountDownTimeManager sharedInstance] beginCountDown];
    
    
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
