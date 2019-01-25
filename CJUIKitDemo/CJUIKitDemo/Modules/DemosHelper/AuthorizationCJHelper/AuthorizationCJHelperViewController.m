//
//  AuthorizationCJHelperViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "AuthorizationCJHelperViewController.h"

@interface AuthorizationCJHelperViewController ()

@end

@implementation AuthorizationCJHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"AuthorizationCJHelper首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //AuthorizationCJHelper
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"AuthorizationCJHelper相关";
        {
            CJModuleModel *toastModule = [[CJModuleModel alloc] init];
            toastModule.title = @"系统--设置";
            toastModule.actionBlock = ^{
                openSettingCJHelper(^(BOOL success) {
                    if (success) {
                        [CJToast shortShowMessage:@"正在打开设置..."];
                    }
                });
            };
            [sectionDataModel.values addObject:toastModule];
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
