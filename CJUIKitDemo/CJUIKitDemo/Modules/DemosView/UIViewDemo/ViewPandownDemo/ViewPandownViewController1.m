//
//  ViewPandownViewController1.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "ViewPandownViewController1.h"
#import <CQDemoKit/CJUIKitToastUtil.h>
#import "UIView+CJPopupInView.h"

#import "CQUpdateContentPopupView.h"

#import "UIView+CJPanAction.h"
#import <CQDemoKit/CQTSRipeTableView.h>

#import "CQCommentsPopView.h"

@interface ViewPandownViewController1 () {
    
}

@end

@implementation ViewPandownViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"View Pandown (仿抖音评论下拉)", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 仿抖音评论下拉
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"仿抖音评论下拉";
        {
            CQDMModuleModel *autoLayoutModule = [[CQDMModuleModel alloc] init];
            autoLayoutModule.title = @"仿抖音评论下拉1(普通视图)";
            autoLayoutModule.actionBlock = ^{
                UIView *view = [UIView new];
                view.backgroundColor = [UIColor greenColor];
                
                [self __popupView:view];
            };
            [sectionDataModel.values addObject:autoLayoutModule];
        }
        
        {
            CQDMModuleModel *autoLayoutModule = [[CQDMModuleModel alloc] init];
            autoLayoutModule.title = @"仿抖音评论下拉2(tableView错误)";
            autoLayoutModule.actionBlock = ^{
                CQTSRipeTableView *tableView = [[CQTSRipeTableView alloc] initWithSectionRowCounts:@[@3, @4, @5]];
                [self __popupView:tableView];
            };
            [sectionDataModel.values addObject:autoLayoutModule];
        }
        
        {
            CQDMModuleModel *autoLayoutModule = [[CQDMModuleModel alloc] init];
            autoLayoutModule.title = @"仿抖音评论下拉3(tableView正确)";
            autoLayoutModule.actionBlock = ^{
                CQTSRipeTableView *tableView = [[CQTSRipeTableView alloc] initWithSectionRowCounts:@[@3, @4, @5]];
                
                UIView *commentView = [UIView new];
                [commentView addSubview:tableView];
                [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(commentView);
                }];
                
                [self __popupView:commentView];
            };
            [sectionDataModel.values addObject:autoLayoutModule];
        }
       
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 仿抖音评论下拉
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"仿抖音评论下拉";
        
        {
            CQDMModuleModel *popupInWindowModule = [[CQDMModuleModel alloc] init];
            popupInWindowModule.title = @"CQCommentsPopView";
            popupInWindowModule.actionBlock = ^{
                CQTSRipeTableView *tableView = [[CQTSRipeTableView alloc] initWithSectionRowCounts:@[@3, @4, @5]];
                
                UIView *commentView = [UIView new];
                [commentView addSubview:tableView];
                [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.edges.mas_equalTo(commentView);
                }];
                CQCommentsPopView *popView2 = [CQCommentsPopView commentsPopViewWithFrame:[UIScreen mainScreen].bounds commentBackView:commentView];
                [popView2 showToView:self.view];
            };

            [sectionDataModel.values addObject:popupInWindowModule];
        }
       
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

#pragma mark - Private Method
- (void)__popupView:(UIView *)commentView {
    [commentView cj_addPanWithPanCompleteDismissBlock:^{
        [commentView cj_hidePopupView];
    }];
    
    CGFloat popupViewHeight = 400;
    [commentView cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight edgeInsets:UIEdgeInsetsZero showBeforeConfigBlock:nil showComplete:^{
        NSLog(@"显示完成");
        
    } tapBlankComplete:^{
        NSLog(@"点击背景完成");
        [commentView cj_hidePopupView];
    }];
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
