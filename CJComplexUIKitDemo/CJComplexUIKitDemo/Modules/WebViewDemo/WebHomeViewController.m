//
//  WebHomeViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "WebHomeViewController.h"

#import "AboutViewController.h"
#import "LocalViewController.h"

#import "JSOCViewController.h"
#import "OCJSViewController.h"

#import "H5ImgSettingPathViewController.h"
#import "H5ImgSettingDataViewController.h"

@interface WebHomeViewController ()  {
    
}

@end

@implementation WebHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Web首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // WebView Empty
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"WebView Empty";
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"Web（Network & Empty）";
            webViewModule.classEntry = [AboutViewController class];
            [sectionDataModel.values addObject:webViewModule];
        }
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"Web（Local & No Need Empty）";
            webViewModule.classEntry = [LocalViewController class];
            [sectionDataModel.values addObject:webViewModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // WebView OC<->JS
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"WebView OC<->JS";
        
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"WebView OC->JS(有参数)";
            webViewModule.classEntry = [OCJSViewController class];
            [sectionDataModel.values addObject:webViewModule];
        }
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"WebView JS->OC";
            webViewModule.classEntry = [JSOCViewController class];
            [sectionDataModel.values addObject:webViewModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // WebView H5的img设置
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"WebView H5的img设置";
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"WebView H5的img设置(传路径给H5)";
            webViewModule.classEntry = [H5ImgSettingPathViewController class];
            [sectionDataModel.values addObject:webViewModule];
        }
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"WebView H5的img设置(传数据给H5)";
            webViewModule.classEntry = [H5ImgSettingDataViewController class];
            [sectionDataModel.values addObject:webViewModule];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // WebView H5的img拦截
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"WebView H5的img拦截";
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"WebView H5的img拦截(拦截了present)";
            webViewModule.actionBlock = ^{
                [self showIKnowAlertViewWithTitle:@"请查看CJHookDemo中的H5ImgInterceptChooseViewController"];
            };
            [sectionDataModel.values addObject:webViewModule];
        }
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"WebView H5的img拦截(拦截了didFinishPicking)";
            webViewModule.actionBlock = ^{
                [self showIKnowAlertViewWithTitle:@"请查看CJHookDemo中的H5ImgInterceptPickerViewController1"];
            };
            [sectionDataModel.values addObject:webViewModule];
        }
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"WebView H5的img拦截(拦截了image)";
            webViewModule.content = @"注意：记得进入后要退出来试下unhook成功没";
            webViewModule.actionBlock = ^{
                [self showIKnowAlertViewWithTitle:@"请查看CJHookDemo中的H5ImgInterceptPickerViewController"];
            };
            [sectionDataModel.values addObject:webViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

- (void)showIKnowAlertViewWithTitle:(NSString *)title {
    [TSAlertUtil showAlertViewWithFlagImage:nil title:title message:nil okButtonTitle:@"我知道了" okHandle:nil];
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
