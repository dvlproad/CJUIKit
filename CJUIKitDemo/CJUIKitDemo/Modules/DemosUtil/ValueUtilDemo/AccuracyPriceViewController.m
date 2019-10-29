//
//  AccuracyPriceViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AccuracyPriceViewController.h"
#import "CJMoneyUtil.h"

@interface AccuracyPriceViewController ()

@end

@implementation AccuracyPriceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"分转元(向上取整、向下取整、四舍五入)", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 分转元(向上取整、向下取整、四舍五入)
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"分转元(向上取整、向下取整、四舍五入)";
        sectionDataModel.values = [self dealTextModels_priceFenToYuan];
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

#pragma mark - 分转元(向上取整、向下取整、四舍五入)
/// 分转元(向上取整、向下取整、四舍五入)
- (NSMutableArray<CJDealTextModel *> *)dealTextModels_priceFenToYuan {
    NSMutableArray<CJDealTextModel *> *dealTextModels = [[NSMutableArray alloc] init];
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"1024";
        dealTextModel.hopeResultText = @"11.00";
        dealTextModel.actionTitle = @"分转元,向上取整";
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            CGFloat originNumber = [oldString floatValue];
            NSString *lastNumberString = [CJMoneyUtil getPriceYuanStringFromPriceFen:originNumber withDecimalCount:2 decimalDealType:CJDecimalDealTypeCeil];
            return lastNumberString;
        };
        [dealTextModels addObject:dealTextModel];
    }
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"1024";
        dealTextModel.hopeResultText = @"10.00";
        dealTextModel.actionTitle = @"分转元,向下取整";
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            CGFloat originNumber = [oldString floatValue];
            NSString *lastNumberString = [CJMoneyUtil getPriceYuanStringFromPriceFen:originNumber withDecimalCount:2 decimalDealType:CJDecimalDealTypeFloor];
            return lastNumberString;
        };
        [dealTextModels addObject:dealTextModel];
    }
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"1024";
        dealTextModel.hopeResultText = @"10.00";
        dealTextModel.actionTitle = @"分转元,四舍五入";
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            CGFloat originNumber = [oldString floatValue];
            NSString *lastNumberString = [CJMoneyUtil getPriceYuanStringFromPriceFen:originNumber withDecimalCount:2 decimalDealType:CJDecimalDealTypeRound];
            return lastNumberString;
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
