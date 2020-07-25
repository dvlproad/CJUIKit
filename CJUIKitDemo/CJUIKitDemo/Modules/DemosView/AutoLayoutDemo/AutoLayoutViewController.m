//
//  AutoLayoutViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/18.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "AutoLayoutViewController.h"

@interface AutoLayoutViewController () {
    
}
@end

@implementation AutoLayoutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"intrinsic content size", nil);
    
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor redColor];
    label.font = [UIFont systemFontOfSize:17];
    label.text = @"Hello";
    [self.view addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_topLayoutGuide).offset(16);
        make.left.equalTo(self.view.mas_left).offset(16);
    }];
    
    UIView *contentView1 = [self contentViewWith:NO];
    [self.view addSubview:contentView1];
    [contentView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(label.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    
    
    UIView *contentView2 = [self contentViewWith:YES];
    [self.view addSubview:contentView2];
    [contentView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView1.mas_bottom).offset(20);
        make.left.right.equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
}

//在同一行中显示标题和时间，时间必须显示完全，标题如果太长就截取可显示的部分，剩余的用…表示。
- (UIView *)contentViewWith:(BOOL)b {
    UIView *contentView = [[UIView alloc] init];
    contentView.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.backgroundColor = [UIColor redColor];
    titleLabel.text = @"Each of these constraints can have its own priority. By default, ";
    titleLabel.font = [UIFont systemFontOfSize:17];
    [contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(contentView.mas_top);
        make.left.equalTo(contentView.mas_left).offset(16);
    }];
        
    UILabel *timeLabel = [[UILabel alloc] init];
    timeLabel.backgroundColor = [UIColor greenColor];
    timeLabel.text = @"2017/03/12 18:20:22";
    timeLabel.font = [UIFont systemFontOfSize:17];
    [contentView addSubview:timeLabel];
    [timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(titleLabel.mas_top);
        make.left.equalTo(titleLabel.mas_right).offset(8);
        make.right.lessThanOrEqualTo(contentView.mas_right).offset(-8);
    }];
    
    if (b) {
        [timeLabel setContentCompressionResistancePriority:UILayoutPriorityRequired forAxis:UILayoutConstraintAxisHorizontal];
        // 或
        //[titleLabel setContentHuggingPriority:UILayoutPriorityFittingSizeLevel forAxis:UILayoutConstraintAxisHorizontal];
    }
    
    return contentView;
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
