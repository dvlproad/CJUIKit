//
//  DateViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DateViewController.h"

#import "NSDateFormatterCJHelper.h"
#import "NSCalendarCJHelper.h"



@interface DateViewController ()

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = NSLocalizedString(@"日期字符串", nil);
    self.fixTextViewHeight = 44;

    [self setupTestCases];

    NSDate *birthdayDate = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_dateFromString:@"1989-12-27 01:10:22"];
    NSInteger yearInterval = NSCalendarCJHelper_yearInterval(birthdayDate, [NSDate date]);
    NSInteger age = NSCalendarCJHelper_age(birthdayDate, NO);
    NSLog(@"今年周岁为：%zd, %zd", yearInterval, age);
}

- (void)setupTestCases {
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];

    // NSString→NSDate 转换（不加 UTC，本地时区）
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"NSString→NSDate 转换（不加 UTC）";

        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入日期字符串";
            dealTextModel.text = @"2017-04-17 20:20:08";
            dealTextModel.hopeResultText = @"2017-04-17 20:20:08";
            dealTextModel.actionTitle = @"string→date→string（不加UTC）";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSDateFormatter *parseFormatter = [[NSDateFormatter alloc] init];
                [parseFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *date = [parseFormatter dateFromString:oldString];

                NSDateFormatter *resultFormatter = [[NSDateFormatter alloc] init];
                [resultFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                return [resultFormatter stringFromDate:date];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }

        [sectionDataModels addObject:sectionDataModel];
    }

    // NSString→NSDate 转换（加 UTC 校正，少8小时）
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"NSString→NSDate 转换（加 UTC 校正）";

        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入日期字符串";
            dealTextModel.text = @"2017-04-17 20:20:08";
            dealTextModel.hopeResultText = @"2017-04-17 20:20:08";
            dealTextModel.actionTitle = @"string→date→string（加UTC，少8小时）";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSDateFormatter *parseFormatter = [[NSDateFormatter alloc] init];
                [parseFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *date = [parseFormatter dateFromString:oldString];

                NSDateFormatter *resultFormatter = [[NSDateFormatter alloc] init];
                [resultFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                [resultFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
                return [resultFormatter stringFromDate:date];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }

        [sectionDataModels addObject:sectionDataModel];
    }

    // NSDate→NSString 转换（NSDate 转 string）
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"NSDate→NSString 转换";

        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"当前日期";
            dealTextModel.text = @"2018-09-27";
            dealTextModel.hopeResultText = @"2018-09-27";
            dealTextModel.actionTitle = @"date→string（yyyyMMdd）";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd"];
                NSDate *date = [formatter dateFromString:oldString];
                return [[NSDateFormatterCJHelper sharedInstance] yyyyMMdd_stringFromDate:date];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }

        [sectionDataModels addObject:sectionDataModel];
    }

    // 年龄计算
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"NSDateComponents 年龄计算";

        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"生日日期";
            dealTextModel.text = @"1989-12-27 01:10:22";
            dealTextModel.hopeResultText = @"36";
            dealTextModel.actionTitle = @"birthday→age（周岁）";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *birthdayDate = [formatter dateFromString:oldString];
                NSInteger age = NSCalendarCJHelper_age(birthdayDate, NO);
                return [NSString stringWithFormat:@"%zd", age];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }

        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"生日日期";
            dealTextModel.text = @"1989-12-27 01:10:22";
            dealTextModel.actionTitle = @"birthday→yearInterval（年份差）";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
                [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
                NSDate *birthdayDate = [formatter dateFromString:oldString];
                NSInteger yearInterval = NSCalendarCJHelper_yearInterval(birthdayDate, [NSDate date]);
                return [NSString stringWithFormat:@"%zd", yearInterval];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }

        [sectionDataModels addObject:sectionDataModel];
    }

    self.sectionDataModels = sectionDataModels;
}

@end
