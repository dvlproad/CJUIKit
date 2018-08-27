//
//  LogViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/5/25.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "LogViewController.h"
#import "CJLogUtil.h"
#import "CJLogWindow.h"


#import "CJLogView.h"
#import "UIView+CJPopupInSuspendWindow.h"

@interface LogViewController () {
    
}
//@property (nonatomic, strong) CJLogView *logView;

@end



@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UILabel *testLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    testLabel.numberOfLines = 0;
    testLabel.textColor = [UIColor lightGrayColor];
    testLabel.textAlignment = NSTextAlignmentCenter;
    testLabel.font = [UIFont systemFontOfSize:17];
    [self.view addSubview:testLabel];
    [testLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(80);
    }];
    NSString *text = @"请进入控制台上打印的NSHomeDirectory()，查看NSDocumentDirectory文件夹下的CJLog文件夹";
    testLabel.text = text;
    
    NSString *homeDirectory = NSHomeDirectory();
    NSLog(@"homeDirectory = %@", homeDirectory);
    
    
    UIButton *cjTestButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [cjTestButton setFrame:CGRectMake(50, 100, 200, 40)];
    [cjTestButton setBackgroundColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.4 alpha:0.5]];
    [cjTestButton setTitle:@"CJTestButton" forState:UIControlStateNormal];
    [cjTestButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [cjTestButton.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [cjTestButton addTarget:self action:@selector(showPopupView) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cjTestButton];
    [cjTestButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(44);
    }];
    
    
    
//    CJLogView *logView = [[CJLogView alloc] initWithFrame:CGRectZero];
    CJLogView *logView = [CJLogView sharedInstance];
    logView.backgroundColor = [UIColor lightGrayColor];
    
    CGFloat width = CGRectGetWidth([UIScreen mainScreen].bounds);
    CGFloat height = CGRectGetHeight([UIScreen mainScreen].bounds);
    CGRect windowFrame = CGRectMake(0, height-200, width, 200);
    [logView cj_popupInSuspendWindowWithIdentifier:@"test" windowFrame:windowFrame];
//    self.logView = logView;
}

- (void)showPopupView {
    
}

- (IBAction)appendLog:(id)sender {
    [CJLogUtil cj_appendObject:@"this is a test log" toLogFileName:@"testLog.txt"];
    [CJLogWindow cj_appendObject:@"this is a test log" toLogWindowName:@"testLog.txt"];
    [[CJLogView sharedInstance] cj_appendObject:@"this is a test log" toLogWindowName:@"testLog.txt"];
}

- (IBAction)removeLogFile:(id)sender {
    [CJLogUtil cj_removeLogFileName:@"testLog.txt"];
    [CJLogWindow clear];
    [[CJLogView sharedInstance] clear];
}

- (IBAction)removeLogDirectory:(id)sender {
    [CJLogUtil cj_removeLogDirectory];
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
