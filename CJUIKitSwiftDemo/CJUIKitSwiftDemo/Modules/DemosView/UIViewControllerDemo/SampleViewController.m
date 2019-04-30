//
//  SampleViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "SampleViewController.h"

#import "UIViewController+CJCustomBackBarButtonItem.h"
#import "UIViewController+CJSystemBackButtonHandler.h"

@interface SampleViewController ()

@end

@implementation SampleViewController

- (IBAction)goBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //方法②：测试自定义的返回按钮
//    [self cj_setCustomBackBarButtonItemWithTarget:self action:@selector(testCustomBackBarButtonItemAction)];
}

//方法①
- (BOOL)cj_navigationShouldPopOnBackButton {
    [self testCustomBackBarButtonItemAction];
    
    return NO;
}

- (void)testCustomBackBarButtonItemAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"信息已更改，是否保存" preferredStyle:UIAlertControllerStyleAlert];
    //添加alertAction
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"直接返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //TODO:为什么跟不是同alert返回的样子有点卡
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        [CJToast shortShowWhiteMessage:@"保存成功"];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [alertController addAction:action1];
    [alertController addAction:action2];
    //显示
    [self presentViewController:alertController animated:YES completion:nil];
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
