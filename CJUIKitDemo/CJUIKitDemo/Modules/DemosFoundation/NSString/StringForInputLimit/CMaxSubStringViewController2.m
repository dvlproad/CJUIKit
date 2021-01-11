//
//  CMaxSubStringViewController2.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CMaxSubStringViewController2.h"
#import "CQSubStringUtil.h"

@interface CMaxSubStringViewController2 ()

@end

@implementation CMaxSubStringViewController2


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"长度计算使用【自定义cj_length算法】的时候的最大字符串(以下每个都不能删，都得通过)", nil);
    self.fixTextViewHeight = 60;  // 固定textView的视图高度（该值大于44才生效），默认固定为44
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 字符串截取（不含表情时候）
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"长度计算使用【自定义cj_length算法】的时候的最大字符串\n(注意：以下每个都不能删，都得通过\n以下每个都不能删，都得通过\n以下每个都不能删，都得通过\n)";
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"一二三四五六七八九十01234567890壹贰叁肆伍陆柒捌玖拾";
            dealTextModel.hopeResultText = @"一二";
            dealTextModel.actionTitle = @"截取子字符串使其最多字符个数不超过5";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *maxSubstring = [CQSubStringUtil maxSubstringFromString:oldString maxLength:5];
                return maxSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"一二三四五六七八九十01234567890壹贰叁肆伍陆柒捌玖拾";
            dealTextModel.hopeResultText = @"一二三四五六七八九十01234";
            dealTextModel.actionTitle = @"截取子字符串使其最多字符个数不超过25";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *maxSubstring = [CQSubStringUtil maxSubstringFromString:oldString maxLength:25];
                return maxSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"一二三四五六七八九十01234567890壹贰叁肆伍陆柒捌玖拾";
            dealTextModel.hopeResultText = @"一二三四五六七八九十01234567890壹贰叁肆伍陆柒";
            dealTextModel.actionTitle = @"截取子字符串使其最多字符个数不超过45";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *maxSubstring = [CQSubStringUtil maxSubstringFromString:oldString maxLength:45];
                return maxSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"1234567890";
            dealTextModel.hopeResultText = @"1234567890";
            dealTextModel.actionTitle = @"截取子字符串使其最多字符个数不超过10";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *maxSubstring = [CQSubStringUtil maxSubstringFromString:oldString maxLength:10];
                return maxSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }

        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    
    // 字符串截取（不含表情时候）
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"长度计算使用【自定义cj_length算法】的时候的最大字符串\n(注意：以下每个都不能删，都得通过\n以下每个都不能删，都得通过\n以下每个都不能删，都得通过\n)";
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"一二三四五六七八九十壹贰叁肆伍陆柒捌";
            dealTextModel.hopeResultText = @"一二三四五六七八九十";
            dealTextModel.actionTitle = @"截取子字符串使其最多字符个数不超过20";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *maxSubstring = [CQSubStringUtil maxSubstringFromString:oldString maxLength:20];
                return maxSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"一二三四五六七八九十壹贰叁肆伍陆柒捌1234567890";
            dealTextModel.hopeResultText = @"一二三四五六七八九十";
            dealTextModel.actionTitle = @"截取子字符串使其最多字符个数不超过20";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *maxSubstring = [CQSubStringUtil maxSubstringFromString:oldString maxLength:20];
                return maxSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }

        [sectionDataModels addObject:sectionDataModel];
    }
    
    

    // 字符串截取（含表情时候）
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"长度计算使用【中文2，英文1，表情不定】的时候的最大字符串";
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"一二👌三四五";
            dealTextModel.hopeResultText = @"一二";
            dealTextModel.actionTitle = @"截取子字符串使其最多字符个数不超过5";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *maxSubstring = [CQSubStringUtil maxSubstringFromString:oldString maxLength:5];
                return maxSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"一👌👌三四五";
            dealTextModel.hopeResultText = @"一";
            dealTextModel.actionTitle = @"截取子字符串使其最多字符个数不超过5";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *maxSubstring = [CQSubStringUtil maxSubstringFromString:oldString maxLength:5];
                return maxSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"一👌👌三四五";
            dealTextModel.hopeResultText = @"一👌";
            dealTextModel.actionTitle = @"截取子字符串使其最多字符个数不超过6";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *maxSubstring = [CQSubStringUtil maxSubstringFromString:oldString maxLength:6];
                return maxSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"一1👌👌三四五";
            dealTextModel.hopeResultText = @"一1";
            dealTextModel.actionTitle = @"截取子字符串使其最多字符个数不超过5";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *maxSubstring = [CQSubStringUtil maxSubstringFromString:oldString maxLength:5];
                return maxSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
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
