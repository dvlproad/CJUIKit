//
//  NSCalendarCJHelperViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "NSCalendarCJHelperViewController.h"
#import "TestValueChangeTableViewCell.h"

#ifdef TEST_CJBASEHELPER_POD
#import "NSDateFormatterCJHelper.h"
#else
#import <CJBaseHelper/NSDateFormatterCJHelper.h>
#endif


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
            TestValueChangeModel *valueChangeModel = [[TestValueChangeModel alloc] initWithValue:@"20" textFromValueBlock:^NSString *(id value) {
                NSString *text = (NSString *)value;
                return text;
            } valueFromTextBlock:^id(NSString *string) {
                return string;
            } ];
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
                NSDate *newDate = NSCalendarCJHelper_addYears(-1, oldDate);
                return newDate;
            } addHandle:^id(id oldValue) {
                NSDate *oldDate = (NSDate *)oldValue;
                NSDate *newDate = NSCalendarCJHelper_addYears(1, oldDate);
                return newDate;
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试<日期Month>的加减" minusHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addMonths(-1, (NSDate *)oldValue);
            } addHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addMonths(1, (NSDate *)oldValue);
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试<日期Day>的加减" minusHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addDays(-1, (NSDate *)oldValue);
            } addHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addDays(1, (NSDate *)oldValue);
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试<日期Hour>的加减" minusHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addUnits((NSDate *)oldValue, -1, NSCalendarUnitHour);
            } addHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addUnits((NSDate *)oldValue, 1, NSCalendarUnitHour);
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试<日期Minute>的加减" minusHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addUnits((NSDate *)oldValue, -1, NSCalendarUnitMinute);
            } addHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addUnits((NSDate *)oldValue, 1, NSCalendarUnitMinute);
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试<日期Second>的加减" minusHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addUnits((NSDate *)oldValue, -1, NSCalendarUnitSecond);
            } addHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addUnits((NSDate *)oldValue, 1, NSCalendarUnitSecond);
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"测试获取第一天和最后一天";
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"获取第一天和最后一天" minusHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addDays(-1, (NSDate *)oldValue);
            } addHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addDays(1, (NSDate *)oldValue);
            }];
            [valueChangeModel setupResultFromValueBlock:^NSString *(id value) {
                // 获取指定日期所在周的第一天(周日为第一天)
                NSDate *weekBeginDate = NSCalendarCJHelper_weekBeginDate((NSDate *)value, NO);
                NSString *weekBeginDateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:weekBeginDate];
                
                // 获取指定日期所在周的最后一天(周六为最后一天)
                NSDate *weekLastDate = NSCalendarCJHelper_weekLastDate((NSDate *)value, NO);
                NSString *weekLastDateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:weekLastDate];
                
                // 打印值
                NSMutableString *string = [NSMutableString string];
                [string appendFormat:@"当前指定日期所在周的第一天(周日为第一天)为\n%@\n", weekBeginDateString];
                [string appendFormat:@"获取指定日期所在周的最后一天(周六为最后一天)为\n%@", weekLastDateString];
                
                return string;
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }

        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 测试获取<每周>第一天和最后一天之间的数组
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"测试获取<每周>第一天和最后一天之间的数组";
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试获取<每周>第一天和最后一天之间的数组" minusHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addDays(-1, (NSDate *)oldValue);
            } addHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addDays(1, (NSDate *)oldValue);
            }];
            [valueChangeModel setupResultFromValueBlock:^NSString *(id value) {
                // 获取指定日期所在周的第一天(星期一为第一天)
                NSDate *weekBeginDate = NSCalendarCJHelper_weekBeginDate((NSDate *)value, YES);
                NSString *weekBeginDateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:weekBeginDate];
                
                // 获取指定日期所在周的最后一天(星期天为最后一天)
                NSDate *weekLastDate = NSCalendarCJHelper_weekLastDate((NSDate *)value, YES);
                NSString *weekLastDateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:weekLastDate];
                
                // 打印值
                NSMutableString *string = [NSMutableString string];
                [string appendFormat:@"当前指定日期所在周的第一天(周日为第一天)为\n%@\n", weekBeginDateString];
                [string appendFormat:@"获取指定日期所在周的最后一天(周六为最后一天)为\n%@", weekLastDateString];
                
                [string appendFormat:@"\n\n这些日期之间的日期数组为>>>>\n"];
                NSArray<CJDateModel *> *dateModels = NSCalendarCJHelper_allCJDateModels(weekBeginDate, weekLastDate);
                for (CJDateModel *dateModel in dateModels) {
                    [string appendFormat:@"%@", dateModel.dateString];
                    [string appendFormat:@"...%ld", dateModel.weekday];
                    [string appendFormat:@"星期%@\n", dateModel.weekdayString];
                }
                [string appendFormat:@"<<<<日期数组打印结束"];
                
                return string;
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    

    // 测试获取<每月>第一天和最后一天之间的数组
    {
        CJSectionDataModel *sectionDataModel = [[CJSectionDataModel alloc] init];
        sectionDataModel.theme = @"测试获取<每月>第一天和最后一天之间的数组";
        {
            TestValueChangeModel *valueChangeModel = [self calendarValueChangeModel];
            [valueChangeModel setupChangeExplain:@"测试获取<每月>第一天和最后一天之间的数组" minusHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addMonths(-1, (NSDate *)oldValue);
            } addHandle:^id(id oldValue) {
                return NSCalendarCJHelper_addMonths(1, (NSDate *)oldValue);
            }];
            [valueChangeModel setupResultFromValueBlock:^NSString *(id value) {
                // 获取指定日期所在月的第一天
                NSDate *monthBeginDate = NSCalendarCJHelper_monthBeginDate((NSDate *)value);
                NSString *monthBeginDateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:monthBeginDate];
                
                // 获取指定日期所在月的最后一天
                NSDate *monthLastDate = NSCalendarCJHelper_monthLastDate((NSDate *)value);
                NSString *monthLastDateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:monthLastDate];
                
                // 打印值
                NSMutableString *string = [NSMutableString string];
                [string appendFormat:@"当前指定日期所在月的第一天为\n%@\n", monthBeginDateString];
                [string appendFormat:@"获取指定日期所在月的最后一天为\n%@", monthLastDateString];
                
                [string appendFormat:@"\n\n这些日期之间的日期数组为>>>>\n"];
                NSArray<CJDateModel *> *dateModels = NSCalendarCJHelper_allCJDateModels(monthBeginDate, monthLastDate);
                for (CJDateModel *dateModel in dateModels) {
                    [string appendFormat:@"%@", dateModel.dateString];
                    [string appendFormat:@"...%ld", dateModel.weekday];
                    [string appendFormat:@"星期%@\n", dateModel.weekdayString];
                }
                [string appendFormat:@"<<<<日期数组打印结束"];
                
                return string;
            }];
            [sectionDataModel.values addObject:valueChangeModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}

- (TestValueChangeModel *)calendarValueChangeModel {
    TestValueChangeModel *valueChangeModel = [[TestValueChangeModel alloc] initWithValue:[NSDate date] textFromValueBlock:^NSString *(id value) {
        NSString *string = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:value];
        return string;
    } valueFromTextBlock:^id(NSString *string) {
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
