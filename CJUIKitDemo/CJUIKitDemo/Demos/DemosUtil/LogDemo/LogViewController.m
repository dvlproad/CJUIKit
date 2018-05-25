//
//  LogViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/5/25.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "LogViewController.h"
#import "CJLogUtil.h"

@interface LogViewController ()

@end

@implementation LogViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
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
