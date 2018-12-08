//
//  NSCalendarCJHelperViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "NSCalendarCJHelperViewController.h"
#import "TestValueChangeTableViewCell.h"
#import <CJBaseHelper/NSDateFormatterCJHelper.h>

@interface NSCalendarCJHelperViewController () 

@end

@implementation NSCalendarCJHelperViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    [tableView registerClass:[TestValueChangeTableViewCell class] forCellReuseIdentifier:@"TestValueChangeTableViewCell"];
    tableView.dataSource = self;
    tableView.delegate = self;
    [self.view addSubview:tableView];
    [tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    self.tableView = tableView;
    
    
//    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
//    self.sectionDataModels = sectionDataModels;
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    //Helper
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"测试字符串";
        {
            TestValueChangeModel *valueChangeModel = [[TestValueChangeModel alloc] initWithValue:@"20" stringFromValueBlock:^NSString *(id value) {
                NSString *text = (NSString *)value;
                return text;
            } valueFromStringBlock:^id(NSString *string) {
                return string;
            }];
            [valueChangeModel setupChangeExplain:@"测试<字符串>的加减" minusHandle:^id(id oldValue) {
                NSString *oldText = (NSString *)oldValue;
                NSInteger iValue = [oldText integerValue] - 1;
                NSString *newText = [@(iValue) stringValue];
                return newText;
            } addHandle:^id(id oldValue) {
                NSString *oldText = (NSString *)oldValue;
                NSInteger iValue = [oldText integerValue] + 1;
                NSString *newText = [@(iValue) stringValue];
                return newText;
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        [sectionDataModels addObject:sectionDataModel];
    }
    
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"测试年月日时分秒";
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试<日期Year>的加减" minusHandle:^id(id oldValue) {
                NSDate *oldDate = (NSDate *)oldValue;
                NSDate *newDate = [NSCalendarCJHelper dateFromUnitInterval:-1 calculateUnit:NSCalendarUnitYear sinceDate:oldDate];
                return newDate;
            } addHandle:^id(id oldValue) {
                NSDate *oldDate = (NSDate *)oldValue;
                NSDate *newDate = [NSCalendarCJHelper dateFromUnitInterval:1 calculateUnit:NSCalendarUnitYear sinceDate:oldDate];
                return newDate;
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试<日期Month>的加减" minusHandle:^id(id oldValue) {
                return [NSCalendarCJHelper dateFromUnitInterval:-1 calculateUnit:NSCalendarUnitMonth sinceDate:(NSDate *)oldValue];
            } addHandle:^id(id oldValue) {
                return [NSCalendarCJHelper dateFromUnitInterval:1 calculateUnit:NSCalendarUnitMonth sinceDate:(NSDate *)oldValue];
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试<日期Day>的加减" minusHandle:^id(id oldValue) {
                return [NSCalendarCJHelper dateFromUnitInterval:-1 calculateUnit:NSCalendarUnitDay sinceDate:(NSDate *)oldValue];
            } addHandle:^id(id oldValue) {
                return [NSCalendarCJHelper dateFromUnitInterval:1 calculateUnit:NSCalendarUnitDay sinceDate:(NSDate *)oldValue];
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试<日期Hour>的加减" minusHandle:^id(id oldValue) {
                return [NSCalendarCJHelper dateFromUnitInterval:-1 calculateUnit:NSCalendarUnitHour sinceDate:(NSDate *)oldValue];
            } addHandle:^id(id oldValue) {
                return [NSCalendarCJHelper dateFromUnitInterval:1 calculateUnit:NSCalendarUnitHour sinceDate:(NSDate *)oldValue];
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试<日期Minute>的加减" minusHandle:^id(id oldValue) {
                return [NSCalendarCJHelper dateFromUnitInterval:-1 calculateUnit:NSCalendarUnitMinute sinceDate:(NSDate *)oldValue];
            } addHandle:^id(id oldValue) {
                return [NSCalendarCJHelper dateFromUnitInterval:1 calculateUnit:NSCalendarUnitMinute sinceDate:(NSDate *)oldValue];
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试<日期Second>的加减" minusHandle:^id(id oldValue) {
                return [NSCalendarCJHelper dateFromUnitInterval:-1 calculateUnit:NSCalendarUnitSecond sinceDate:(NSDate *)oldValue];
            } addHandle:^id(id oldValue) {
                return [NSCalendarCJHelper dateFromUnitInterval:1 calculateUnit:NSCalendarUnitSecond sinceDate:(NSDate *)oldValue];
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
//    {
//        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
//        sectionDataModel.theme = @"测试季度";
//        {
//            TestValueChangeModel *valueChangeModel = [[TestValueChangeModel alloc] initWithValue:[NSDate date] stringFromValueBlock:^NSString *(id value) {
//                NSString *string = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:value];
//                return string;
//            } valueFromStringBlock:^id(NSString *string) {
//                NSDate *date = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_dateFromString:string];
//                return date;
//            }];
//            [valueChangeModel setupChangeExplain:@"测试<日期Quarter>的加减" minusHandle:^id(id oldValue) {
//                return [NSCalendarCJHelper dateFromUnitInterval:-1 calculateUnit:NSCalendarUnitQuarter sinceDate:(NSDate *)oldValue];
//            } addHandle:^id(id oldValue) {
//                return [NSCalendarCJHelper dateFromUnitInterval:1 calculateUnit:NSCalendarUnitQuarter sinceDate:(NSDate *)oldValue];
//            }];
//            [sectionDataModel.values addObject:valueChangeModel];
//        }
//
//        [sectionDataModels addObject:sectionDataModel];
//    }
    
    self.sectionDataModels = sectionDataModels;
}

- (TestValueChangeModel *)calendarValueChangeModel {
    TestValueChangeModel *valueChangeModel = [[TestValueChangeModel alloc] initWithValue:[NSDate date] stringFromValueBlock:^NSString *(id value) {
        NSString *string = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:value];
        return string;
    } valueFromStringBlock:^id(NSString *string) {
        NSDate *date = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_dateFromString:string];
        return date;
    }];
    return valueChangeModel;
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
    TestValueChangeModel *valueChangeModel = [dataModels objectAtIndex:indexPath.row];
    
    TestValueChangeTableViewCell *cell = (TestValueChangeTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"TestValueChangeTableViewCell" forIndexPath:indexPath];
    cell.valueChangeModel = valueChangeModel;
    
    return cell;
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
