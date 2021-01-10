//
//  DChangeStringViewController1.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DChangeStringViewController1.h"
#import "CQSubStringUtil.h"
#import "UITextViewCQHelper.h"

@interface DChangeStringViewController1 ()

@end

@implementation DChangeStringViewController1


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"长度计算使用【系统length算法】的时候的最大字符串(以下每个都不能删，都得通过)", nil);
    self.fixTextViewHeight = 60;  // 固定textView的视图高度（该值大于44才生效），默认固定为44
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    
    // 情况1：能插全部
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"长度计算使用【系统length算法】的时候的最大字符串\n(注意：以下每个都不能删，都得通过\n以下每个都不能删，都得通过\n以下每个都不能删，都得通过\n)\n情况1：能插全部";
        {
            // 情况1：能插全部
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入变更前的完整字符串";
            dealTextModel.text = @"向上upup";
            dealTextModel.hopeResultText = @"一二三123向上upup";
            dealTextModel.actionTitle = @"限制20长度，在开头插入【一二三123】(能插全部)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                UITextInputChangeResultModel *resultModel = [UITextViewCQHelper shouldChange_newTextFromOldText:oldString shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"一二三123" maxTextLength:20];
                NSString *newText = resultModel.hopeNewText;
                return newText;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    // 情况2：能插部分
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"情况2：能插部分";
        
        {
            // 情况2：能插部分
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入变更前的完整字符串";
            dealTextModel.text = @"向上upup";
            dealTextModel.hopeResultText = @"一二三四五12向上upup";
            dealTextModel.actionTitle = @"限制20长度，在开头插入【一二三四五12345】(能插部分)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                UITextInputChangeResultModel *resultModel = [UITextViewCQHelper shouldChange_newTextFromOldText:oldString shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"一二三四五12345" maxTextLength:20];
                NSString *newText = resultModel.hopeNewText;
                return newText;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    // 情况3：都不能插
    {
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"情况3：都不能插";
        
        {
            // 情况3：都不能插的情况1
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入变更前的完整字符串";
            dealTextModel.text = @"好好学习天天向上向上";
            dealTextModel.hopeResultText = @"好好学习天天向上向上";
            dealTextModel.actionTitle = @"限制20长度，在开头插入【一二三四五12345】(都不能插的情况1)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                UITextInputChangeResultModel *resultModel = [UITextViewCQHelper shouldChange_newTextFromOldText:oldString shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"一二三四五12345" maxTextLength:20];
                NSString *newText = resultModel.hopeNewText;
                return newText;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        
        
        {
            // 情况3：都不能插的情况2
            CJDealTextModel *dealTextModel = [[CJDealTextModel alloc] init];
            dealTextModel.placeholder = @"请输入变更前的完整字符串";
            dealTextModel.text = @"好好学习天天向上好好学习天天向上";
            dealTextModel.hopeResultText = @"好好学习天天向上好好";
            dealTextModel.actionTitle = @"限制20长度，在开头插入【一二三四五12345】(都不能插的情况2)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                UITextInputChangeResultModel *resultModel = [UITextViewCQHelper shouldChange_newTextFromOldText:oldString shouldChangeCharactersInRange:NSMakeRange(0, 0) replacementString:@"一二三四五12345" maxTextLength:20]; // 未被替换的文本的所占的长度已经超过了最大限制长度（特殊情况：发生在使用setText设置错误数据到文本框）
                NSString *newText = resultModel.hopeNewText;
                return newText;
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
