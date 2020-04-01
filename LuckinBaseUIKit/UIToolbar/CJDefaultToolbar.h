//
//  CJDefaultToolbar.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/3/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, CJDefaultToolbarOption) {
    CJDefaultToolbarOptionConfirm = 1 << 0, /**< 是否有确定按钮 */
    CJDefaultToolbarOptionCancel = 1 << 1,  /**< 是否有取消按钮 */
    CJDefaultToolbarOptionValue = 1 << 2,   /**< 是否有值显示 */
};

//CJPicker中经常会用到
@interface CJDefaultToolbar : UIToolbar {
    
}
@property (nonatomic, copy) void (^confirmHandle)(void);    /**< 点击确定执行的操作 */
@property (nonatomic, copy) void (^cancelHandle)(void);     /**< 点击取消执行的操作 */

@property (nonatomic, assign) CJDefaultToolbarOption option;
@property (nonatomic, assign, readonly) BOOL hasValue;      /**< 是否是设置值 */

/**
 *  更新toolbar上显示的值
 *
 *  @param value    toolbar上要显示的值
 */
- (void)updateShowingValue:(NSString *)value;

@end
