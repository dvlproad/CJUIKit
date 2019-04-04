//
//  CJDemoDateTextField.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/4/3.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJDemoDateTextField.h"
#import "CJDemoDatePickerView.h"
#import "NSDateFormatterCJHelper.h"
#import "NSCalendarCJHelper.h"
#import "UITextField+CJForbidKeyboard.h"

@interface CJDemoDateTextField () <UITextFieldDelegate> {
    
}
@property (nonatomic, strong) CJDemoDatePickerView *datePickerView;

@end


@implementation CJDemoDateTextField

/**
 *  用来选择日期的文本框(文本框中的值只能来源于选择，不能来源于输入)
 *
 *  @param defaultDate          defaultDate
 *  @param confirmCompleteBlock confirmCompleteBlock
 */
- (instancetype)initWithDefaultDate:(NSDate *)defaultDate
               confirmCompleteBlock:(void(^)(NSDate *seletedDate, NSString *seletedDateString))confirmCompleteBlock
{
    self = [super init];
    if (self) {
        if (defaultDate == nil) {
            defaultDate = [NSDate date];
        }
        
        self.backgroundColor = CJColorFromHexString(@"#ffffff");
        self.textAlignment = NSTextAlignmentCenter;
        self.delegate = self;
        
        UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        leftButton.backgroundColor = [UIColor orangeColor];
        UIImage *leftNormalImage = [UIImage imageNamed:@"minus_common_icon"];
        [leftButton setImage:leftNormalImage forState:UIControlStateNormal];
        [leftButton setCjTouchUpInsideBlock:^(UIButton *button) {
            NSDate *newDate = NSCalendarCJHelper_yesterday(self.currentDate);
            [self __updateCurrentDate:newDate isFromDatePicker:NO];
        }];
        [leftButton setFrame:CGRectMake(0, 0, 20, 20)];
        self.leftView = leftButton;
        self.leftViewMode = UITextFieldViewModeAlways;
        self.leftViewLeftOffset = 10;
        self.leftViewRightOffset = 10;
        
        UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        rightButton.backgroundColor = [UIColor orangeColor];
        UIImage *rightNormalImage = [UIImage imageNamed:@"add_common_icon"];
        [rightButton setImage:rightNormalImage forState:UIControlStateNormal];
        [rightButton setCjTouchUpInsideBlock:^(UIButton *button) {
            NSDate *newDate = NSCalendarCJHelper_tomorrow(self.currentDate);
            [self __updateCurrentDate:newDate isFromDatePicker:NO];
        }];
        [rightButton setFrame:CGRectMake(0, 0, 20, 20)];
        self.rightView = rightButton;
        self.rightViewMode = UITextFieldViewModeAlways;
        self.rightViewLeftOffset = 10;
        self.rightViewRightOffset = 10;
        
        // datePickerView
        CJDemoDatePickerView *datePickerView = [[CJDemoDatePickerView alloc] initWithDefaultDate:defaultDate cancelHandle:nil confirmHandle:^(NSDate *seletedDate, NSString *seletedDateString) {
            [self __updateCurrentDate:seletedDate isFromDatePicker:YES];
            if (confirmCompleteBlock) {
                confirmCompleteBlock(seletedDate, seletedDateString);
            }
        }];
        [datePickerView autoShowFromView:self];
        datePickerView.datePicker.maximumDate = [NSDate date];
        datePickerView.datePicker.minimumDate = [datePickerView.dateFormatter dateFromString:@"1900-01-01"];
        self.datePickerView = datePickerView;
        [self cj_forbidKeyboardAndTextPicker:datePickerView];
        self.forbidMenuType = CJTextFieldForbidMenuTypeAll;
        
        // 使用默认值
        [self __updateCurrentDate:defaultDate isFromDatePicker:NO];
    }
    return self;
}


#pragma mark - Private
- (void)__updateCurrentDate:(NSDate *)date isFromDatePicker:(BOOL)isFromDatePicker {
    NSString *dateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMdd_stringFromDate:date];
    self.text = dateString;
    _currentDate = date;
    
    if (isFromDatePicker == NO) {
        self.datePickerView.datePicker.date = date;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
