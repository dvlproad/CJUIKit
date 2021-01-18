//
//  ViewHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ViewHomeViewController.h"

//ViewDrag
#import "DragViewController.h"

//ViewPopup
#import "PopupInWindowVC.h"
#import "KeyboardAutoMoveUpViewController.h"

#import "PopupInViewVC.h"
#import "ShowExtendViewVC.h"
#import "ShowDropDownViewController.h"

//ViewAnimate
#import "ViewAnimateViewController.h"

// View Pandown
#import "ViewPandownViewController1.h"
#import "ViewPandownViewController2.h"

#import "TSHideWindowView.h"
#import "UIView+CJPopupInView.h"

@interface ViewHomeViewController ()

@end

@implementation ViewHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"UIView首页(Drag+Popup+Animate)", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //Drag
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView+CJDragAction";
        {
            CQDMModuleModel *dragViewModule = [[CQDMModuleModel alloc] init];
            dragViewModule.title = @"Drag And KeepBounds (视图的拖曳和吸附)";
            dragViewModule.classEntry = [DragViewController class];
            dragViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:dragViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Animation
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView+CJAnimation";
        {
            CQDMModuleModel *animateViewModule = [[CQDMModuleModel alloc] init];
            animateViewModule.title = @"ViewAnimate (View动画)";
            animateViewModule.classEntry = [ViewAnimateViewController class];
            [sectionDataModel.values addObject:animateViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // View Pandown
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView+CJPanAction";
        {
            CQDMModuleModel *animateViewModule = [[CQDMModuleModel alloc] init];
            animateViewModule.title = @"View Pandown (仿抖音评论下拉,对列表需自己包装container)";
            animateViewModule.classEntry = [ViewPandownViewController1 class];
            [sectionDataModel.values addObject:animateViewModule];
        }
        {
            CQDMModuleModel *animateViewModule = [[CQDMModuleModel alloc] init];
            animateViewModule.title = @"View Pandown (仿抖音评论下拉,对所有都不需自己包装container)";
            animateViewModule.classEntry = [ViewPandownViewController2 class];
            [sectionDataModel.values addObject:animateViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // View AutoMoveUp
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView+CJAutoMoveUp";
        {
            CQDMModuleModel *animateViewModule = [[CQDMModuleModel alloc] init];
            animateViewModule.title = @"View AutoMoveUp (键盘上方的视图(跟随键盘))";
            animateViewModule.classEntry = [KeyboardAutoMoveUpViewController class];
            [sectionDataModel.values addObject:animateViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Popup
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView+CJPopupInView";
        {
            CQDMModuleModel *popupInViewModule = [[CQDMModuleModel alloc] init];
            popupInViewModule.title = @"PopupInView (弹出到任意View)";
            popupInViewModule.classEntry = [PopupInViewVC class];
            popupInViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:popupInViewModule];
        }
        {
            CQDMModuleModel *popupInWindowModule = [[CQDMModuleModel alloc] init];
            popupInWindowModule.title = @"PopupInWindow (弹出到Window)";
            popupInWindowModule.classEntry = [PopupInWindowVC class];

            [sectionDataModel.values addObject:popupInWindowModule];
        }
        {
            CQDMModuleModel *popupInWindowModule = [[CQDMModuleModel alloc] init];
            popupInWindowModule.title = @"弹出各种弹窗，一次性隐藏";
            popupInWindowModule.actionBlock = ^{
                [TSHideWindowView popWindows:5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [TSHideWindowView hideWindowPopupViews];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [TSHideWindowView reshowWindowPopupViews];
                    });
                });
            };
            [sectionDataModel.values addObject:popupInWindowModule];
        }
        {
            CQDMModuleModel *showExtendViewModule = [[CQDMModuleModel alloc] init];
            showExtendViewModule.title = @"ShowExtendView (弹出任意视图)";
            showExtendViewModule.classEntry = [ShowExtendViewVC class];
            showExtendViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:showExtendViewModule];
        }
        {
            CQDMModuleModel *showDropDownViewModule = [[CQDMModuleModel alloc] init];
            showDropDownViewModule.title = @"ShowDropDownView (弹出下拉视图)";
            showDropDownViewModule.classEntry = [ShowDropDownViewController class];
            showDropDownViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:showDropDownViewModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
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
