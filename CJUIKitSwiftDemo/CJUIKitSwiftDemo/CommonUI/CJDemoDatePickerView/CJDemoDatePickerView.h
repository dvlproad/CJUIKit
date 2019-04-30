//
//  CJDemoDatePickerView.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 6/20/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  含toolbar的日期选择视图

#import <UIKit/UIKit.h>

#ifdef TEST_CJBASEUIKIT_POD
#import "CJDefaultToolbar.h"
#import "NSDateFormatterCJHelper.h"
#import "NSCalendarCJHelper.h"
#else
#import <CJBaseUIKit/CJDefaultToolbar.h>
#import <CJBaseHelper/NSDateFormatterCJHelper.h>
#import <CJBaseHelper/NSCalendarCJHelper.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface CJDemoDatePickerView : UIView {
    
}
//@property (nonatomic, assign, readonly) BOOL isShowing; /**< 是否正在显示 */
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@property (nullable, nonatomic, strong) NSDate *minimumDate; // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
@property (nullable, nonatomic, strong) NSDate *maximumDate; // default is nil

/**
 *  初始方法
 *
 *  @param cancelHandle     点击确定执行的操作
 *  @param confirmHandle    点击取消执行的操作
 *
 *  @return 对象
 */
- (instancetype)initWithCancelHandle:(void (^ _Nullable )(void))cancelHandle
                       confirmHandle:(void (^)(NSDate *seletedDate, NSString *seletedDateString))confirmHandle NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 *  设置datePicker弹出时候默认的显示日期
 *
 *  @param defaultDate  默认显示日期
 */
- (void)updateDefaultDate:(NSDate *)defaultDate;

/**
 *  显示日期选择视图
 */
- (void)show;

NS_ASSUME_NONNULL_END

@end
