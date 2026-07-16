//
//  TSNumberHomeViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "TSNumberHomeViewController.h"
#import <CQDemoKit/CJUIKitToastUtil.h>

#import "AccuracyStringViewController.h"
#import "PriceFenToYuanViewController.h"
#import "PriceYuanToYuanViewController.h"

@interface TSNumberHomeViewController ()

@end

@implementation TSNumberHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"Number首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 数值 & 价钱 处理
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"数值 & 价钱 相关";
        {
            CQDMModuleModel *NSAttributedStringModule = [[CQDMModuleModel alloc] init];
            NSAttributedStringModule.title = @"数值number(取整、去尾0等)";
            NSAttributedStringModule.classEntry = [AccuracyStringViewController class];
            [sectionDataModel.values addObject:NSAttributedStringModule];
        }
        {
            CQDMModuleModel *NSAttributedStringModule = [[CQDMModuleModel alloc] init];
            NSAttributedStringModule.title = @"价钱price(分转元)";
            NSAttributedStringModule.classEntry = [PriceFenToYuanViewController class];
            [sectionDataModel.values addObject:NSAttributedStringModule];
        }
        {
            CQDMModuleModel *NSAttributedStringModule = [[CQDMModuleModel alloc] init];
            NSAttributedStringModule.title = @"价钱price(元转元)";
            NSAttributedStringModule.classEntry = [PriceYuanToYuanViewController class];
            [sectionDataModel.values addObject:NSAttributedStringModule];
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
