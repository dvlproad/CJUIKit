//
//  LocalBaseWebViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "LocalBaseWebViewController.h"
#import <CJBaseUIKit/UIColor+CJHex.h>

@interface LocalBaseWebViewController ()

@end

@implementation LocalBaseWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = CJColorFromHexString(@"#f2f2f2");
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
