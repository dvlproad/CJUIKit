//
//  ScrollContaintViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "ScrollContaintViewController.h"
#import "UIScrollView+CJAddFillView.h"

@interface ScrollContaintViewController ()

@end

@implementation ScrollContaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"ScrollView(纯代码创建)", nil);
    self.view.backgroundColor = CJColorFromHexString(@"#f2f2f2");
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = [UIColor redColor];
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.centerX.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(140);
        make.height.mas_equalTo(200);
    }];
    UIView *view1 = [UIView new];
    view1.backgroundColor = [UIColor greenColor];
    [scrollView cj_addFillView:view1];
//    [scrollView cj_setupContentSizeByView:view1 exceptBottomFromView:nil heighExceedValue:1];
    
//    UIView *scrollSuperView2 = [[UIView alloc] init];
//    [self.view addSubview:scrollSuperView2];
//    [scrollSuperView2 mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.mas_equalTo(self.view).mas_offset(20);
//        make.centerX.mas_equalTo(self.view);
//        make.top.mas_equalTo(scrollSuperView1.mas_bottom).mas_offset(40);
//        make.height.mas_equalTo(200);
//    }];
//
    
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
