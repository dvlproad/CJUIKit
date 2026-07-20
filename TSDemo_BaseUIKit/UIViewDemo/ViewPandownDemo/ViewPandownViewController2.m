//
//  ViewPandownViewController2.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "ViewPandownViewController2.h"
#import <CQDemoKit/CJUIKitToastUtil.h>
//#import <CQPopupContainerAnimation/UIView+CJPopupFrameAnimation.h>

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
    
    
    UIView *popupSuperview = [[UIApplication sharedApplication] keyWindow];
    
    
    CGFloat popupViewHeight = 400;
    
    CGFloat popupViewWidth = CGRectGetWidth(popupSuperview.frame) - 0 - 0;
    CGFloat popupViewX = 0;
    CGFloat popupViewShowY = CGRectGetHeight(popupSuperview.frame) - popupViewHeight - 0;
    CGRect popupViewShowFrame = CGRectMake(popupViewX, popupViewShowY, popupViewWidth, popupViewHeight);
    
    CGRect popupViewHideFrame = popupViewShowFrame;
    popupViewHideFrame.size.height = 0;
    
    
    [panContainer cj_addPanWithPanCompleteDismissBlock:^{
        [UIView animateWithDuration:0.3 animations:^{
            panContainer.alpha = 0.0f;
            panContainer.frame = popupViewHideFrame;
         } completion:^(BOOL finished) {
             NSLog(@"关闭完成");
         }];
    }];
    
  
    panContainer.frame = popupViewHideFrame;
    [UIView animateWithDuration:0.3 animations:^{
        panContainer.alpha = 1.0f; // 修复单例时候，在隐藏过后，想再显示，没法继续显示的问题
        panContainer.frame = popupViewShowFrame;
        NSLog(@"显示完成");
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
