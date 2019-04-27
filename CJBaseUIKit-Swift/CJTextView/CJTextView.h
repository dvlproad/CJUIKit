//
//  CJTextView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//
/* 包含功能：
 ①占位符、
 ②允许设置文本框最大高度、
 ③提供高度变化时候的回调(回调信息里含当前文本框高度)、
 ④提供字符的插入和删除操作，该操作支持系统表情字符
 */

#import <UIKit/UIKit.h>

@interface CJTextView : UITextView

@property (nonatomic, strong) NSString *placeholder;        /**< 占位文字 */
@property (nonatomic, strong) UIColor *placeholderColor;    /**< 占位文字颜色 */
@property (nonatomic, assign) NSUInteger cornerRadius;      /**< 设置圆角 */

@property (nonatomic, assign, readonly) NSInteger originTextViewHeight;   /**< 文本框的初始高度 */

///通用设置，子类需要继承此方法
- (void)commonInit;

/**
 *  设置文本框的最大行数，在文本框文字高度改变变化的时候，利用block中返回的文本高度来更新textView的高度
 *
 *  @param maxNumberOfLines             textView的最大行数
 *  @param textViewHeightChangeBlock    文字高度改变block（文字高度改变会自动调用）
 *
 */
- (void)setMaxNumberOfLines:(NSUInteger)maxNumberOfLines
      textHeightChangeBlock:(void(^)(NSString *text, CGFloat currentTextViewHeight))textViewHeightChangeBlock;



/**
 *  设置文本框的最大高度，在文本框文字高度改变变化的时候，利用block中返回的文本高度来更新textView的高度
 *
 *  @param maxTextViewHeight            textView的最大高度
 *  @param textViewHeightChangeBlock    文字高度改变block（文字高度改变会自动调用）
 *
 */
- (void)setMaxTextViewHeight:(NSUInteger)maxTextViewHeight
       textHeightChangeBlock:(void (^)(NSString *text, CGFloat currentTextViewHeight))textViewHeightChangeBlock;

///如果是attributedText，需要手动调用textDidChange，因为不是改变text的不会调用，所以这个方法目前只用在了输入表情时候
- (void)textDidChange;



#pragma mark - 字符插入或者删除操作
/**
 *  插入系统表情字符
 *
 *  @param emotionString 要插入的系统表情字符
 */
- (void)insertEmotionString:(NSString *)emotionString;

/**
 *  删除倒数的几个字符(因为一个删除操作，有时候是删除一个字符，但有时候是删除最后一个表情)
 */
- (void)deleteCharactersLength:(NSInteger)shouldDeleteCharactersLength;

@end
