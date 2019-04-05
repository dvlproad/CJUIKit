//
//  CJDemoDatePickerView.h
//  CJPickerDemo
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

@interface CJDemoDatePickerView : UIView {
    
}
//@property (nonatomic, assign, readonly) BOOL isShowing; /**< 是否正在显示 */
@property (nonatomic, strong) UIDatePicker *datePicker; //UIDatePicker默认216的高
@property (nonatomic, strong) NSDateFormatter *dateFormatter;

/**
 *  初始方法
 *
 *  @param defaultDate      defaultDate
 *  @param cancelHandle     点击确定执行的操作
 *  @param confirmHandle    点击取消执行的操作
 *
 *  @return 对象
 */
- (instancetype)initWithDefaultDate:(NSDate *)defaultDate
                       cancelHandle:(void (^)(void))cancelHandle
                      confirmHandle:(void (^)(NSDate *seletedDate, NSString *seletedDateString))confirmHandle NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 *  设置日期选择是作为哪个视图的inputView(如textField的inputView)
 *
 *  @param serviceView 作为哪个视图的inputView
 */
- (void)autoShowFromView:(UIView *)serviceView;

/**
 *  显示日期选择视图，并显示默认日期(默认日期可为nil)
 *
 *  @param defaultDate  默认显示日期
 */
- (void)showWithDefaultDate:(NSDate *)defaultDate;

@end
