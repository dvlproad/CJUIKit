//
//  BBXAppViewController.m
//  CJUIKitDemo
//
//  Created by lichq on 2018/2/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "BBXAppViewController.h"

static NSString *const BBXAppRquestUrl = @"http://weixin.bbxpc.com/wechattest/order";

@interface BBXAppViewController ()

@end

@implementation BBXAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.requestUrl = BBXAppRquestUrl;
    
    [self reloadNetworkWeb];
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
