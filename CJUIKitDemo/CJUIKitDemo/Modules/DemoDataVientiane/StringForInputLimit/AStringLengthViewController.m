//
//  AStringLengthViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AStringLengthViewController.h"
#import <CJDataVientianeSDK/NSString+CJTextLength.h>


@interface AStringLengthViewController ()

@end

@implementation AStringLengthViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"字符串长度验证", nil);
    self.fixCellResultLableWidth = 60;  // 固定result的视图宽度（该值大于20才生效），默认为0<20，表示自适应宽度
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 字符串长度验证--纯(空和nil)
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"字符串长度验证--空和nil";
        // 空字符串
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"我是【空字符串】";
            dealTextModel.hopeResultText = @"0";
            dealTextModel.actionTitle = @"【空字符串】(length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                oldString = @"";
                NSInteger length = [oldString length];
                return [NSString stringWithFormat:@"%zd", length];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"我是【空字符串】";
            dealTextModel.hopeResultText = @"0";
            dealTextModel.actionTitle = @"【空字符串】(cj_length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                oldString = @"";
                NSInteger length = [oldString cj_length];
                return [NSString stringWithFormat:@"%zd", length];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        
        // nil字符串
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"我是【nil字符串】";
            dealTextModel.hopeResultText = @"0";
            dealTextModel.actionTitle = @"【nil字符串】(length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                oldString = nil;
                NSInteger length = [oldString length];
                return [NSString stringWithFormat:@"%zd", length];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"我是【nil字符串】";
            dealTextModel.hopeResultText = @"0";
            dealTextModel.actionTitle = @"【nil字符串】(cj_length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                oldString = nil;
                NSInteger length = [oldString cj_length];
                return [NSString stringWithFormat:@"%zd", length];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    // 字符串长度验证--截取错误的字符串的计算
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"字符串长度验证--截取错误的字符串的计算";
        // 截取错误的字符串的计算
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"好好👌 使用系统方法截取前3位的时候的那个值的长度";
            dealTextModel.hopeResultText = @"3";
            dealTextModel.actionTitle = @"【空字符串】(length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                oldString = [@"好好👌" substringToIndex:3];
                NSInteger length = [oldString length];
                return [NSString stringWithFormat:@"%zd", length];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"好好👌 使用系统方法截取前3位的时候的那个值的长度（验证系统的length方法处理含表情字符串的时候有bug）";
            dealTextModel.hopeResultText = @"4";
            dealTextModel.actionTitle = @"【空字符串】(cj_length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                oldString = [@"好好👌" substringToIndex:3];
                NSInteger length = [oldString cj_length];
                return [NSString stringWithFormat:@"%zd", length];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    // 字符串长度验证--纯
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"字符串长度验证--纯";
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"18012345678";
            dealTextModel.hopeResultText = @"11";
            dealTextModel.actionTitle = @"纯数字(length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSInteger length = [oldString length];
                return [NSString stringWithFormat:@"%zd", length];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"18012345678";
            dealTextModel.hopeResultText = @"11";
            dealTextModel.actionTitle = @"纯数字(cj_length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSInteger length = [oldString cj_length];
                return [NSString stringWithFormat:@"%zd", length];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        
        
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"一二三四五六七八九十";
            dealTextModel.hopeResultText = @"10";
            dealTextModel.actionTitle = @"纯中文(length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSInteger length = [oldString length];
                return [NSString stringWithFormat:@"%zd", length];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"一二三四五六七八九十";
            dealTextModel.hopeResultText = @"20";
            dealTextModel.actionTitle = @"纯中文(cj_length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSInteger length = [oldString cj_length];
                return [NSString stringWithFormat:@"%zd", length];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"abcde12345abcde12345";
            dealTextModel.hopeResultText = @"20";
            dealTextModel.actionTitle = @"无中文(length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSInteger length = [oldString length];
                return [NSString stringWithFormat:@"%zd", length];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"abcde12345abcde12345";
            dealTextModel.hopeResultText = @"20";
            dealTextModel.actionTitle = @"无中文(cj_length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSInteger length = [oldString cj_length];
                return [NSString stringWithFormat:@"%zd", length];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 字符串长度验证--混合
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"字符串长度验证--混合";
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"一二三四五六七八九十1";
            dealTextModel.hopeResultText = @"11";
            dealTextModel.actionTitle = @"中文+非中文(length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSInteger length = [oldString length];
                return [NSString stringWithFormat:@"%zd", length];
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入要验证的值";
            dealTextModel.text = @"一二三四五六七八九十1";
            dealTextModel.hopeResultText = @"21";
            dealTextModel.actionTitle = @"中文+非中文(cj_length)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSInteger length = [oldString cj_length];
                return [NSString stringWithFormat:@"%zd", length];
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
