//
//  ViewPandownViewController2.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "ViewPandownViewController2.h"
#import <CQDemoKit/CJUIKitToastUtil.h>
#import "UIView+CJPopupInView.h"

#import "CQUpdateContentPopupView.h"

#import "UIView+CJPanAction.h"
#import <CQDemoKit/CQTSRipeTableView.h>

@interface ViewPandownViewController2 () {
    
}

@end

@implementation ViewPandownViewController2

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
            autoLayoutModule.title = @"仿抖音评论下拉2(tableView)";
            autoLayoutModule.actionBlock = ^{
                CQTSRipeTableView *tableView = [[CQTSRipeTableView alloc] initWithSectionRowCounts:@[@3, @4, @5]];
                [self __popupView:tableView];
            };
            [sectionDataModel.values addObject:autoLayoutModule];
        }
       
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

#pragma mark - Private Method
- (void)__popupView:(UIView *)popupView {
    UIView *panContainer = [UIView new];
    
    UIView *panLineView = [UIView new];
    panLineView.layer.cornerRadius = 4;
    panLineView.layer.masksToBounds = YES;
    panLineView.backgroundColor = [UIColor lightGrayColor];
    [panContainer addSubview:panLineView];
    [panLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(panContainer);
        make.centerX.mas_equalTo(panContainer);
        make.width.mas_equalTo(40);
        make.height.mas_equalTo(6);
    }];
    
    [panContainer addSubview:popupView];
    [popupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(panLineView.mas_bottom).mas_offset(10);
        make.left.right.mas_equalTo(panContainer);
        make.bottom.mas_equalTo(panContainer);
    }];
    
    [panContainer cj_addPanWithPanCompleteDismissBlock:^{
        [panContainer cj_hidePopupView];
    }];
    
    CGFloat popupViewHeight = 400;
    [panContainer cj_popupInBottomInView:nil animationType:CJAnimationTypeNormal withHeight:popupViewHeight edgeInsets:UIEdgeInsetsZero showBeforeConfigBlock:nil showComplete:^{
        NSLog(@"显示完成");
        
    } tapBlankComplete:^{
        NSLog(@"点击背景完成");
        [panContainer cj_hidePopupView];
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
