//
//  LogUtilViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/5/25.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "LogUtilViewController.h"
#import "CJLogUtil.h"

@interface LogUtilViewController () {
    
}

@end



@implementation LogUtilViewController

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
}

- (IBAction)appendLog:(id)sender {
    [CJLogUtil cj_appendObject:@"this is a test log" toLogFileName:@"testLog.txt"];
}

- (IBAction)removeLogFile:(id)sender {
    [CJLogUtil cj_removeLogFileName:@"testLog.txt"];
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
