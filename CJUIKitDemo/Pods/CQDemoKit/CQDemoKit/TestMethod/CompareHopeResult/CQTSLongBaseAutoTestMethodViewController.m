//
//  CQTSLongBaseAutoTestMethodViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CQTSLongBaseAutoTestMethodViewController.h"
#import "CQTSTestMethodLongTableViewCell.h"
#import "CQTSTestMethodTableHeaderView.h"
#import "CJUIKitToastUtil.h"

@interface CQTSLongBaseAutoTestMethodViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation CQTSLongBaseAutoTestMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"XXX首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerClass:[CQTSTestMethodLongTableViewCell class] forCellReuseIdentifier:@"CQTSTestMethodLongTableViewCell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    tableView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;

    // --- 结果区颜色图例 ---
    CGFloat headerWidth = tableView.bounds.size.width;
    CGFloat headerHeight = [CQTSTestMethodTableHeaderView headerHeightForWidth:headerWidth];
    CQTSTestMethodTableHeaderView *legendView = [[CQTSTestMethodTableHeaderView alloc] initWithFrame:CGRectMake(0, 0, headerWidth, headerHeight)];
    tableView.tableHeaderView = legendView;
    
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

#pragma mark - Lazy
- (NSMutableArray<CQDMSectionDataModel *> *)sectionDataModels {
    if (_sectionDataModels == nil) {
        _sectionDataModels = [[NSMutableArray alloc] init];
    }
    return _sectionDataModels;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    NSArray *dataModels = sectionDataModel.values;
    
    return dataModels.count;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    
    NSString *indexTitle = sectionDataModel.theme;
    return indexTitle;
}

/*
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
//    cell.contentView.bounds = CGRectInset(cell.bounds, -40, -10);
//    cell.contentView.backgroundColor = [UIColor redColor];
//
//    UIView *view = [UIView new];
//    view.backgroundColor = [UIColor lightGrayColor];
////    [cell.contentView insertSubview:view aboveSubview:cell.contentView];
//    [cell.contentView insertSubview:view belowSubview:cell.contentView];
    
    if ([cell respondsToSelector:@selector(tintColor)]) {
        
        cell.backgroundColor = CJColorFromHexString(@"#F5F5F5");
        
        CAShapeLayer *layer = [[CAShapeLayer alloc] init];
        CGMutablePathRef pathRef = CGPathCreateMutable();
        CGRect bounds = CGRectInset(cell.bounds, 0, 0);
        
        CGFloat cornerRadius = 6.f;
        
        if (indexPath.row == 0 && indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathAddRoundedRect(pathRef, nil, bounds, cornerRadius, cornerRadius);
            
        } else if (indexPath.row == 0) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds), CGRectGetMidX(bounds), CGRectGetMinY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds));
            
        } else if (indexPath.row == [tableView numberOfRowsInSection:indexPath.section]-1) {
            
            CGPathMoveToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMinY(bounds));
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMinX(bounds), CGRectGetMaxY(bounds), CGRectGetMidX(bounds), CGRectGetMaxY(bounds), cornerRadius);
            
            CGPathAddArcToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMaxY(bounds), CGRectGetMaxX(bounds), CGRectGetMidY(bounds), cornerRadius);
            
            CGPathAddLineToPoint(pathRef, nil, CGRectGetMaxX(bounds), CGRectGetMinY(bounds));
            
        } else {
            CGPathAddRect(pathRef, nil, bounds);
        }
        
        layer.path = pathRef;
        CFRelease(pathRef);
        
        //填充颜色和描边颜色修改
        layer.fillColor = CJColorFromHexString(@"#FFFFFF").CGColor;
        layer.strokeColor = CJColorFromHexString(@"#FFFFFF").CGColor;
        
        UIView *backView = [[UIView alloc] initWithFrame:bounds];
        [backView.layer insertSublayer:layer atIndex:0];
        backView.backgroundColor = CJColorFromHexString(@"#F5F5F5");
        cell.backgroundView = backView;
    }
}
*/

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    NSArray *dataModels = sectionDataModel.values;
    CQTSAutoTestMethodModel *dealTextModel = [dataModels objectAtIndex:indexPath.row];
    
    CQTSTestMethodLongTableViewCell *cell = (CQTSTestMethodLongTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CQTSTestMethodLongTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.fixTextViewHeight = self.fixTextViewHeight;
    cell.indexPath = indexPath;
    
    cell.textView.text = dealTextModel.text;
    [cell configButtonTitle:dealTextModel.actionTitle buttonPosition:CJValidateButtonPositionMiddle];
    __weak typeof(self) weakSelf = self;
    [cell setValidateHandle:^CQTSMethodValidateResult(CQTSTestMethodLongTableViewCell *mcell, CJValidateTriggerType triggerType) {
        return [weakSelf __dealTextModel:dealTextModel inCell:mcell triggerType:triggerType];
    }];
    // cell上的文本内容改变的时候，自动执行validateButton的点击事件
    __weak typeof(cell)weakCell = cell;
    [cell setTextDidChangeBlock:^(NSString *bText) {
        [weakCell validateWithTriggerType:CJValidateTriggerTypeTextChanged];
        // 强制刷新行高以适配 resultLabel 内容变化
        [weakSelf.tableView beginUpdates];
        [weakSelf.tableView endUpdates];
    }];
    
    if (dealTextModel.autoExec) {
        [cell validateWithTriggerType:CJValidateTriggerTypeCellInitial];
    }
    
        
    return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

#pragma mark - Private Method
/**
 *  将cell中的文本按照dealTextModel设置的方式进行处理后显示在cell上
 *
 *  @param dealTextModel    dealTextModel
 *  @param mcell            mcell
 *  @param triggerType      触发验证的来源
 *
 *  @return 验证结果枚举
 */
- (CQTSMethodValidateResult)__dealTextModel:(CQTSAutoTestMethodModel *)dealTextModel
                                     inCell:(CQTSTestMethodLongTableViewCell *)mcell
                                triggerType:(CJValidateTriggerType)triggerType
{
    NSString *currentText = mcell.textView.text;
    
    // 判断文本是否被修改
    BOOL textModified = ![currentText isEqualToString:dealTextModel.text];
    if (textModified) {
        // 文本已修改，执行方法并显示结果，但标记为需自行验证
        NSString *result = dealTextModel.actionBlock(currentText);
        mcell.resultLabel.text = [self __displayTextForResult:result];
        return CQTSMethodValidateResultModified;
    }
    
    // 文本未修改，执行方法并比较结果
    NSString *result = dealTextModel.actionBlock(currentText);
    mcell.resultLabel.text = [self __displayTextForResult:result];
    
    // 无希望处理后的text结果值，所以不比较
    if (dealTextModel.hopeResultText.length == 0) {
        if (triggerType != CJValidateTriggerTypeCellInitial) {
            if (result == nil || result.length == 0) {
                NSString *warningMessage = [NSString stringWithFormat:@"友情提示，您没有提供该方法的hopeResultText，且该方法返回值空了，请自行判断方法的结果[%@]是否正确", result];
                [CJUIKitToastUtil showMessage:warningMessage];
            } else {
                NSString *warningMessage = [NSString stringWithFormat:@"友情提示，您没有提供该方法的hopeResultText，无法进行比较，请自行判断方法的结果[%@]是否正确", result];
                [CJUIKitToastUtil showMessage:warningMessage];
            }
        }
        
        return CQTSMethodValidateResultNoHopeResultText;
    }
    
    // 有希望处理后的text结果值，所以进行比较
    BOOL validateSuccess = [result isEqualToString:dealTextModel.hopeResultText];
    if (triggerType != CJValidateTriggerTypeCellInitial) {
        if (validateSuccess == NO) {
            NSString *errorMessage = [NSString stringWithFormat:@"代码方法错误，执行结果应为:%@", dealTextModel.hopeResultText];
            [CJUIKitToastUtil showMessage:errorMessage];
        } else {
            NSString *successMessage = [NSString stringWithFormat:@"恭喜你，代码方法处理正确！"];
            [CJUIKitToastUtil showMessage:successMessage];
        }
    }
    return validateSuccess ? CQTSMethodValidateResultMatch : CQTSMethodValidateResultMismatch;
}

- (NSString *)__displayTextForResult:(NSString *)result {
    if (result == nil) {
        return @"（方法返回 nil）";
    }
    if (result.length == 0) {
        return @"（方法返回空字符串）";
    }
    return result;
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
