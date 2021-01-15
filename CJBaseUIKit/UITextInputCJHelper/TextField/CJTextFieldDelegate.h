//
//  CJTextFieldDelegate.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJTextFieldDelegate : NSObject <UITextFieldDelegate> {
    
}
@property (nullable, nonatomic, copy, readonly) NSString *shouldChangeWithOldText;
@property (nonatomic, assign, readonly) NSRange shouldChangeCharactersInRange;
@property (nonatomic, copy, readonly) NSString *shouldChangeWithReplacementString;
@property (nonatomic, assign, readonly) NSInteger maxTextLength;    /**< 最大长度（英文长度算1，中文长度算2） */

#pragma mark - Setup
/*
 *  设置最大长度，并在已封装shouldChange中增加额外的能否输入的判断（如输入手机号码的时候，希望会系统处理出的新文本判断，在新文本不合法的时候能有对应toast提示）
 *
 *  @param maxTextLength                最大长度（英文长度算1，中文长度算2）
 *  @param extraShouldChangeCheckBlock  增加的额外能否输入的判断（这里添加的block一般都不应该再做长度限制了）
 */
- (void)setupMaxTextLength:(NSInteger)maxTextLength addExtraShouldChangeCheckBlock:(BOOL (^ _Nullable)(NSString *newText))extraShouldChangeCheckBlock;

@end

NS_ASSUME_NONNULL_END
