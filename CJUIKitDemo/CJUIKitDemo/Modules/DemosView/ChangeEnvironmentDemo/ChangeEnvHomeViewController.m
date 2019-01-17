//
//  ChangeEnvHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "ChangeEnvHomeViewController.h"

#import "ChangeEnvironmentViewController.h"
#import "LoginChangeEnvironmentViewController.h"

@interface ChangeEnvHomeViewController ()

@end

@implementation ChangeEnvHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"ChangeEnv首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //ChangeEnvironment
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"ChangeEnvironment相关";
        {
            CJModuleModel *xibModule = [[CJModuleModel alloc] init];
            xibModule.title = @"ChangeEnvironment(改变网络环境)";
            xibModule.classEntry = [ChangeEnvironmentViewController class];
            xibModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:xibModule];
        }
        
        {
            CJModuleModel *xibModule = [[CJModuleModel alloc] init];
            xibModule.title = @"ChangeEnvironment(在登录的时候改变网络环境)";
            xibModule.classEntry = [LoginChangeEnvironmentViewController class];
            xibModule.isCreateByXib = NO;
            [sectionDataModel.values addObject:xibModule];
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
