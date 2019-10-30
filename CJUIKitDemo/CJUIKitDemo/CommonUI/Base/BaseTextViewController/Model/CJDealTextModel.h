//
//  CJDealTextModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/10/29.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJDealTextModel : NSObject {
    
}
@property (nonatomic, copy) NSString *text;             /**< 要处理的text */
@property (nonatomic, copy) NSString *placeholder;
@property (nonatomic, copy) NSString *hopeResultText;   /**< 可选设置：希望处理后的text结果值(如果有设置，则当处理结果不等于该值时会弹出toast提示) */
@property (nonatomic, copy) NSString *actionTitle;      /**< 该文本要进行的操作含义 */
@property (nonatomic, copy) NSString*(^actionBlock)(NSString *oldString);  /**< 点该文本要进行的操作事件 */
@property (nonatomic, assign) BOOL autoExec;            /**< 是否在cell显示出来的时候自动执行(默认NO) */

@end

NS_ASSUME_NONNULL_END
