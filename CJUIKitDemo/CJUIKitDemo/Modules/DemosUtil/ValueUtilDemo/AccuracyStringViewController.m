//
//  AccuracyStringViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AccuracyStringViewController.h"

#import "ValidateStringTableViewCell.h"

#import "CJDecimalUtil.h"
#import "CJMoneyUtil.h"

#import "CJModuleModel.h"

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

@interface AccuracyStringViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation AccuracyStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"数值处理(取整、去尾0等)", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerClass:[ValidateStringTableViewCell class] forCellReuseIdentifier:@"ValidateStringTableViewCell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"去除尾部的0";
        sectionDataModel.values = @[@"0.090222120000",
                                    @"0.0900",
                                    @"10.00",
                                    ];
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"尾部归0";
        sectionDataModel.values = @[@"1121",
                                    @"1125",
                                    @"1126",
                                    ];
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"自定义的测试1";
        sectionDataModel.values = [NSMutableArray arrayWithArray:@[@"001", @"002", @"003"]];
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"自定义的测试2";
        sectionDataModel.values = [NSMutableArray arrayWithArray:@[@"001", @"002", @"003"]];
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
    
    
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    NSArray *dataModels = sectionDataModel.values;
    
    return dataModels.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    
    NSString *indexTitle = sectionDataModel.theme;
    return indexTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CJSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    NSString *dataModel = [dataModels objectAtIndex:indexPath.row];
    
    
    ValidateStringTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ValidateStringTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.textField.placeholder = @"请输入要验证的值";
    cell.textField.text = dataModel;
    
    if (indexPath.section == 0) {
        [cell.validateButton setTitle:@"去尾部0" forState:UIControlStateNormal];
        [cell setValidateHandle:^(ValidateStringTableViewCell *mcell) {
            NSString *originNumberString = mcell.textField.text;
            NSString *lastNumberString = [CJDecimalUtil removeEndZeroForNumberString:originNumberString];
            
            mcell.resultLabel.text = lastNumberString;
        }];
        
    } else if (indexPath.section == 1) {
        [cell.validateButton setTitle:@"尾部归0" forState:UIControlStateNormal];
        [cell setValidateHandle:^(ValidateStringTableViewCell *mcell) {
            NSString *originNumberString = mcell.textField.text;
            
            CGFloat originNumber = [originNumberString floatValue];
            CGFloat lastNumber = [CJDecimalUtil processingZeroWithIntValue:originNumber lastDigitCount:2 decimalDealType:CJDecimalDealTypeCeil];
            
            NSString *lastNumberString = [NSString stringWithFormat:@"%.2f", lastNumber];
            
            mcell.resultLabel.text = lastNumberString;
        }];
        
    } else if (indexPath.section == 2) {
        if (indexPath.row == 0) {
            cell.textField.text = @"1121";
            [cell.validateButton setTitle:@"尾部归0,向上取整" forState:UIControlStateNormal];
            [cell setValidateHandle:^(ValidateStringTableViewCell *mcell) {
                NSString *originNumberString = mcell.textField.text;
                
                CGFloat originNumber = [originNumberString floatValue];
                NSInteger lastNumber = [CJDecimalUtil processingZeroWithIntValue:originNumber lastDigitCount:2 decimalDealType:CJDecimalDealTypeCeil];
                
                NSString *lastNumberString = [NSString stringWithFormat:@"%ld", lastNumber];
                
                mcell.resultLabel.text = lastNumberString;
            }];
        } else if (indexPath.row == 1) {
            cell.textField.text = @"1121";
            [cell.validateButton setTitle:@"尾部归0,向下取整" forState:UIControlStateNormal];
            [cell setValidateHandle:^(ValidateStringTableViewCell *mcell) {
                NSString *originNumberString = mcell.textField.text;
                
                CGFloat originNumber = [originNumberString floatValue];
                NSInteger lastNumber = [CJDecimalUtil processingZeroWithIntValue:originNumber lastDigitCount:2 decimalDealType:CJDecimalDealTypeFloor];
                
                NSString *lastNumberString = [NSString stringWithFormat:@"%ld", lastNumber];
                
                mcell.resultLabel.text = lastNumberString;
            }];
        } else if (indexPath.row == 2) {
            cell.textField.text = @"1121";
            [cell.validateButton setTitle:@"尾部归0,四舍五入" forState:UIControlStateNormal];
            [cell setValidateHandle:^(ValidateStringTableViewCell *mcell) {
                NSString *originNumberString = mcell.textField.text;
                
                CGFloat originNumber = [originNumberString floatValue];
                NSInteger lastNumber = [CJDecimalUtil processingZeroWithIntValue:originNumber lastDigitCount:2 decimalDealType:CJDecimalDealTypeRound];
                
                NSString *lastNumberString = [NSString stringWithFormat:@"%ld", lastNumber];
                
                mcell.resultLabel.text = lastNumberString;
            }];
        }
        
    } else if (indexPath.section == 3) {
        if (indexPath.row == 0) {
            cell.textField.text = @"1024";
            [cell.validateButton setTitle:@"分转元,向上取整" forState:UIControlStateNormal];
            [cell setValidateHandle:^(ValidateStringTableViewCell *mcell) {
                NSString *originNumberString = mcell.textField.text;
                
                CGFloat originNumber = [originNumberString floatValue];
                NSString *lastNumberString = [CJMoneyUtil getPriceYuanStringFromPriceFen:originNumber withDecimalCount:2 decimalDealType:CJDecimalDealTypeCeil];
                mcell.resultLabel.text = lastNumberString;
            }];
        } else if (indexPath.row == 1) {
            cell.textField.text = @"1024";
            [cell.validateButton setTitle:@"分转元,向下取整" forState:UIControlStateNormal];
            [cell setValidateHandle:^(ValidateStringTableViewCell *mcell) {
                NSString *originNumberString = mcell.textField.text;
                
                CGFloat originNumber = [originNumberString floatValue];
                NSString *lastNumberString = [CJMoneyUtil getPriceYuanStringFromPriceFen:originNumber withDecimalCount:2 decimalDealType:CJDecimalDealTypeFloor];
                mcell.resultLabel.text = lastNumberString;
            }];
        } else if (indexPath.row == 2) {
            cell.textField.text = @"1024";
            [cell.validateButton setTitle:@"分转元,四舍五入" forState:UIControlStateNormal];
            [cell setValidateHandle:^(ValidateStringTableViewCell *mcell) {
                NSString *originNumberString = mcell.textField.text;
                
                CGFloat originNumber = [originNumberString floatValue];
                NSString *lastNumberString = [CJMoneyUtil getPriceYuanStringFromPriceFen:originNumber withDecimalCount:2 decimalDealType:CJDecimalDealTypeRound];
                mcell.resultLabel.text = lastNumberString;
            }];
        }
    }
    
    
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
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
