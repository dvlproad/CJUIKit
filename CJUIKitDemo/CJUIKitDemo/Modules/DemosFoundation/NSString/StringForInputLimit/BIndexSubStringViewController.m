//
//  BIndexSubStringViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "BIndexSubStringViewController.h"
#import "CQSubStringUtil.h"

@interface BIndexSubStringViewController ()

@end

@implementation BIndexSubStringViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"位置子字符串IndexSubString（含表情，不含表情等各种情况）", nil);
    self.fixTextViewHeight = 60;  // 固定textView的视图高度（该值大于44才生效），默认固定为44
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    // 字符串截取
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"截取字符串";
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"好好👌学习";
            dealTextModel.hopeResultText = @"";
            dealTextModel.actionTitle = @"【系统方式截取含表情的】字符串index=0";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *indexSubstring = [CQSubStringUtil sys_substringToIndex:0 forEmojiString:oldString];
                return indexSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"好好👌学习";
            dealTextModel.hopeResultText = @"";
            dealTextModel.actionTitle = @"【自定义方式截取含表情的】字符串index=0";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *indexSubstring = [CQSubStringUtil substringToIndex:0 forEmojiString:oldString];
                return indexSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 字符串截取
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"截取字符串";
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"好好👌学习";
            dealTextModel.hopeResultText = @"好好👌";
            dealTextModel.actionTitle = @"【系统方式截取含表情的】字符串index=3";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *indexSubstring = [CQSubStringUtil sys_substringToIndex:3 forEmojiString:oldString];
                return indexSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"好好👌学习";
            dealTextModel.hopeResultText = @"好好👌";
            dealTextModel.actionTitle = @"【自定义方式截取含表情的】字符串index=3";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *indexSubstring = [CQSubStringUtil substringToIndex:3 forEmojiString:oldString];
                return indexSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }

        [sectionDataModels addObject:sectionDataModel];
    }

    // 字符串截取
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"截取字符串";
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"好👌👌学习";
            dealTextModel.hopeResultText = @"好👌👌";
            dealTextModel.actionTitle = @"【系统方式截取含表情的】字符串index=3";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *indexSubstring = [CQSubStringUtil sys_substringToIndex:3 forEmojiString:oldString];
                return indexSubstring;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        {
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入截取的操作对象";
            dealTextModel.text = @"好👌👌学习";
            dealTextModel.hopeResultText = @"好👌👌";
            dealTextModel.actionTitle = @"【自定义方式截取含表情的】字符串index=3";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                NSString *indexSubstring = [CQSubStringUtil substringToIndex:3 forEmojiString:oldString];
                return indexSubstring;
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
