//
//  BackItemBaseViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "BackItemBaseViewController.h"

@interface BackItemBaseViewController ()

@end

@implementation BackItemBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *redButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [redButton setBackgroundColor:[UIColor redColor]];
    [redButton setTitle:@"返回到上一页(此按钮不会卡住返回)" forState:UIControlStateNormal];
    [redButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [redButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:redButton];
    [redButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(10);
        make.right.mas_equalTo(self.view).mas_offset(-10);
        make.top.mas_equalTo(self.view).mas_offset(110);
        make.height.mas_equalTo(44);
    }];
}

#pragma mark - Event
- (void)goBack {
    [self.navigationController popViewControllerAnimated:YES];
}

/**
 *  自定义返回按钮的返回操作
 */
- (void)customBackBarButtonItemAction {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"信息已更改，是否保存" preferredStyle:UIAlertControllerStyleAlert];
    //添加alertAction
    UIAlertAction *action1 = [UIAlertAction actionWithTitle:@"直接返回" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        //TODO:为什么跟不是同alert返回的样子有点卡
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *action2 = [UIAlertAction actionWithTitle:@"保存" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [CJToast shortShowWhiteMessage:@"保存成功"];
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
