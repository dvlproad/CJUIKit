//
//  DChangeStringViewController1.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DChangeStringViewController1.h"
#import <CJDataVientianeSDK/CJSubStringUtil.h>
#import <CJDataVientianeSDK/NSString+CJTextLength.h>
#import <CJDataVientianeSDK/UITextInputLimitCJHelper.h>

@interface DChangeStringViewController1 ()

@end

@implementation DChangeStringViewController1


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"长度计算使用【系统length算法】的时候的最大字符串(以下每个都不能删，都得通过)", nil);
    self.fixTextViewHeight = 60;  // 固定textView的视图高度（该值大于44才生效），默认固定为44
    
    NSMutableArray *sectionDataModels = [[NSMutableArray alloc] init];
    
    //NSString *placeholder = @"请输入变更前的完整字符串";
    // 情况1：能插全部
    {
        //@"限制20长度，在开头插入【一二三123】(能插全部)"
        //NSString *situationString = @"情况1：能插全部";    // 测试的情况
        NSInteger maxTextLength = 20;
        NSRange range = NSMakeRange(0, 0);
        NSString *replacementString = @"一二三123";
        //NSString *actionTitle = @"限制20长度，在开头插入【一二三123】(能插全部)";
        //NSString *actionTitle = [NSString stringWithFormat:@"限制%ld长度，在%@插入【%@】(附{0,0}指开头)", maxTextLength, NSStringFromRange(range), replacementString];
        
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"长度计算使用【系统length算法】的时候的最大字符串\n(注意：以下每个都不能删，都得通过\n以下每个都不能删，都得通过\n以下每个都不能删，都得通过\n)\n情况1：能插全部";
        {
            // 情况1：能插全部
            CQTSAutoTestMethodModel *dealTextModel = [[CQTSAutoTestMethodModel alloc] init];
            dealTextModel.placeholder = @"请输入变更前的完整字符串";
            dealTextModel.text = @"向上upup";
            dealTextModel.hopeResultText = @"一二三123向上upup";
            dealTextModel.actionTitle = @"限制20长度，在开头插入【一二三123】(能插全部)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                UITextInputChangeResultModel *resultModel = [[self class] shouldChange_newTextFromOldText:oldString shouldChangeCharactersInRange:range replacementString:replacementString maxTextLength:maxTextLength];
                NSString *newText = resultModel.hopeNewText;
                return newText;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }

        [sectionDataModels addObject:sectionDataModel];
    }

    // 情况2：能插部分
    {
        //NSString *situationString = @"情况2：能插部分";    // 测试的情况
        NSInteger maxTextLength = 20;
        NSRange range = NSMakeRange(0, 0);
        NSString *replacementString = @"一二三四五12345";
        
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"情况2：能插部分";

        {
            // 情况2：能插部分
            CQTSAutoTestMethodModel *dealTextModel = [[CQTSAutoTestMethodModel alloc] init];
            dealTextModel.placeholder = @"请输入变更前的完整字符串";
            dealTextModel.text = @"向上upup";
            dealTextModel.hopeResultText = @"一二三四五12向上upup";
            dealTextModel.actionTitle = @"限制20长度，在开头插入【一二三四五12345】(能插部分)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                UITextInputChangeResultModel *resultModel = [[self class] shouldChange_newTextFromOldText:oldString shouldChangeCharactersInRange:range replacementString:replacementString maxTextLength:maxTextLength];
                NSString *newText = resultModel.hopeNewText;
                return newText;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }

        [sectionDataModels addObject:sectionDataModel];
    }
    
    
    // 情况3：都不能插
    {
        //NSString *situationString = @"情况3：都不能插";    // 测试的情况
        NSInteger maxTextLength = 20;
        NSRange range = NSMakeRange(0, 0);
        NSString *replacementString = @"一二三四五12345";
        
        CQDMSectionDataModel *sectionDataModel = [[CQDMSectionDataModel alloc] init];
        sectionDataModel.theme = @"情况3：都不能插";
        
        {
            // 情况3：都不能插的情况1
            CQTSAutoTestMethodModel *dealTextModel = [[CQTSAutoTestMethodModel alloc] init];
            dealTextModel.placeholder = @"请输入变更前的完整字符串";
            dealTextModel.text = @"好好学习天天向上向上";
            dealTextModel.hopeResultText = @"好好学习天天向上向上";
            dealTextModel.actionTitle = @"限制20长度，在开头插入【一二三四五12345】(都不能插的情况1)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                UITextInputChangeResultModel *resultModel = [[self class] shouldChange_newTextFromOldText:oldString shouldChangeCharactersInRange:range replacementString:replacementString maxTextLength:maxTextLength];
                NSString *newText = resultModel.hopeNewText;
                return newText;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        
        
        {
            // 情况3：都不能插的情况2
            CQTSAutoTestMethodModel *dealTextModel = [[CQTSAutoTestMethodModel alloc] init];
            dealTextModel.placeholder = @"请输入变更前的完整字符串";
            dealTextModel.text = @"好好学习天天向上好好学习天天向上";
            dealTextModel.hopeResultText = @"好好学习天天向上好好";
            dealTextModel.actionTitle = @"限制20长度，在开头插入【一二三四五12345】(都不能插的情况2)";
            dealTextModel.autoExec = YES;
            dealTextModel.actionBlock = ^NSString * _Nonnull(NSString * _Nonnull oldString) {
                UITextInputChangeResultModel *resultModel = [[self class] shouldChange_newTextFromOldText:oldString shouldChangeCharactersInRange:range replacementString:replacementString maxTextLength:maxTextLength]; // 未被替换的文本的所占的长度已经超过了最大限制长度（特殊情况：发生在使用setText设置错误数据到文本框）
                NSString *newText = resultModel.hopeNewText;
                return newText;
            };
            [sectionDataModel.values addObject:dealTextModel];
        }
        
        [sectionDataModels addObject:sectionDataModel];
    }
    
    self.sectionDataModels = sectionDataModels;
}


/*
 *  根据最大长度获取shouldChange的时候返回的newText
 *  @brief 此方法适合封装为 UITextViewCQHelper 类里的一个方法
 *
 *  @param oldText              oldText
 *  @param range                range
 *  @param string               string
 *  @param maxTextLength        maxTextLength(为0的时候不做长度限制)
 *
 *  @return newText
 */
+ (UITextInputChangeResultModel *)shouldChange_newTextFromOldText:(nullable NSString *)oldText
                                    shouldChangeCharactersInRange:(NSRange)range
                                                replacementString:(NSString *)string
                                                    maxTextLength:(NSInteger)maxTextLength
{
    UITextInputChangeResultModel *resultModel = [UITextInputLimitCJHelper shouldChange_newTextFromOldText:oldText shouldChangeCharactersInRange:range replacementString:string maxTextLength:maxTextLength substringToIndexBlock:^NSString * _Nonnull(NSString * _Nonnull bString, NSInteger bIndex) {
        NSString *indexSubstring = [CJSubStringUtil substringToIndex:bIndex forEmojiString:bString];
        return indexSubstring;
    } lengthCalculationBlock:^NSInteger(NSString * _Nonnull calculationString) {
        NSInteger calculationStringLength = calculationString.cj_length;
        return calculationStringLength;
    }];
    
    return resultModel;
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
