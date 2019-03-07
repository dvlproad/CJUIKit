//
//  HookCJHelperChangeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/28.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "HookCJHelperChangeViewController.h"
#import "TestChangeModel1+TestChange.h"
#import "TestChangeModel2.h"
#import <CJBaseHelper/HookCJHelper.h>

@interface HookCJHelperChangeViewController () {
    
}
@property (nonatomic, strong) TestChangeModel1 *testChangeModel1;
@property (nonatomic, strong) TestChangeModel2 *testChangeModel2;

@end

@implementation HookCJHelperChangeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"HookCJHelper首页", nil);
    
    TestChangeModel1 *testChangeModel1 = [[TestChangeModel1 alloc] init];
    self.testChangeModel1 = testChangeModel1;
    
    TestChangeModel2 *testChangeModel2 = [[TestChangeModel2 alloc] init];
    self.testChangeModel2 = testChangeModel2;
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //changeMethod
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"changeMethod";
        {
            CJModuleModel *hookModule = [[CJModuleModel alloc] init];
            hookModule.title = @"changeMethod_fromHimself";
            hookModule.content = @"使用A类中的'A类本身的方法'来替换A类中的方法";
            hookModule.selector = @selector(changeMethod_fromHimself);
            [sectionDataModel.values addObject:hookModule];
        }
        {
            CJModuleModel *hookModule = [[CJModuleModel alloc] init];
            hookModule.title = @"changeMethod_fromOtherself_same";
            hookModule.content = @"使用B类中的'A类已有的方法'来替换A类中的方法";
            hookModule.selector = @selector(changeMethod_fromOtherself_same);
            [sectionDataModel.values addObject:hookModule];
        }
        {
            CJModuleModel *hookModule = [[CJModuleModel alloc] init];
            hookModule.title = @"changeMethod_fromOtherself_diff";
            hookModule.content = @"使用B类中的'A类没有的方法'来替换A类中的方法";
            hookModule.selector = @selector(changeMethod_fromOtherself_diff);
            [sectionDataModel.values addObject:hookModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}



#pragma mark - hook InDiffClass sameMethod
- (void)changeMethod_fromHimself {
    SEL originalSelector = @selector(printLog);
    SEL swizzledSelector = @selector(common_change_printLog);
    HookCJHelper_replaceMethod([TestChangeModel1 class], originalSelector, [TestChangeModel1 class], swizzledSelector);
    
    NSString *message1 = [self.testChangeModel1 printLog];
    NSString *message2 = [self.testChangeModel1 common_change_printLog];
    if ([message1 isEqualToString:TestChangeModel1_sameMethod] &&
        [message2 isEqualToString:TestChangeModel1_sameMethod]) {
        NSMutableString *message = [NSMutableString stringWithFormat:@"same class diff method change成功了:"];
        [message appendFormat:@"\n%@", message1];
        [message appendFormat:@"\n%@", message2];
        [CJToast shortShowMessage:message];
    } else if ([message1 isEqualToString:TestChangeModel1_originMethod] &&
               [message2 isEqualToString:TestChangeModel1_sameMethod]) {
        NSMutableString *message = [NSMutableString stringWithFormat:@"same class diff method recover成功了:"];
        [message appendFormat:@"\n%@", message1];
        [message appendFormat:@"\n%@", message2];
        [CJToast shortShowMessage:message];
    } else {
        [DemoAlert showErrorToastAlertViewTitle:@"same class diff method change失败"];
    }
}

- (void)changeMethod_fromOtherself_same {
    SEL originalSelector = @selector(printLog);
    SEL swizzledSelector = @selector(common_change_printLog);
    HookCJHelper_replaceMethod([TestChangeModel1 class], originalSelector, [TestChangeModel2 class], swizzledSelector);
    
    NSString *message1 = [self.testChangeModel1 printLog];
    NSString *message2 = [self.testChangeModel2 common_change_printLog];
    if ([message1 isEqualToString:TestChangeModel2_sameMethod] &&
        [message2 isEqualToString:TestChangeModel2_sameMethod]) {
        NSMutableString *message = [NSMutableString stringWithFormat:@"diff class same method change成功了:"];
        [message appendFormat:@"\n%@", message1];
        [message appendFormat:@"\n%@", message2];
        [CJToast shortShowMessage:message];
    } else if ([message1 isEqualToString:TestChangeModel1_originMethod] &&
               [message2 isEqualToString:TestChangeModel2_sameMethod]) {
        NSMutableString *message = [NSMutableString stringWithFormat:@"diff class same method recover成功了:"];
        [message appendFormat:@"\n%@", message1];
        [message appendFormat:@"\n%@", message2];
        [CJToast shortShowMessage:message];
    } else {
        [DemoAlert showErrorToastAlertViewTitle:@"diff class same method change失败"];
    }
}

- (void)changeMethod_fromOtherself_diff {
    SEL originalSelector = @selector(printLog);
    SEL swizzledSelector = @selector(diff_change_printLog);
    HookCJHelper_replaceMethod([TestChangeModel1 class], originalSelector, [TestChangeModel2 class], swizzledSelector);
    
    NSString *message1 = [self.testChangeModel1 printLog];
    NSString *message2 = [self.testChangeModel2 diff_change_printLog];
    if ([message1 isEqualToString:TestChangeModel2_diffMethod] &&
        [message2 isEqualToString:TestChangeModel2_diffMethod]) {
        NSMutableString *message = [NSMutableString stringWithFormat:@"diff class diff method change成功了:"];
        [message appendFormat:@"\n%@", message1];
        [message appendFormat:@"\n%@", message2];
        [CJToast shortShowMessage:message];
        
    } else if ([message1 isEqualToString:TestChangeModel1_originMethod] &&
               [message2 isEqualToString:TestChangeModel2_diffMethod]) {
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
