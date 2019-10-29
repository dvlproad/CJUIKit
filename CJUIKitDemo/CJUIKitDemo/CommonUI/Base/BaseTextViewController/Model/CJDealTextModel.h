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
@property (nonatomic, copy) NSString *actionTitle;      /**< 该文本要进行的操作含义 */
@property (nonatomic, copy) NSString*(^actionBlock)(NSString *oldString);  /**< 点该文本要进行的操作事件 */

@end

NS_ASSUME_NONNULL_END
