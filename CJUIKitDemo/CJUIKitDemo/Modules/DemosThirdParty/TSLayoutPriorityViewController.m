//
//  TSLayoutPriorityViewController.m
//  CJUIKitDemo
//
//  Created by qian on 2021/4/7.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import "TSLayoutPriorityViewController.h"
#import <CQDemoKit/CQTSContainerViewFactory.h>
#import "TSBugLayoutPriorityView.h"

#import <CQDemoKit/CQTSButtonFactory.h>

@interface TSLayoutPriorityViewController () {
    
}

@end

@implementation TSLayoutPriorityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self setupViews];
}

- (void)setupViews {
    TSBugLayoutPriorityView *priorityView11 = [[TSBugLayoutPriorityView alloc] initWithFrame:CGRectZero];
    [priorityView11 updateName:@"无标志：字比较少" withRecognizePass:NO];
    
    TSBugLayoutPriorityView *priorityView12 = [[TSBugLayoutPriorityView alloc] initWithFrame:CGRectZero];
    [priorityView12 updateName:@"无标志：昵称超长这是个很长的昵称你显示不下的" withRecognizePass:NO];
    
    TSBugLayoutPriorityView *priorityView21 = [[TSBugLayoutPriorityView alloc] initWithFrame:CGRectZero];
    [priorityView21 updateName:@"有标志：字比较少" withRecognizePass:YES];
    
    TSBugLayoutPriorityView *priorityView22 = [[TSBugLayoutPriorityView alloc] initWithFrame:CGRectZero];
    [priorityView22 updateName:@"有标志：昵称超长这是个很长的昵称你显示不下的" withRecognizePass:YES];
    
    NSArray<UIView *> *subViews = @[priorityView11, priorityView12, priorityView21, priorityView22];
    UIView *containerView = [CQTSContainerViewFactory containerViewAlongAxis:MASAxisTypeVertical withSubviews:subViews fixedSpacing:40];
    [self.containerView addSubview:containerView];
    CGFloat priorityViewHeight = [TSBugLayoutPriorityView viewHeight];
    [containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.containerView);
        make.height.mas_equalTo(priorityViewHeight*4+3*40);
        make.centerX.mas_equalTo(self.containerView);
        make.left.mas_equalTo(self.containerView).mas_offset(10);
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
