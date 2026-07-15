//
//  UITextView+CJBlock.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "UITextView+CJBlock.h"
#import <objc/runtime.h>
#import <CJDataVientianeSDK/UITextInputLimitCJHelper.h>
#import "CJTextViewDelegate.h"
#import "UITextInputCursorCJHelper.h"

@interface UITextView () {
    
}
@property (nonatomic, strong, readonly) CJTextViewDelegate *cjBlockDelegate;

@end



@implementation UITextView (CJBlock)

#pragma mark - runtime:normal
- (CJTextViewDelegate *)cjBlockDelegate {
    return objc_getAssociatedObject(self, @selector(cjBlockDelegate));
}

- (void)setCjBlockDelegate:(CJTextViewDelegate *)cjBlockDelegate {
    objc_setAssociatedObject(self, @selector(cjBlockDelegate), cjBlockDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (NSString *)cjLastSelectedText {
    NSString *lastSelectedText = objc_getAssociatedObject(self, @selector(cjLastSelectedText));
    if (lastSelectedText.length == 0) {         // 防止外部未触发textDidChange的时候就直接取这个值而空的问题
        lastSelectedText = self.text;
        [self setCjLastSelectedText:self.text]; // 注意：一定要设置进去，防止下次取出来还是空，造成每次都是空，从而都是取self.text的bug
    }
    return lastSelectedText;
}

- (void)setCjLastSelectedText:(NSString * _Nonnull)cjLastSelectedText {
    objc_setAssociatedObject(self, @selector(cjLastSelectedText), cjLastSelectedText, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



#pragma mark - Event
/*
 *  将delegete接口改为block，设置最大长度，并在已封装shouldChange中增加额外的能否输入的判断（如输入手机号码的时候，希望会系统处理出的新文本判断，在新文本不合法的时候能有对应toast提示）
 *
 *  @param maxTextLength                最大长度（英文长度算1，中文长度算2）
 *  @param inputTextCheckHandle         此次想要输入的文本能否真正输入的判断（如\n回车，为nil的时候，输入\n会执行resignFirstResponder）
 *  @param extraShouldChangeCheckBlock  增加的额外能否输入的判断（这里添加的block一般都不应该再做长度限制了）
 */
- (void)cjChangeDelegateToBlockWithMaxTextLength:(NSInteger)maxTextLength
                            inputTextCheckHandle:(BOOL(^ _Nullable)(NSString *bInputText))inputTextCheckHandle
                  addExtraShouldChangeCheckBlock:(BOOL (^ _Nullable)(NSString *newText))extraShouldChangeCheckBlock
{
    CJTextViewDelegate *blockDelegate = [[CJTextViewDelegate alloc] init];
    self.cjBlockDelegate = blockDelegate;
    self.delegate = blockDelegate;
    
//    self.delegate = self; // 会有特殊bug:输入拼音后，点击上面的中文没走shouldChangeCharactersInRange
    
    [self.cjBlockDelegate setupMaxTextLength:maxTextLength
                        inputTextCheckHandle:inputTextCheckHandle
              addExtraShouldChangeCheckBlock:extraShouldChangeCheckBlock];
}


#pragma mark - Update

/*
 *  结合自定义的delegate，根据自定义的长度计算方法，在超过长度后，按照自定义的截取方法(防止系统的截取方法)截取能插入的长度个数插入(输入/粘贴)进去在检查到如果需要更新的时候，更新text（更新的时候会调用setText）
 *  @note           [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
 *
 *  @param lengthCalculationBlock   字符串占位长度的计算方法
 *  @param substringToIndexBlock    子字符串截取的方法（有时候不能使用系统方法，防止在处理含表情字符串的时候，截取的字符串错误。如"👌",截取1，得到的不是"👌"）
 */
- (void)cjUpdateTextIfNeedByDelegateWithLengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock
                                         substringToIndexBlock:(NSString*(^ _Nonnull)(NSString *bString, NSInteger bIndex))substringToIndexBlock
{
    UITextView *textView = self;
    
    // 判断是否存在高亮字符，如果有，则不进行字数统计和字符串截断(注意1高亮的时候，长度计算以莫名其妙的规则计算，2shouldChangeCharactersInRange中无法获取第一个未选中的时机)
    UITextRange *selectedRange = textView.markedTextRange;
    UITextPosition *position = [textView positionFromPosition:selectedRange.start offset:0];
    BOOL donotneedCustomDealText = position != nil; // 存在高亮即未选中文本的时候，不需要自己处理文本框内容
    if (donotneedCustomDealText ==  YES) {
        return;
    }
    
    // 过滤空格
    //NSLog(@"系统处理后得到的文本:%@", textField.text);
    NSString *oldText = self.cjBlockDelegate.shouldChangeWithOldText; // 文本框中高亮和不高亮的文本
    if (oldText == nil) {
        oldText = textView.text; // 防止该方法被外部直接调用的时候，oldText为空，而导致数据被清
        return;
    }
    NSRange range = self.cjBlockDelegate.shouldChangeCharactersInRange;
    NSString *string = self.cjBlockDelegate.shouldChangeWithReplacementString;
    NSInteger maxTextLength = self.cjBlockDelegate.maxTextLength;
    UITextInputChangeResultModel *resultModel =
            [UITextInputLimitCJHelper shouldChange_newTextFromOldText:oldText
                                   shouldChangeCharactersInRange:range
                                               replacementString:string maxTextLength:maxTextLength
                                           substringToIndexBlock:substringToIndexBlock
                                          lengthCalculationBlock:lengthCalculationBlock];

    
    NSString *newTextFromSystemDeal = [oldText stringByReplacingCharactersInRange:range withString:string];
    NSString *newTextFromCustomDeal = resultModel.hopeNewText;
    //BOOL isDifferentFromSystemDeal = resultModel.isDifferentFromSystemDeal;
    BOOL isDifferentFromSystemDeal = [newTextFromCustomDeal isEqualToString:newTextFromSystemDeal] == NO;
    if (isDifferentFromSystemDeal) {
        // 注意，此步非常重要。是为了对于那些系统能处理的，就不去自己再setText了，防止光标和range变化。可有异常
        //NSLog(@"自己处理希望得到的文本:%@", newTextFromCustomDeal);  // 有时候限制了最大长度，又在中间插入超多字符。会希望原有字符不变。只插入其他数值
        textView.text = newTextFromCustomDeal;   // 使用这个方法会使得光标变到末尾了,所以我们还需要更新光标位置
        NSString *lastReplacementString = resultModel.hopeReplacementString;
        NSInteger cursorLocation = range.location+lastReplacementString.length;
        [UITextInputCursorCJHelper setCursorLocationForTextView:textView atIndex:cursorLocation];
    }
    
    self.cjLastSelectedText = textView.text;  // 只文本框中高亮的文本
}


@end
