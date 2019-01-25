//
//  HelperHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "HelperHomeViewController.h"

#import "NSObjectCJHelperViewController.h"
#import "NSCalendarCJHelperViewController.h"
#import "AuthorizationCJHelperViewController.h"
#import "PresentAViewController.h"

@interface HelperHomeViewController ()

@end

@implementation HelperHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Helper首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //Helper
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"Helper";
        {
            CJModuleModel *helperModule = [[CJModuleModel alloc] init];
            helperModule.title = @"NSObjectCJHelper";
            helperModule.classEntry = [NSObjectCJHelperViewController class];
            [sectionDataModel.values addObject:helperModule];
        }
        {
            CJModuleModel *helperModule = [[CJModuleModel alloc] init];
            helperModule.title = @"NSCalendarCJHelper";
            helperModule.classEntry = [NSCalendarCJHelperViewController class];
            [sectionDataModel.values addObject:helperModule];
        }
        {
            CJModuleModel *helperModule = [[CJModuleModel alloc] init];
            helperModule.title = @"AuthorizationCJHelper";
            helperModule.classEntry = [AuthorizationCJHelperViewController class];
            [sectionDataModel.values addObject:helperModule];
        }
        {
            CJModuleModel *helperModule = [[CJModuleModel alloc] init];
            helperModule.title = @"UIViewControllerCJHelper";
            helperModule.content = @"获取present前的视图";
            helperModule.selector = @selector(testPresentViewController);
            [sectionDataModel.values addObject:helperModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    self.sectionDataModels = sectionDataModels;
}


- (void)testPresentViewController {
    PresentAViewController *viewController = [[PresentAViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:viewController];
    [self presentViewController:navigationController animated:YES completion:nil];
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
