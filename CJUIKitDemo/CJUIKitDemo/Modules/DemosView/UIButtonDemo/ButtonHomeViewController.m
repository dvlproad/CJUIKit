//
//  ButtonHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ButtonHomeViewController.h"
#import "ButtonCategoryViewController.h"
#import "ButtonStructureViewController.h"
#import "BadgeButtonViewController.h"

@interface ButtonHomeViewController ()

@end

@implementation ButtonHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"UIButton首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //UIButton(按钮)
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIButton(按钮)";
        {
            //Category
            CJModuleModel *buttonModule = [[CJModuleModel alloc] init];
            buttonModule.title = @"Button Category";
            buttonModule.classEntry = [ButtonCategoryViewController class];
            [sectionDataModel.values addObject:buttonModule];
        }
        {
            //Badge
            CJModuleModel *buttonModule = [[CJModuleModel alloc] init];
            buttonModule.title = @"BadgeButton";
            buttonModule.classEntry = [BadgeButtonViewController class];
            [sectionDataModel.values addObject:buttonModule];
        }
        {
            //Structure
            CJModuleModel *sliderModule = [[CJModuleModel alloc] init];
            sliderModule.title = @"StructureButton";
            sliderModule.classEntry = [ButtonStructureViewController class];
            [sectionDataModel.values addObject:sliderModule];
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
