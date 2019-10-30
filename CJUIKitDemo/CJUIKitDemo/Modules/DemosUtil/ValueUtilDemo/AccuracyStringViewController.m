//
//  AccuracyStringViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AccuracyStringViewController.h"
#import "CJDecimalUtil.h"

typedef NS_ENUM(NSUInteger, ValidateStringType) {
    ValidateStringTypeNone = 0,     /**< 不验证 */
    ValidateStringTypeEmail,        /**< 邮箱 */
    ValidateStringTypePhone,        /**< 手机号码 */
    ValidateStringTypeCarNo,        /**< 车牌号 */
    ValidateStringTypeCarType,      /**< 车型 */
    ValidateStringTypeUserName,     /**< 用户名 */
    ValidateStringTypePassword,     /**< 密码 */
    ValidateStringTypeNickname,     /**< 昵称 */
    ValidateStringTypeIdentityCard, /**< 身份证号 */
};

@interface AccuracyStringViewController ()

@end

@implementation AccuracyStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"数值处理(取整、去尾0等)", nil);
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    // 去尾部0
    {
        CJSectionDataModel *sectionDataModel =
        [CJSectionDataModel sectionDataModelWithTextArray:@[@"0.090222120000",
                                                            @"0.0900",
                                                            @"10.00",
                                                            ]
                                          samePlaceholder:@"请输入要验证的值"
                                          sameActionTitle:@"去尾部0"
                                          sameActionBlock:^NSString * _Nonnull(NSString * _Nonnull oldString) {
            NSString *lastNumberString = [CJDecimalUtil removeEndZeroForNumberString:oldString];
            return lastNumberString;
        }];
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 尾部归0
    {
        CJSectionDataModel *sectionDataModel =
        [CJSectionDataModel sectionDataModelWithTextArray:@[@"1121",
                                                            @"1125",
                                                            @"1126",
                                                            ]
                                          samePlaceholder:@"请输入要验证的值"
                                          sameActionTitle:@"尾部归0"
                                          sameActionBlock:^NSString * _Nonnull(NSString * _Nonnull oldString) {
            CGFloat originNumber = [oldString floatValue];
            CGFloat lastNumber = [CJDecimalUtil floatValueFromFValue:originNumber accurateToDecimalPlaces:2 decimalDealType:CJDecimalDealTypeCeil];
           
            NSString *lastNumberString = [NSString stringWithFormat:@"%.2f", lastNumber];
            return lastNumberString;
        }];
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 精确到个位(向上取整、向下取整、四舍五入)
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"精确到个位(向上取整、向下取整、四舍五入)";
        sectionDataModel.values = [self dealTextModels_accurateToUnit];
        
        [sectionDataModels addObject:sectionDataModel];
    }
    // 精确到百位(向上取整、向下取整、四舍五入)
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"精确到百位(向上取整、向下取整、四舍五入)";
        sectionDataModel.values = [self dealTextModels_accurateToHundred];
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}


#pragma mark - 精确到个位(向上取整、向下取整、四舍五入)
/// 精确到个位(向上取整、向下取整、四舍五入)
- (NSMutableArray<CJDealTextModel *> *)dealTextModels_accurateToUnit {
    NSInteger decimalPlaces = 1;
    NSMutableArray<CJDealTextModel *> *dealTextModels = [[NSMutableArray alloc] init];
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"99.45";
        dealTextModel.hopeResultText = @"100";
        dealTextModel.actionTitle = @"精确到个位,向上取整";
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            CGFloat originNumber = [oldString floatValue];
            NSInteger lastNumber = [CJDecimalUtil floatValueFromFValue:originNumber accurateToDecimalPlaces:decimalPlaces decimalDealType:CJDecimalDealTypeCeil];
            
            NSString *lastNumberString = [NSString stringWithFormat:@"%zd", lastNumber];
            return lastNumberString;
        };
        [dealTextModels addObject:dealTextModel];
    }
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"99.45";
        dealTextModel.hopeResultText = @"99";
        dealTextModel.actionTitle = @"精确到个位,向下取整";
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            CGFloat originNumber = [oldString floatValue];
            NSInteger lastNumber = [CJDecimalUtil floatValueFromFValue:originNumber accurateToDecimalPlaces:decimalPlaces decimalDealType:CJDecimalDealTypeFloor];
            
            NSString *lastNumberString = [NSString stringWithFormat:@"%zd", lastNumber];
            return lastNumberString;
        };
        [dealTextModels addObject:dealTextModel];
    }
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"99.45";
        dealTextModel.hopeResultText = @"99";
        dealTextModel.actionTitle = @"精确到个位,四舍五入";
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            CGFloat originNumber = [oldString floatValue];
            NSInteger lastNumber = [CJDecimalUtil floatValueFromFValue:originNumber accurateToDecimalPlaces:decimalPlaces decimalDealType:CJDecimalDealTypeRound];
            
            NSString *lastNumberString = [NSString stringWithFormat:@"%zd", lastNumber];
            return lastNumberString;
        };
        [dealTextModels addObject:dealTextModel];
    }
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"99.54";
        dealTextModel.hopeResultText = @"100";
        dealTextModel.actionTitle = @"精确到个位,四舍五入";
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            CGFloat originNumber = [oldString floatValue];
            NSInteger lastNumber = [CJDecimalUtil floatValueFromFValue:originNumber accurateToDecimalPlaces:decimalPlaces decimalDealType:CJDecimalDealTypeRound];
            
            NSString *lastNumberString = [NSString stringWithFormat:@"%zd", lastNumber];
            return lastNumberString;
        };
        [dealTextModels addObject:dealTextModel];
    }
    
    return dealTextModels;
}

#pragma mark - 精确到百位(向上取整、向下取整、四舍五入)
/// 精确到百位(向上取整、向下取整、四舍五入)
- (NSMutableArray<CJDealTextModel *> *)dealTextModels_accurateToHundred {
    NSInteger decimalPlaces = 3;
    NSMutableArray<CJDealTextModel *> *dealTextModels = [[NSMutableArray alloc] init];
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"1121";
        dealTextModel.hopeResultText = @"1200";
        dealTextModel.actionTitle = @"精确到百位,向上取整";
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            CGFloat originNumber = [oldString floatValue];
            NSInteger lastNumber = [CJDecimalUtil floatValueFromFValue:originNumber accurateToDecimalPlaces:decimalPlaces decimalDealType:CJDecimalDealTypeCeil];
            
            NSString *lastNumberString = [NSString stringWithFormat:@"%zd", lastNumber];
            return lastNumberString;
        };
        [dealTextModels addObject:dealTextModel];
    }
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"1121";
        dealTextModel.hopeResultText = @"1100";
        dealTextModel.actionTitle = @"精确到百位,向下取整";
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            CGFloat originNumber = [oldString floatValue];
            NSInteger lastNumber = [CJDecimalUtil floatValueFromFValue:originNumber accurateToDecimalPlaces:decimalPlaces decimalDealType:CJDecimalDealTypeFloor];
            
            NSString *lastNumberString = [NSString stringWithFormat:@"%zd", lastNumber];
            return lastNumberString;
        };
        [dealTextModels addObject:dealTextModel];
    }
    {
        CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
        dealTextModel.placeholder = @"请输入要验证的值";
        dealTextModel.text = @"1121";
        dealTextModel.hopeResultText = @"1100";
        dealTextModel.actionTitle = @"精确到百位,四舍五入";
        dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
            CGFloat originNumber = [oldString floatValue];
            NSInteger lastNumber = [CJDecimalUtil floatValueFromFValue:originNumber accurateToDecimalPlaces:decimalPlaces decimalDealType:CJDecimalDealTypeRound];
            
            NSString *lastNumberString = [NSString stringWithFormat:@"%zd", lastNumber];
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
