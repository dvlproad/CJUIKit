//
//  PriceYuanToYuanViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "PriceYuanToYuanViewController.h"
#import "CJMoneyUtil.h"

@interface PriceYuanToYuanViewController ()

@end

@implementation PriceYuanToYuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"元转元(向上取整、向下取整、四舍五入)", nil);
    self.fixCellResultLableWidth = 80;  // 固定result的视图宽度（该值大于20才生效），默认为0<20，表示自适应宽度
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 将价钱'分'按(四舍五入)处理到价钱'元'的后两位，并最终以(最多)保留2位小数的方式输出价钱'元'(即会对小数部分的结尾是0的小数数字不显示)
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"将价钱'分'按(四舍五入)处理到价钱'元'的后两位，并最终以(最多)保留2位小数的方式输出价钱'元'(即会对小数部分的结尾是0的小数数字不显示)";
        sectionDataModel.values = [self dealTextModels_priceYuanToYuanD2_decimalCountMax2_Round];
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

#pragma mark - 将价钱'分'按(四舍五入)处理到价钱'元'的后两位，并最终以(最多)保留2位小数的方式输出价钱'元'(即会对小数部分的结尾是0的小数数字不显示)
/// 将价钱'分'按(四舍五入)处理到价钱'元'的后两位，并最终以(最多)保留2位小数的方式输出价钱'元'(即会对小数部分的结尾是0的小数数字不显示)
- (NSMutableArray<CJDealTextModel *> *)dealTextModels_priceYuanToYuanD2_decimalCountMax2_Round {
    NSMutableArray<CJDealTextModel *> *dealTextModels = [[NSMutableArray alloc] init];
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"9.555";
        dealTextModel.hopeResultText = @"9.56";
        dealTextModel.actionTitle = @"四舍五入";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            return [CJMoneyUtil yuanD2_decimalCountMax2_Round_fromPriceYuanString:oldString];
        };
        [dealTextModels addObject:dealTextModel];
    }
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"9.544";
        dealTextModel.hopeResultText = @"9.54";
        dealTextModel.actionTitle = @"四舍五入";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            return [CJMoneyUtil yuanD2_decimalCountMax2_Round_fromPriceYuanString:oldString];
        };
        [dealTextModels addObject:dealTextModel];
    }
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"9.50";
        dealTextModel.hopeResultText = @"9.5";
        dealTextModel.actionTitle = @"四舍五入";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            return [CJMoneyUtil yuanD2_decimalCountMax2_Round_fromPriceYuanString:oldString];
        };
        [dealTextModels addObject:dealTextModel];
    }
    
    return dealTextModels;
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
