//
//  CQBlockTextField.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//
//  将delegete改为block的文本输入框视图(使用此类时候，禁止再进行delegate的设置)

#import "CJTextField.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQBlockTextField : CJTextField {
    
}
@property (nonatomic, copy, readonly) NSString *lastSelectedText;   /**< 上一次没有未选中/没有高亮文本时候的文本（对外提供该值，防止页面切换时候，如果只能采用textField.text的取值方法，则会造成有时候把未选中待确认的文本也赋值上去，造成原本的长度限制该时候无效的bug） */

/*
 *  初始化将delegete接口改为block的文本输入框视图(使用此类时候，禁止再进行delegate的设置)
 *  @brief  使用此类时候，禁止再进行delegate的设置
 *
 *  @param textDidChangeBlock       文本已经改变的通知事件
 *
 *  @return 将delegete接口改为block的文本输入框视图
 */
- (instancetype)initWithTextDidChangeBlock:(void (^ __nullable)(NSString *text))textDidChangeBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

- (void)setDelegate:(nullable id<UITextFieldDelegate>)delegate NS_UNAVAILABLE; // (使用此类时候，禁止再进行delegate的设置)


#pragma mark - Setup
/*
 *  设置最大长度，并在已封装shouldChange中增加额外的能否输入的判断（如输入手机号码的时候，希望会系统处理出的新文本判断，在新文本不合法的时候能有对应toast提示）
 *
 *  @param maxTextLength                最大长度（英文长度算1，中文长度算2）
 *  @param extraShouldChangeCheckBlock  增加的额外能否输入的判断（这里添加的block一般都不应该再做长度限制了）
 */
- (void)setupMaxTextLength:(NSInteger)maxTextLength addExtraShouldChangeCheckBlock:(BOOL (^ _Nullable)(NSString *newText))extraShouldChangeCheckBlock;

#pragma mark - Getter
- (NSInteger)maxTextLength;


@end

NS_ASSUME_NONNULL_END
