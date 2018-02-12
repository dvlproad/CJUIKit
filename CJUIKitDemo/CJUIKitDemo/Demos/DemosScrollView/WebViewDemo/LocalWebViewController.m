//
//  LocalWebViewController.m
//  CJUIKitDemo
//
//  Created by lichq on 2018/2/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "LocalWebViewController.h"

@interface LocalWebViewController ()

@end

@implementation LocalWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    NSString *localHtmlUrl = [[NSBundle mainBundle] pathForResource:@"index.html" ofType:nil];
    self.requestUrl = localHtmlUrl;
    
    [self reloadLocalWeb];
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
