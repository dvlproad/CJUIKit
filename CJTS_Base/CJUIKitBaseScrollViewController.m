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
    scrollView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0]; // #f2f2f2
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

/**
 *  更新ScrollView的高
 *  @brief  ①如果没有lastBottomView来确认scrollView的高，那么高为根据父视图设置；
            ②如果有lastBottomView，则通过设置scrollView的containerView与lastBottomView的底部间隔来更新ScrollView的高
 *
 *  @param bottomInterval bottomInterval
 *  @param lastBottomView lastBottomView(可为nil)
 */
- (void)updateScrollHeightWithBottomInterval:(CGFloat)bottomInterval
                   accordingToLastBottomView:(UIView *)lastBottomView
{
    NSAssert(bottomInterval >= 0, @"Error:scrollView与lastBottomView的底部间隔不能小于0");
    
    if (lastBottomView == nil) {
        [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.scrollView);
            make.top.bottom.mas_equalTo(self.scrollView);
            make.width.mas_equalTo(self.scrollView.mas_width);
            make.height.mas_equalTo(self.scrollView.mas_height).mas_offset(bottomInterval);
        }];
    } else {
        [self.containerView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.scrollView);
            make.top.bottom.mas_equalTo(self.scrollView);
            make.width.mas_equalTo(self.scrollView.mas_width);
            make.bottom.mas_equalTo(lastBottomView.mas_bottom).mas_offset(bottomInterval);
        }];
    }
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
