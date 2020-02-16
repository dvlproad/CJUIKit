//
//  HUDHomeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "HUDHomeViewController.h"

//ProgressHUD
#import "CQHUDUtil.h"
#import "UIViewController+CQProgressHUD.h"
#import "TSShareHUDDissmissViewController.h"

@interface HUDHomeViewController () {
    
}

@end

@implementation HUDHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationItem.title = NSLocalizedString(@"测试HUD", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // ShareHUD
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"ShareHUD相关";
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"ShareHUD的显示(只有一个请求调用了HUD)";
            module.actionBlock = ^{
                [CQHUDUtil showProgressHUD];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(6.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [CQHUDUtil dismissProgressHUD];
                });
            };
            [sectionDataModel.values addObject:module];
        }
        {
            CJModuleModel *hudModule = [[CJModuleModel alloc] init];
            hudModule.title = @"ShareHUD的消失(进入测试在某页面请求到网络前离开，之前的HUD是否消失)";
            hudModule.classEntry = [TSShareHUDDissmissViewController class];
            [sectionDataModel.values addObject:hudModule];
        }
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"ShareHUD被多个请求调用";
            module.selector = @selector(testShareHUDForMoreRequest);
            [sectionDataModel.values addObject:module];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 菊花HUD
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"菊花HUD相关";
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"菊花HUD(0行1行文本)";
            module.actionBlock = ^{
                [self cjdemo_showStartProgressMessage:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self cjdemo_showProgressingMessage:@"上传第一张照片成功"];

                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self cjdemo_showEndProgressMessage:@"恭喜，上传完成！" isSuccess:YES];
                    });
                });
            };
            [sectionDataModel.values addObject:module];
        }
        {
            CJModuleModel *module = [[CJModuleModel alloc] init];
            module.title = @"菊花HUD(多行文本)";
            module.actionBlock = ^{
                [self cjdemo_showStartProgressMessage:nil];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self cjdemo_showProgressingMessage:@"加载数据正在进行非常复杂的处理，其过程可能需要比较久，请您耐心等候..."];
                    
                    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                        [self cjdemo_showEndProgressMessage:@"恭喜，上传完成！" isSuccess:YES];
                    });
                });
            };
            [sectionDataModel.values addObject:module];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}


- (void)testShareHUDForMoreRequest {
    NSLog(@"-----------------------");
    NSLog(@"测试多个请求调用了HUD--开始");
    //第一个请求HUD显示2秒
    [CQHUDUtil showProgressHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CQHUDUtil dismissProgressHUD];
        NSLog(@"测试多个请求调用了HUD--dismiss--1");
    });
    
    //第二个请求HUD显示5秒（加上第二个请求与第一个请求之间的时间差，则第一加第二请求至少要执行2+5-1=6秒）
    sleep(1);
    [CQHUDUtil showProgressHUD];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [CQHUDUtil dismissProgressHUD];
        NSLog(@"测试多个请求调用了HUD--dismiss--2");
    });
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
