//
//  PopupInWindowVC.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "PopupInWindowVC.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import <CQDemoKit/CJUIKitToastUtil.h>
#import "UIView+CJPopupInView.h"
#import "UIView+CJAutoMoveUp.h"

#import "UIView+CJToastInView.h"

#import "WelcomeViewToPop.h"
#import "WelcomePopupView.h"


@interface PopupInWindowVC ()<CJPopupViewDelegate>

@end

@implementation PopupInWindowVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"PopupInWindow首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    [IQKeyboardManager sharedManager].enable = NO; // 禁用 IQKeyboardManager
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 弹出Toast
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"弹出到屏幕中间（用于Toast）";
        {
            CQDMModuleModel *toastModule = [[CQDMModuleModel alloc] init];
            toastModule.title = @"中间Toast(弹出的视图中心处于window中心)";
            toastModule.actionBlock = ^{
                UIView *view = [UIView new];
                view.backgroundColor = [UIColor redColor];
                view.layer.cornerRadius = 23;
                [view cj_toastCenterInView:self.view
                                  withSize:CGSizeMake(180, 46)
                              centerOffset:CGPointZero
                                  animated:YES];
                [view cj_toastHiddenWithAnimated:YES afterDelay:2.0];
            };
            [sectionDataModel.values addObject:toastModule];
        }
        {
            CQDMModuleModel *toastModule = [[CQDMModuleModel alloc] init];
            toastModule.title = @"中间Toast(弹出的视图中心偏离window中心）";
            toastModule.actionBlock = ^{
                UIView *view = [UIView new];
                view.backgroundColor = [UIColor redColor];
                view.layer.cornerRadius = 23;
                [view cj_toastCenterInView:self.view
                                  withSize:CGSizeMake(180, 46)
                              centerOffset:CGPointMake(0, -100)
                                  animated:YES];
                [view cj_toastHiddenWithAnimated:YES afterDelay:2.0];
            };
            [sectionDataModel.values addObject:toastModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 弹出到屏幕中间
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"弹出到屏幕中间";
        {
            CQDMModuleModel *autoLayoutModule = [[CQDMModuleModel alloc] init];
            autoLayoutModule.title = @"中间(弹出的视图中心处于window中心)";
            autoLayoutModule.selector = @selector(popupInWindow_center1);
            [sectionDataModel.values addObject:autoLayoutModule];
        }
        {
            CQDMModuleModel *autoLayoutModule = [[CQDMModuleModel alloc] init];
            autoLayoutModule.title = @"中间(弹出的视图中心偏离window中心)";
            autoLayoutModule.selector = @selector(popupInWindow_center2);
            [sectionDataModel.values addObject:autoLayoutModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 弹出到屏幕底部
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"弹出到屏幕底部";
        {
            CQDMModuleModel *autoLayoutModule = [[CQDMModuleModel alloc] init];
            autoLayoutModule.title = @"底部(弹出的视图在window底部)";
            autoLayoutModule.selector = @selector(popupInWindow_bottom1);
            [sectionDataModel.values addObject:autoLayoutModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}



- (void)popupInWindow_center1 {
    WelcomePopupView *popupView = [self welcomePopupView];
    
    CGSize popupViewSize = popupView.frame.size;
    //popupViewSize = CGSizeMake(200, 200);
    [popupView cj_popupInCenterWindow:CJAnimationTypeCATransform3D withSize:popupViewSize centerOffset:CGPointZero blankViewCreateBlock:nil showComplete:^{
        NSLog(@"显示完成");
        
    } tapBlankComplete:^{
        NSLog(@"点击背景完成");
        [popupView cj_hidePopupView];
    }];
}

- (void)popupInWindow_center2 {
    WelcomePopupView *popupView = [self welcomePopupView];
    
    CGSize popupViewSize = popupView.frame.size;
    //popupViewSize = CGSizeMake(200, 200);
    [popupView cj_popupInCenterWindow:CJAnimationTypeCATransform3D withSize:popupViewSize centerOffset:CGPointMake(0, 30) blankViewCreateBlock:nil showComplete:^{
        NSLog(@"显示完成");
        
    } tapBlankComplete:^{
        NSLog(@"点击背景完成");
        [popupView cj_hidePopupView];
    }];
}


- (WelcomePopupView *)welcomePopupView {
    //    WelcomeViewToPop *popupView = (WelcomeViewToPop *)[[[NSBundle mainBundle] loadNibNamed:@"WelcomeViewToPop" owner:nil options:nil] lastObject];
        WelcomePopupView *popupView = (WelcomePopupView *)[[[NSBundle mainBundle] loadNibNamed:@"WelcomePopupView" owner:nil options:nil] lastObject];
    //    popupView.cjExtraOffset = 20;
        
        popupView.popupViewDelegate = self;
        popupView.outestView = self.view;
    
    return popupView;
}

- (void)popupInWindow_bottom1 {
    WelcomeViewToPop *popupView = (WelcomeViewToPop *)[[[NSBundle mainBundle] loadNibNamed:@"WelcomeViewToPop" owner:nil options:nil] lastObject];
    popupView.popupViewDelegate = self;
//    [popupView cj_autoMoveUpByKeyboard:NO spacing:0];
    
    CGFloat popupViewHeight = CGRectGetHeight(popupView.frame);
    [popupView cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight edgeInsets:UIEdgeInsetsZero blankViewCreateBlock:nil showComplete:^{
        NSLog(@"显示完成");
        
    } tapBlankComplete:^{
        NSLog(@"点击背景完成");
        [popupView cj_hidePopupView];
    }];
}

#pragma mark - CJPopupViewDelegate
- (void)cjPopupView_Confirm:(UIView *)popupView {
    [popupView cj_hidePopupView];
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
