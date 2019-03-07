//
//  HookCJHelperSwizzleViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/28.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "HookCJHelperSwizzleViewController.h"
#import "TestHookModel1+TestHook.h"
#import "TestHookModel2.h"
#import <CJBaseHelper/HookCJHelper.h>

@interface HookCJHelperSwizzleViewController () {
    
}
@property (nonatomic, strong) TestHookModel1 *testHookModel1;
@property (nonatomic, strong) TestHookModel2 *testHookModel2;

@end

@implementation HookCJHelperSwizzleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"HookCJHelper首页", nil);
    
    TestHookModel1 *testHookModel1 = [[TestHookModel1 alloc] init];
    self.testHookModel1 = testHookModel1;
    
    TestHookModel2 *testHookModel2 = [[TestHookModel2 alloc] init];
    self.testHookModel2 = testHookModel2;
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //HookCJHelper
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"SwizzleMethod";
        {
            CJModuleModel *hookModule = [[CJModuleModel alloc] init];
            hookModule.title = @"SwizzleMethod InSameClass";
            hookModule.selector = @selector(swizzleMethodInSameClass);
            [sectionDataModel.values addObject:hookModule];
        }
        {
            CJModuleModel *hookModule = [[CJModuleModel alloc] init];
            hookModule.title = @"swizzleMethod_fromOtherself_same";
            hookModule.content = @"使用B类中的'A类已有的方法'来替换A类中的方法";
            hookModule.selector = @selector(swizzleMethod_fromOtherself_same);
            [sectionDataModel.values addObject:hookModule];
        }
        {
            CJModuleModel *hookModule = [[CJModuleModel alloc] init];
            hookModule.title = @"swizzleMethod_fromOtherself_diff";
            hookModule.content = @"使用B类中的'A类没有的方法'来替换A类中的方法";
            hookModule.selector = @selector(swizzleMethod_fromOtherself_diff);
            [sectionDataModel.values addObject:hookModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}


#pragma mark - hook InSameClass
- (void)swizzleMethodInSameClass {
    SEL originalSelector = @selector(printLog);
    SEL swizzledSelector = @selector(common_swizzle_printLog);
    HookCJHelper_swizzleMethod([TestHookModel1 class], originalSelector, swizzledSelector);
    
    NSString *message1 = [self.testHookModel1 printLog];
    NSString *message2 = [self.testHookModel1 common_swizzle_printLog];
    if ([message1 isEqualToString:TestHookModel1_originMethod] &&
        [message2 isEqualToString:TestHookModel1_sameMethod]) {
        NSMutableString *message = [NSMutableString stringWithFormat:@"hook恢复了:"];
        [message appendFormat:@"\n%@", message1];
        [message appendFormat:@"\n%@", message2];
        [CJToast shortShowMessage:message];
        
    } else if ([message1 isEqualToString:TestHookModel1_sameMethod] &&
               [message2 isEqualToString:TestHookModel1_originMethod]) {
        NSMutableString *message = [NSMutableString stringWithFormat:@"hook成功了:"];
        [message appendFormat:@"\n%@", message1];
        [message appendFormat:@"\n%@", message2];
        [CJToast shortShowMessage:message];
        [CJToast shortShowMessage:message];
        
    } else {
        [DemoAlert showErrorToastAlertViewTitle:@"hook失败"];
    }
}

- (void)swizzleMethod_fromOtherself_same {
    SEL originalSelector = @selector(printLog);
    SEL swizzledSelector = @selector(common_swizzle_printLog);
    
    bool success =
    HookCJHelper_exchangeOriMethodToNewMethodWhichAddFromDiffClass([TestHookModel1 class], originalSelector, [TestHookModel2 class], swizzledSelector);
    if (!success) {
        NSLog(@"exchangeOriMethodToNewMethod:%@", success ? @"success": @"failure");
        [CJToast shortShowMessage:@"Verificate Success\nbeacuse swizzledSelector isn't a new method for class1"];
        return;
    }
}




- (void)swizzleMethod_fromOtherself_diff {
    SEL originalSelector = @selector(printLog);
    SEL swizzledSelector = @selector(diff_swizzle_printLog);
    
    static BOOL isFirstAddAndExchange_fromOtherself_diff = YES;
    bool isAddAndExchangeSuccess =
    HookCJHelper_exchangeOriMethodToNewMethodWhichAddFromDiffClass([TestHookModel1 class], originalSelector, [TestHookModel2 class], swizzledSelector);
    if (isFirstAddAndExchange_fromOtherself_diff && !isAddAndExchangeSuccess) {
        [CJToast shortShowMessage:@"addAndExchangeMethodFromDiffClass Failure"];
        return;
    }
    isFirstAddAndExchange_fromOtherself_diff = NO;
    
    NSString *message1 = [self.testHookModel1 printLog];
    NSString *message2 = [self.testHookModel2 diff_swizzle_printLog];
    if ([message1 isEqualToString:TestHookModel2_diffMethod] &&
        [message2 isEqualToString:TestHookModel2_diffMethod]) {
        NSMutableString *message = [NSMutableString stringWithFormat:@"diff class diff method change成功了:"];
        [message appendFormat:@"\n%@", message1];
        [message appendFormat:@"\n%@", message2];
        [CJToast shortShowMessage:message];
        
    } else if ([message1 isEqualToString:TestHookModel1_originMethod] &&
               [message2 isEqualToString:TestHookModel2_diffMethod]) {
        NSMutableString *message = [NSMutableString stringWithFormat:@"diff class diff method recover成功了:"];
        [message appendFormat:@"\n%@", message1];
        [message appendFormat:@"\n%@", message2];
        [CJToast shortShowMessage:message];
        
    } else {
        [DemoAlert showErrorToastAlertViewTitle:@"diff class diff method change失败"];
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
