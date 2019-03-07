//
//  HookVCHomeViewController.m
//  CJHookDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "HookVCHomeViewController.h"

#import "HookButtonViewController.h"

#import "H5ImgInterceptChooseViewController.h"

#import "H5ImgInterceptPickerViewController.h"
#import "H5ImgInterceptPickerViewController1.h"

@interface HookVCHomeViewController () <UINavigationControllerDelegate, UIImagePickerControllerDelegate>  {
    
}

@end

@implementation HookVCHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"Web拦截首页", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // UIButton的拦截
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"UIButton的拦截";
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"UIButton的重复点击拦截";
            webViewModule.classEntry = [HookButtonViewController class];
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
            webViewModule.classEntry = [H5ImgInterceptChooseViewController class];
            [sectionDataModel.values addObject:webViewModule];
        }
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"WebView H5的img拦截(拦截了didFinishPicking)";
            webViewModule.classEntry = [H5ImgInterceptPickerViewController1 class];
            [sectionDataModel.values addObject:webViewModule];
        }
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"WebView H5的img拦截(拦截了image)";
            webViewModule.content = @"注意：记得进入后要退出来试下unhook成功没";
            webViewModule.classEntry = [H5ImgInterceptPickerViewController class];
            [sectionDataModel.values addObject:webViewModule];
        }
        {
            CJModuleModel *webViewModule = [[CJModuleModel alloc] init];
            webViewModule.title = @"UIImagePickerController本身的照片选择";
            webViewModule.selector = @selector(testImagePicker);
            [sectionDataModel.values addObject:webViewModule];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

- (void)testImagePicker {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    [self presentViewController:picker animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    [CJToast shortShowMessage:@"这是UIImagePickerController本身的方法"];
    [self dismissViewControllerAnimated:YES completion:nil];
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
