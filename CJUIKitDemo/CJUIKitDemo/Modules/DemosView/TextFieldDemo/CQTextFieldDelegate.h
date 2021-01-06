//
//  CQTextFieldDelegate.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTextFieldDelegate : NSObject <UITextFieldDelegate> {
    
}
@property (nonatomic, assign, readonly) NSInteger maxTextLength;    /**< 最大长度（英文长度算1，中文长度算2） */

@property (nonatomic, copy, readonly) NSString *shouldChangeWithOldText;
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
