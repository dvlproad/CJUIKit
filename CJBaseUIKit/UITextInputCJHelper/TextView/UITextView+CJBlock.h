//
//  UITextView+CJBlock.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextView (CJBlock) <UITextViewDelegate> {
    
}
@property (nonatomic, copy, readonly) NSString *cjLastSelectedText;   /**< 上一次没有未选中/没有高亮文本时候的文本（对外提供该值，防止页面切换时候，如果只能采用textField.text的取值方法，则会造成有时候把未选中待确认的文本也赋值上去，造成原本的长度限制该时候无效的bug） */

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
                  addExtraShouldChangeCheckBlock:(BOOL (^ _Nullable)(NSString *newText))extraShouldChangeCheckBlock;
- (void)setDelegate:(nullable id<UITextViewDelegate>)delegate NS_UNAVAILABLE; // (使用此类时候，禁止再进行delegate的设置)


#pragma mark - Update
/*
 *  结合自定义的delegate，根据自定义的长度计算方法，在超过长度后，按照自定义的截取方法(防止系统的截取方法)截取能插入的长度个数插入(输入/粘贴)进去在检查到如果需要更新的时候，更新text（更新的时候会调用setText）
 *  @note           [[NSNotificationCenter defaultCenter] addObserver:self  selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
 *
 *  @param lengthCalculationBlock   字符串占位长度的计算方法
 *  @param substringToIndexBlock    子字符串截取的方法（有时候不能使用系统方法，防止在处理含表情字符串的时候，截取的字符串错误。如"👌",截取1，得到的不是"👌"）
 */
- (void)cjUpdateTextIfNeedByDelegateWithLengthCalculationBlock:(NSInteger(^ _Nonnull)(NSString *calculationString))lengthCalculationBlock
                                         substringToIndexBlock:(NSString*(^ _Nonnull)(NSString *bString, NSInteger bIndex))substringToIndexBlock;


@end

NS_ASSUME_NONNULL_END
