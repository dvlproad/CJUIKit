//
//  ColorViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "ColorViewController.h"
#import "UIColor+CJHex.h"

@interface ColorViewController ()

@end

@implementation ColorViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = NSLocalizedString(@"CJBadgeButton", nil);
    
    //以下三种设置颜色一样
    self.view.backgroundColor = CJColorFromHexValue(0x43FBFE);
    self.view.backgroundColor = [UIColor cjColorWithHexString:@"0x43FBFE"];
    self.view.backgroundColor = [UIColor cjColorWithHexString:@"#43FBFE"];
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
