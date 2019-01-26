//
//  CJUIKitBaseScrollViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseScrollViewController.h"

@interface CJUIKitBaseScrollViewController ()

@end

@implementation CJUIKitBaseScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.backgroundColor = CJColorFromHexString(@"#f2f2f2");
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(self.view);
    }];
    self.scrollView = scrollView;
    
    UIView *containerView = [[UIView alloc] init];
    //containerView.backgroundColor = [UIColor greenColor];
    [scrollView addSubview:containerView];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(scrollView);
        make.top.bottom.mas_equalTo(scrollView);
        make.width.mas_equalTo(scrollView.mas_width);
        make.height.mas_equalTo(scrollView.mas_height).mas_offset(1);
    }];
    self.containerView = containerView;
}

/// 更新containerView与lastBottomView的底部间隔，未调用时containerView的高为比scrollView多1像素
- (void)updateScrollHeightWithLastBottomView:(UIView *)lastBottomView bottom:(CGFloat)bottom {
    NSAssert(bottom > 0, @"Error:scrollView与lastBottomView的底部间隔必须大于0");
    
    [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.scrollView);
        make.top.bottom.mas_equalTo(self.scrollView);
        make.width.mas_equalTo(self.scrollView.mas_width);
        make.bottom.mas_equalTo(lastBottomView.mas_bottom).mas_offset(bottom);
    }];
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
