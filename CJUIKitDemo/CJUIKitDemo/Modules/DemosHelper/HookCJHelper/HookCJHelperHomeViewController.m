//
//  HookCJHelperHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "HookCJHelperHomeViewController.h"

#import "HookCJHelperSwizzleViewController.h"
#import "HookCJHelperChangeViewController.h"

@interface HookCJHelperHomeViewController ()

@end

@implementation HookCJHelperHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"HookCJHelper首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //Helper
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"HookCJHelper";
        {
            CJModuleModel *helperModule = [[CJModuleModel alloc] init];
            helperModule.title = @"HookCJHelper:Swizzle";
            helperModule.classEntry = [HookCJHelperSwizzleViewController class];
            [sectionDataModel.values addObject:helperModule];
        }
        {
            CJModuleModel *helperModule = [[CJModuleModel alloc] init];
            helperModule.title = @"HookCJHelper:Change";
            helperModule.classEntry = [HookCJHelperChangeViewController class];
            [sectionDataModel.values addObject:helperModule];
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
