//
//  CQTSAutoTestMethodModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/10/29.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSAutoTestMethodModel : NSObject {
    
}
@property (nonatomic, copy) NSString *text;                     /**< 要处理的text */
@property (nullable, nonatomic, copy) NSString *placeholder;
@property (nullable, nonatomic, copy) NSString *hopeResultText; /**< 可选设置：希望处理后的text结果值(如果有设置，则当处理结果不等于该值时会弹出toast提示) */
@property (nonatomic, copy) NSString *actionTitle;      /**< 该文本要进行的操作含义 */
//@property (nonatomic, assign) CJValidateButtonPosition actionPosition;   /**< 按钮位置(中间：适合按钮文字长，左侧：适合按钮文字短），设置后自动更新布局*/
@property (nonatomic, copy) NSString* _Nullable(^actionBlock)(NSString *oldString);  /**< 点该文本要进行的操作事件 */
@property (nonatomic, assign) BOOL autoExec;            /**< 是否在cell显示出来的时候自动执行(默认NO) */

@end

NS_ASSUME_NONNULL_END
