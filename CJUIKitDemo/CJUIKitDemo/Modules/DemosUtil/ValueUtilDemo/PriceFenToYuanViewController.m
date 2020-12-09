//
//  PriceFenToYuanViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "PriceFenToYuanViewController.h"
#import "CJMoneyUtil.h"

@interface PriceFenToYuanViewController ()

@end

@implementation PriceFenToYuanViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"分转元(向上取整、向下取整、四舍五入)", nil);
    self.fixCellResultLableWidth = 80;  // 固定result的视图宽度（该值大于20才生效），默认为0<20，表示自适应宽度
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 将价钱'分'按指定精度处理到价钱'元'的该位(向上取整、向下取整、四舍五入)并始终显示2位小数
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"将价钱'分'按指定精度处理到价钱'元'的该位(向上取整、向下取整、四舍五入)并始终显示2位小数";
        sectionDataModel.values = [self dealTextModels_priceFenToYuan0_decimalCount2];
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 将价钱'分'按指定精度处理到价钱'元'的后一位(向上取整、向下取整、四舍五入)并始终显示2位小数
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"将价钱'分'按指定精度处理到价钱'元'的后一位(向上取整、向下取整、四舍五入)并始终显示2位小数";
        sectionDataModel.values = [self dealTextModels_priceFenToYuanD1_decimalCount2];
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

#pragma mark - 将价钱'分'按指定精度处理到价钱'元'的该位(向上取整、向下取整、四舍五入)并始终显示2位小数
/// 将价钱'分'按指定精度处理到价钱'元'的该位(向上取整、向下取整、四舍五入)并始终显示2位小数
- (NSMutableArray<CJDealTextModel *> *)dealTextModels_priceFenToYuan0_decimalCount2 {
    NSMutableArray<CJDealTextModel *> *dealTextModels = [[NSMutableArray alloc] init];
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"1024";
        dealTextModel.hopeResultText = @"11.00";
        dealTextModel.actionTitle = @"向上取整";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            return [self __priceFenSting:oldString toYuan0_decimalCount2:CJDecimalDealTypeCeil];
        };
        [dealTextModels addObject:dealTextModel];
    }
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"1024";
        dealTextModel.hopeResultText = @"10.00";
        dealTextModel.actionTitle = @"向下取整";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            return [self __priceFenSting:oldString toYuan0_decimalCount2:CJDecimalDealTypeFloor];
        };
        [dealTextModels addObject:dealTextModel];
    }
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"1024";
        dealTextModel.hopeResultText = @"10.00";
        dealTextModel.actionTitle = @"四舍五入";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            return [self __priceFenSting:oldString toYuan0_decimalCount2:CJDecimalDealTypeRound];
        };
        [dealTextModels addObject:dealTextModel];
    }
    
    return dealTextModels;
}


#pragma mark - 将价钱'分'按指定精度处理到价钱'元'的后一位(向上取整、向下取整、四舍五入)并始终显示2位小数
/// 将价钱'分'按指定精度处理到价钱'元'的后一位(向上取整、向下取整、四舍五入)并始终显示2位小数
- (NSMutableArray<CJDealTextModel *> *)dealTextModels_priceFenToYuanD1_decimalCount2 {
    NSMutableArray<CJDealTextModel *> *dealTextModels = [[NSMutableArray alloc] init];
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"1024";
        dealTextModel.hopeResultText = @"10.30";
        dealTextModel.actionTitle = @"向上取整";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            return [self __priceFenSting:oldString toYuanD1_decimalCount2:CJDecimalDealTypeCeil];
        };
        [dealTextModels addObject:dealTextModel];
    }
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"1024";
        dealTextModel.hopeResultText = @"10.20";
        dealTextModel.actionTitle = @"向下取整";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            return [self __priceFenSting:oldString toYuanD1_decimalCount2:CJDecimalDealTypeFloor];
        };
        [dealTextModels addObject:dealTextModel];
    }
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"1024";
        dealTextModel.hopeResultText = @"10.20";
        dealTextModel.actionTitle = @"四舍五入";
        dealTextModel.autoExec = YES;
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            return [self __priceFenSting:oldString toYuanD1_decimalCount2:CJDecimalDealTypeRound];
        };
        [dealTextModels addObject:dealTextModel];
    }
    
    return dealTextModels;
}


#pragma mark - Private Method
/**
 *  将价钱'分'按指定精度处理到价钱'元'的该位(向上取整、向下取整、四舍五入)并始终显示2位小数
 *
 *  @param decimalDealType  处理的方式(不处理、向上取整、向下取整、四舍五入)
 *
 *  @return 保留了2位小数的价钱整'元'字符串
 */
- (NSString *)__priceFenSting:(NSString *)priceFenString toYuan0_decimalCount2:(CJDecimalDealType)decimalDealType
{
    NSInteger fenPlaces = 3;
    NSInteger keepDecimalCount = 2;
    
    CGFloat originNumber = [priceFenString floatValue];
    NSString *lastNumberString = [CJMoneyUtil priceYuanStringFromPriceFen:originNumber
                                                      accurateToFenPlaces:fenPlaces
                                                          decimalDealType:decimalDealType
                                                         keepDecimalCount:keepDecimalCount];
    return lastNumberString;
}

/**
 *  将价钱'分'按指定精度处理到价钱'元'的后一位(向上取整、向下取整、四舍五入)并始终显示2位小数
 *
 *  @param decimalDealType  处理的方式(不处理、向上取整、向下取整、四舍五入)
 *
 *  @return 保留了2位小数的价钱整'元'字符串
 */
- (NSString *)__priceFenSting:(NSString *)priceFenString toYuanD1_decimalCount2:(CJDecimalDealType)decimalDealType
{
    NSInteger fenPlaces = 2;
    NSInteger keepDecimalCount = 2;
    
    CGFloat originNumber = [priceFenString floatValue];
    NSString *lastNumberString = [CJMoneyUtil priceYuanStringFromPriceFen:originNumber
                                                      accurateToFenPlaces:fenPlaces
                                                          decimalDealType:decimalDealType
                                                         keepDecimalCount:keepDecimalCount];
    return lastNumberString;
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
