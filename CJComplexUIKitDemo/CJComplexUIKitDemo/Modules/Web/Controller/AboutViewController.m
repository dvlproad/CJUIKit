//
//  AboutViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2018/2/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"关于网页(网络)", nil);
    
    NSString *networkUrl = @"https://fir.im/9u12";  //BeyondApp
    self.networkUrl = networkUrl;
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
