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
#import "PopupInViewVC.h"
#import "ShowExtendViewVC.h"
#import "ShowDropDownViewController.h"

//ViewAnimate
#import "ViewAnimateViewController.h"

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
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView+CJDragAction";
        {
            CJModuleModel *dragViewModule = [[CJModuleModel alloc] init];
            dragViewModule.title = @"Drag And KeepBounds (视图的拖曳和吸附)";
            dragViewModule.classEntry = [DragViewController class];
            dragViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:dragViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    //Animation
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView+CJAnimation";
        {
            CJModuleModel *animateViewModule = [[CJModuleModel alloc] init];
            animateViewModule.title = @"ViewAnimate (View动画)";
            animateViewModule.classEntry = [ViewAnimateViewController class];
            animateViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:animateViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    //Popup
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIView+CJPopupInView";
        {
            CJModuleModel *popupInViewModule = [[CJModuleModel alloc] init];
            popupInViewModule.title = @"PopupInView (弹出到任意View)";
            popupInViewModule.classEntry = [PopupInViewVC class];
            popupInViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:popupInViewModule];
        }
        {
            CJModuleModel *popupInWindowModule = [[CJModuleModel alloc] init];
            popupInWindowModule.title = @"PopupInWindow (弹出到Window)";
            popupInWindowModule.classEntry = [PopupInWindowVC class];
            popupInWindowModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:popupInWindowModule];
        }
        {
            CJModuleModel *showExtendViewModule = [[CJModuleModel alloc] init];
            showExtendViewModule.title = @"ShowExtendView (弹出任意视图)";
            showExtendViewModule.classEntry = [ShowExtendViewVC class];
            showExtendViewModule.isCreateByXib = YES;
            [sectionDataModel.values addObject:showExtendViewModule];
        }
        {
            CJModuleModel *showDropDownViewModule = [[CJModuleModel alloc] init];
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
