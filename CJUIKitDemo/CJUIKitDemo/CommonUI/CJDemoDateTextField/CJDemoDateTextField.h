//
//  CJDemoDateTextField.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/4/3.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "CJDemoDatePickerView.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJDemoDateTextField : UITextField {
    
}
@property (nonatomic, strong, readonly) NSDate *date;        // default is current date when picker created. Ignored in countdown timer mode. for that mode, picker starts at 0:00
@property (nullable, nonatomic, strong) NSDate *minimumDate; // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
@property (nullable, nonatomic, strong) NSDate *maximumDate; // default is nil

@property (nonatomic, assign) BOOL allowPickDate;   /**< 允许选择日期 */

/**
 *  用来选择日期的文本框(文本框中的值只能来源于选择，不能来源于输入)
 *
 *  @param confirmCompleteBlock confirmCompleteBlock
 */
- (instancetype)initWithConfirmCompleteBlock:(void(^)(NSDate *seletedDate, NSString *seletedDateString))confirmCompleteBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;;

/**
 *  同时更新 TextField 和 datePicker 弹出时候的默认选中日期
 *
 *  @param dateString datePicker弹出时候的默认选中日期,未设置时候是显示当前日期
 */
- (void)updateTextFieldAndDatePickerWithDateString:(NSString *)dateString;


@end

NS_ASSUME_NONNULL_END
