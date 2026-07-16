//
//  CQTSShortBaseAutoTestMethodViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CQTSShortBaseAutoTestMethodViewController.h"
#import "CQTSTestMethodShortTableViewCell.h"
#import "CJUIKitToastUtil.h"

@interface CQTSShortBaseAutoTestMethodViewController () <UITableViewDataSource, UITableViewDelegate> {
    
}

@end

@implementation CQTSShortBaseAutoTestMethodViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = NSLocalizedString(@"XXX首页", nil); //知识点:使得tabBar中的title可以和显示在顶部的title保持各自
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    //[tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [tableView registerClass:[CQTSTestMethodShortTableViewCell class] forCellReuseIdentifier:@"CQTSTestMethodShortTableViewCell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    
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
    
    CQTSTestMethodShortTableViewCell *cell = (CQTSTestMethodShortTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CQTSTestMethodShortTableViewCell" forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.fixResultLableWidth = self.fixCellResultLableWidth;
    
    cell.textField.placeholder = dealTextModel.placeholder;
    cell.textField.text = dealTextModel.text;
    [cell.validateButton setTitle:dealTextModel.actionTitle forState:UIControlStateNormal];
    __weak typeof(self) weakSelf = self;
    [cell setValidateHandle:^BOOL(CQTSTestMethodShortTableViewCell *mcell, BOOL isAutoExec) {
        return [weakSelf __dealTextModel:dealTextModel inCell:mcell isAutoExec:isAutoExec];
    }];
    // cell上的文本内容改变的时候，自动执行validateButton的点击事件
    __weak typeof(cell)weakCell = cell;
    [cell setTextDidChangeBlock:^(NSString *bText) {
        return [weakCell validateEvent:NO];
    }];
    
    if (dealTextModel.autoExec) {
        [cell validateEvent:YES];
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
 *  @param isAutoExec       是否在cell显示出来的时候自动执行
 *
 *  @return 处理结果是否正确
 */
- (BOOL)__dealTextModel:(CQTSAutoTestMethodModel *)dealTextModel
                 inCell:(CQTSTestMethodShortTableViewCell *)mcell
             isAutoExec:(BOOL)isAutoExec
{
    NSString *originNumberString = mcell.textField.text;
    NSString *lastNumberString = dealTextModel.actionBlock(originNumberString);
    mcell.resultLabel.text = lastNumberString;
    
    BOOL validateSuccess = NO;
    if (dealTextModel.hopeResultText.length > 0) {
        validateSuccess = [lastNumberString isEqualToString:dealTextModel.hopeResultText];
        
        if (isAutoExec == NO) {
            if (validateSuccess == NO) {
                NSString *errorMessage = [NSString stringWithFormat:@"代码方法错误，执行结果应为:%@", dealTextModel.hopeResultText];
                [CJUIKitToastUtil showMessage:errorMessage];
            } else {
                NSString *successMessage = [NSString stringWithFormat:@"恭喜你，代码方法处理正确！"];
                [CJUIKitToastUtil showMessage:successMessage];
            }
        }
    } else {
        if (lastNumberString == nil || lastNumberString.length == 0) {
            validateSuccess = YES;
        } else {
            validateSuccess = NO;
        }
    }
    
    return validateSuccess;
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
