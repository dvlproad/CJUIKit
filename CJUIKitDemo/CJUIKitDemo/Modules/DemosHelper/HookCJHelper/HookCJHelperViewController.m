//
//  HookCJHelperViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/28.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "HookCJHelperViewController.h"
#import "TestHookModel1+TestHook.h"
#import "TestHookModel2.h"
#import <CJBaseHelper/HookCJHelper.h>

@interface HookCJHelperViewController () {
    
}
@property (nonatomic, strong) TestHookModel1 *testHookModel1;

@end

@implementation HookCJHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"HookCJHelper首页", nil);
    
    TestHookModel1 *testHookModel1 = [[TestHookModel1 alloc] init];
    self.testHookModel1 = testHookModel1;
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //HookCJHelper
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"HookCJHelper相关";
//        {
//
//            CJModuleModel *hookModule = [[CJModuleModel alloc] init];
//            hookModule.title = @"未Hook时候";
//            hookModule.actionBlock = ^{
////                NSString *message1 = [self.testHookModel1 printLog];
////                NSAssert([message1 isEqualToString:unhook_TestHookModel1], @"unhook时候错误");
//
//                SEL originalSelector = @selector(swizzle_printLog);
//                SEL swizzledSelector = @selector(printLog);
//                HookCJHelper_recoverMethodInSameClass([TestHookModel1 class], originalSelector, swizzledSelector);
//
//                NSString *message = [self.testHookModel1 printLog];
//                NSString *message2 = [self.testHookModel1 swizzle_printLog];
//                if (![message isEqualToString:unhook_TestHookModel1]) {
//                    [DemoAlert showErrorToastAlertViewTitle:@"unhook时候错误"];
//                } else {
//                    [CJToast shortShowMessage:message];
//                }
//            };
//            [sectionDataModel.values addObject:hookModule];
//        }
        {
            
            CJModuleModel *hookModule = [[CJModuleModel alloc] init];
            hookModule.title = @"Hook InSameClass";
            hookModule.actionBlock = ^{
                SEL originalSelector = @selector(printLog);
                SEL swizzledSelector = @selector(swizzle_printLog);
                HookCJHelper_swizzleMethodInSameClass([TestHookModel1 class], originalSelector, swizzledSelector);
                
                NSString *message = [self.testHookModel1 printLog];
                if (![message isEqualToString:hook_TestHookModel1]) {
                    [DemoAlert showErrorToastAlertViewTitle:@"hook失败"];
                } else {
                    [CJToast shortShowMessage:message];
                }
            };
            [sectionDataModel.values addObject:hookModule];
        }
        {
            CJModuleModel *hookModule = [[CJModuleModel alloc] init];
            hookModule.title = @"Hook InDiffClass";
            hookModule.actionBlock = ^{
                SEL originalSelector = @selector(printLog);
                SEL swizzledSelector = @selector(swizzle_printLog);
                HookCJHelper_swizzleMethodInDiffClass([TestHookModel1 class], originalSelector, [TestHookModel2 class], swizzledSelector);
                
                NSString *message = [self.testHookModel1 printLog];
                if (![message isEqualToString:hook_TestHookModel2]) {
                    [DemoAlert showErrorToastAlertViewTitle:@"hook失败"];
                } else {
                    [CJToast shortShowMessage:message];
                }
            };
            [sectionDataModel.values addObject:hookModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
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
