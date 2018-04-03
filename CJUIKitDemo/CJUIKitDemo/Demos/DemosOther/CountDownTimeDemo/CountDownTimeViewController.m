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
@property (nonatomic, assign) NSInteger remainSecond; /**< 本周期剩余的时间 */


@end

@implementation CountDownTimeViewController


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    
    //全局定时器的时候才用，要不然就自己创建定时器好了
    if ([CJTimeManager sharedInstance].timer) {
        [[CJTimeManager sharedInstance] invalidateCountDownWithCompleteBlock:nil];
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
    if ([CJTimeManager sharedInstance].timer == nil) {
        NSLog(@"这里将会创建定时器");
        
        CJCountDownTimerModel *timerModel1 = [[CJCountDownTimerModel alloc] init];
        timerModel1.minResetSecond = kPeriodDuration;
        timerModel1.maxRepeatCount = 2;
        timerModel1.resetSecondBlock = ^(CJCountDownTimerModel *timer) {
            NSInteger remainSecond = timer.minResetSecond; //本周期剩余的时间
            NSString *title = [NSString stringWithFormat:@"发送验证码(%zds)", remainSecond];
            [self.countDownTimeButton1 setTitle:title forState:UIControlStateNormal];
            [self.countDownTimeButton1 setEnabled:YES];
            
//            //是否要结束计时器
//            [[CJTimeManager sharedInstance].timer invalidate];
//            [CJTimeManager sharedInstance].timer = nil;
//            //或[[CJTimeManager sharedInstance] invalidateCountDownWithCompleteBlock:nil];
        };
        timerModel1.addingSecondBlock = ^(CJCountDownTimerModel *timer) {
            NSInteger cumulativeSecond = timer.cumulativeSecond;
            NSInteger remainSecond = timer.minResetSecond - cumulativeSecond;
            NSString *title = [NSString stringWithFormat:@"倒计时(%lds)", remainSecond];
            [self.countDownTimeButton1 setTitle:title forState:UIControlStateNormal];
            [self.countDownTimeButton1 setEnabled:NO];
        };
        
        //timerModel2
        CJCountDownTimerModel *timerModel2 = [[CJCountDownTimerModel alloc] init];
        timerModel2.minResetSecond = 7;
        timerModel2.maxRepeatCount = 1;
        timerModel2.resetSecondBlock = ^(CJCountDownTimerModel *timer) {
            NSInteger remainSecond = timer.minResetSecond; //本周期剩余的时间
            NSString *title = [NSString stringWithFormat:@"发送验证码(%zds)", remainSecond];
            self.countDownTimeLabel1.text = title;
        };
        timerModel2.addingSecondBlock = ^(CJCountDownTimerModel *timer) {
            NSInteger cumulativeSecond = timer.cumulativeSecond;
            NSInteger remainSecond = timer.minResetSecond - cumulativeSecond;
            NSString *title = [NSString stringWithFormat:@"倒计时(%lds)", remainSecond];
            self.countDownTimeLabel1.text = title;
        };
        
        //timerModel3
        CJCountDownTimerModel *timerModel3 = [[CJCountDownTimerModel alloc] init];
        timerModel3.minResetSecond = 10;
        timerModel3.maxRepeatCount = 1;
        timerModel3.resetSecondBlock = ^(CJCountDownTimerModel *timer) {
            NSInteger remainSecond = timer.minResetSecond; //本周期剩余的时间
            NSString *title = [NSString stringWithFormat:@"发送验证码(%zds)", remainSecond];
            self.countDownTimeLabel2.text = title;
        };
        timerModel3.addingSecondBlock = ^(CJCountDownTimerModel *timer) {
            NSInteger cumulativeSecond = timer.cumulativeSecond;
            NSInteger remainSecond = timer.minResetSecond - cumulativeSecond;
            NSString *title = [NSString stringWithFormat:@"倒计时(%lds)", remainSecond];
            self.countDownTimeLabel2.text = title;
        };
        
        NSArray<CJCountDownTimerModel *> *timerModels = @[timerModel1, timerModel2, timerModel3];
        
        [[CJTimeManager sharedInstance] createCountDownWithTimerModels:timerModels timeInterval:1];
    }
    
    [[CJTimeManager sharedInstance] beginCountDown];
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
        self.remainSecond = kPeriodDuration;
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer * _Nonnull timer) {
            NSLog(@"self.remainSecond = %ld", self.remainSecond);
            --self.remainSecond;
            if (self.remainSecond > 0) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    NSString *title = [NSString stringWithFormat:@"倒计时(%lds)", self.remainSecond];
                    [self.countDownTimeButton2 setTitle:title forState:UIControlStateNormal];
                    [self.countDownTimeButton2 setEnabled:NO];
                });
                
                return;
            }
            
            self.remainSecond = kPeriodDuration;
            dispatch_async(dispatch_get_main_queue(), ^{
                self.remainSecond = kPeriodDuration;
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
