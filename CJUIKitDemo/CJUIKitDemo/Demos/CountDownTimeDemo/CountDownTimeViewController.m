//
//  CountDownTimeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/6.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CountDownTimeViewController.h"

static CGFloat kPeriodDuration = 5.0f;

@interface CountDownTimeViewController () {
    
}
@property (nonatomic, strong) NSTimer *timer;
//@property (nonatomic, assign) NSInteger periodDuration;
@property (nonatomic, assign) NSInteger currentSecond;


@end

@implementation CountDownTimeViewController


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    //全局定时器的时候才用，要不然就自己创建定时器好了
    if ([MyCountDownTimeManager sharedInstance].timer) {
        [[MyCountDownTimeManager sharedInstance] invalidateCountDownWithCompleteBlock:nil];
    }
    
//    if (self.timer) {
//        [self.timer invalidate];
//        self.timer = nil;
//    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    [self setupCountDownTimeButton1];
    [self setupCountDownTimeButton2];
}

#pragma mark - countDownTimeButton1
- (void)setupCountDownTimeButton1 {
    self.countDownTimeButton1.backgroundColor = [UIColor cyanColor];
    [self.countDownTimeButton1 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.countDownTimeButton1 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.countDownTimeButton1 addTarget:self action:@selector(countDownTimeButtonAction1:) forControlEvents:UIControlEventTouchUpInside];
    [self.countDownTimeButton1 setTitle:@"发送验证码(5s)" forState:UIControlStateNormal];
    [self.countDownTimeButton1 setEnabled:YES];
}

- (IBAction)countDownTimeButtonAction1:(id)sender {
    if ([MyCountDownTimeManager sharedInstance].timer == nil) {
        NSLog(@"这里将会创建定时器");
        [[MyCountDownTimeManager sharedInstance] createCountDownWithPeriodDuration:kPeriodDuration timeZeroBlock:^NSInteger(void) {
            
            NSInteger currentSecond = kPeriodDuration;
            [self.countDownTimeButton1 setTitle:@"发送验证码(5s)" forState:UIControlStateNormal];
            [self.countDownTimeButton1 setEnabled:YES];
            
            //是否要结束计时器
            [[MyCountDownTimeManager sharedInstance].timer invalidate];
            [MyCountDownTimeManager sharedInstance].timer = nil;
            //或[[MyCountDownTimeManager sharedInstance] invalidateCountDownWithCompleteBlock:nil];
            
            return currentSecond;
            
        } timeNoZeroBlock:^(NSInteger currentSecond) {
            NSString *title = [NSString stringWithFormat:@"倒计时(%lds)", currentSecond];
            [self.countDownTimeButton1 setTitle:title forState:UIControlStateNormal];
            [self.countDownTimeButton1 setEnabled:NO];
            
        }];
    }
    
    [[MyCountDownTimeManager sharedInstance] beginCountDown];
}


#pragma mark - countDownTimeButton2
- (void)setupCountDownTimeButton2 {
    self.countDownTimeButton2.backgroundColor = [UIColor cyanColor];
    [self.countDownTimeButton2 setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.countDownTimeButton2 setTitleColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
    [self.countDownTimeButton2 addTarget:self action:@selector(countDownTimeButtonAction2:) forControlEvents:UIControlEventTouchUpInside];
    [self.countDownTimeButton2 setTitle:@"发送验证码(5s)" forState:UIControlStateNormal];
    [self.countDownTimeButton2 setEnabled:YES];
}

- (IBAction)countDownTimeButtonAction2:(id)sender {
    if (self.timer == nil) {
        self.currentSecond = kPeriodDuration;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"self.currentSecond = %ld", self.currentSecond);
            --self.currentSecond;
            if (self.currentSecond > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *title = [NSString stringWithFormat:@"倒计时(%lds)", self.currentSecond];
                    [self.countDownTimeButton2 setTitle:title forState:UIControlStateNormal];
                    [self.countDownTimeButton2 setEnabled:NO];
                });
                
                return;
            }
            
            self.currentSecond = kPeriodDuration;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.currentSecond = kPeriodDuration;
                [self.countDownTimeButton2 setTitle:@"发送验证码(5s)" forState:UIControlStateNormal];
                [self.countDownTimeButton2 setEnabled:YES];
            });
            //是否要结束计时器
            [self.timer invalidate];
            self.timer = nil;
        }];
    }
    
    [self.timer fire];
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
