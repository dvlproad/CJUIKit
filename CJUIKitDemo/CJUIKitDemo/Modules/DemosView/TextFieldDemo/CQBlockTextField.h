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
@property (nonatomic, assign, readonly) NSInteger maxTextLength;    /**< 最大长度（英文长度算1，中文长度算2） */

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


#pragma mark - Event
/*
 *  更新最大长度
 *
 *  @param maxTextLength    最大长度（英文长度算1，中文长度算2）
 */
- (void)updateMaxTextLength:(NSInteger)maxTextLength;


@end

NS_ASSUME_NONNULL_END
