//
//  UITextInputChangeResultModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface UITextInputChangeResultModel : NSObject {
    
}
@property (nonatomic, copy, readonly) NSString *originReplacementString;/**< 原始的替换文本（未处理空格等之前的） */
@property (nullable, nonatomic, copy) NSString *hopeReplacementString;  /**< 希望替换的文本(有时候往中间粘贴太多文本时候，希望只粘贴部分) */
@property (nonatomic, copy) NSString *hopeNewText;            /**< 最终希望显示的文本(有时候往中间粘贴太多文本时候，希望保留原本的，而只对粘贴部分截取来粘贴) */
@property (nonatomic, assign) BOOL isDifferentFromSystemDeal; /**< 是否最终得到的字符串不同于系统处理(有时候往中间粘贴太多文本时候，希望只粘贴部分) */

/*
 *  初始化
 *
 *  @param originReplacementString 原始的替换文本（未处理空格等之前的）
 *
 *  @return 模型
 */
- (instancetype)initWithOriginReplacementString:(NSString *)originReplacementString NS_DESIGNATED_INITIALIZER;
- (instancetype)init NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
