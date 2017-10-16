//
//  CJDefaultToolbar.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2017/3/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSUInteger, CJDefaultToolbarOption) {
    CJDefaultToolbarOptionConfirm = 1 << 0,
    CJDefaultToolbarOptionCancel = 1 << 1,
};

//CJPicker中经常会用到
@interface CJDefaultToolbar : UIToolbar

@property (nonatomic, copy) void (^confirmHandle)(void);    /**< 点击确定执行的操作 */
@property (nonatomic, copy) void (^cancelHandle)(void);     /**< 点击取消执行的操作 */

@property (nonatomic, assign) CJDefaultToolbarOption option;

@end
