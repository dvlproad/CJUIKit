//
//  CQTextInputChangeResultModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/5/15.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTextInputChangeResultModel : NSObject {
    
}
@property (nonatomic, strong) NSString *hopeReplacementString;  /**< 希望替换的文本(有时候往中间粘贴太多文本时候，希望只粘贴部分) */
@property (nonatomic, strong) NSString *hopeNewText;            /**< 最终希望显示的文本(有时候往中间粘贴太多文本时候，希望保留原本的，而只对粘贴部分截取来粘贴) */

@end

NS_ASSUME_NONNULL_END
