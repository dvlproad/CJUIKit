//
//  AStringLengthViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AStringLengthViewController.h"
#import "NSString+CJTextLength.h"


@interface AStringLengthViewController ()

@end

@implementation AStringLengthViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"字符串长度验证", nil);
    self.fixCellResultLableWidth = 60;  // 固定result的视图宽度（该值大于20才生效），默认为0<20，表示自适应宽度
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
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
            dealTextModel.hopeResultText = @"20";
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
            dealTextModel.hopeResultText = @"21";
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
