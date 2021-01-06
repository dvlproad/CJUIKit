//
//  CQTextFieldDelegate.h
//  CJUIKitDemo
//
//  Created by qian on 2021/1/6.
//  Copyright © 2021 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTextFieldDelegate : NSObject <UITextFieldDelegate> {
    
}
@property (nonatomic, assign, readonly) NSInteger maxTextLength;    /**< 最大长度（英文长度算1，中文长度算2） */
@property (nonatomic, copy, readonly) NSString *shouldChangeText;   /**< 希望最后得到的值是（有时候限制了最大长度，又在中间插入超多字符。会希望原有字符不变。只插入其他数值） */
@property (nonatomic, assign, readonly) NSRange shouldChangeCharactersInRange;
@property (nonatomic, copy, readonly) NSString *shouldChangeWithReplacementString;


//- (instancetype)initForTextField:(UITextField *)textField NS_DESIGNATED_INITIALIZER;
//+ (instancetype)new NS_UNAVAILABLE;
//- (instancetype)init NS_UNAVAILABLE;

#pragma mark - Setup
/*
 *  设置最大长度
    @brief                  (因为文本框有可能处在cell中，所以单独提供此接口设置最大长度)
 *
 *  @param maxTextLength    最大长度（英文长度算1，中文长度算2）
 */
- (void)setupMaxTextLength:(NSInteger)maxTextLength;

@end

NS_ASSUME_NONNULL_END
