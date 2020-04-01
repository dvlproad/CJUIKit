//
//  CJExtraTextTextField.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/11/30.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

///一个可以在自己输入的字符串前后添加其他额外字符串的文本框
@interface CJExtraTextTextField : UITextField {
    
}
@property (nonatomic, copy) NSString *beforeExtraString;    /**< 头部额外字段 */
@property (nonatomic, copy) NSString *afterExtraString;     /**< 尾部额外字段 */
@property (nonatomic, copy, readonly) NSString *middleString;   /**< 中间有效的字段 */
@property (nonatomic, assign) NSInteger limitTextLength;    /**< 整个文本的限制长度(默认无限长) */


/**
 *  自适应光标位置(当光标位置处在不符合的位置时候，其会自动调整光标到合适的位置)
 *
 *  @return 自适应后的光标位置是否是最小位置
 */
- (BOOL)fixCursor;

/**
 *  完善补充textField的额外字符串
 *
 */
- (void)fixExtraString;

@end
