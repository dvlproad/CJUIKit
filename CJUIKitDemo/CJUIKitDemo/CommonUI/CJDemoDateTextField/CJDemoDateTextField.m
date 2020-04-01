//
//  CJDemoDateTextField.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/4/3.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJDemoDateTextField.h"

#ifdef TEST_CJBASEUIKIT_POD
#import "UIColor+CJHex.h"
#import "UIView+CJPopupInView.h"
#import "UITextField+CJTextChangeBlock.h"
#else
#import <LuckinBaseUIKit/UIColor+CJHex.h>
#import <LuckinBaseUIKit/UIView+CJPopupInView.h>
#import <LuckinBaseUIKit/UITextField+CJTextChangeBlock.h>
#endif

@interface CJDemoDateTextField () <UITextFieldDelegate> {
    
}
@property (nonatomic, strong) CJDemoDatePickerView *datePickerView;

@end


@implementation CJDemoDateTextField

/**
 *  用来选择日期的文本框(文本框中的值只能来源于选择，不能来源于输入)
 *
 *  @param confirmCompleteBlock confirmCompleteBlock
 */
- (instancetype)initWithConfirmCompleteBlock:(void(^)(NSDate *seletedDate, NSString *seletedDateString))confirmCompleteBlock
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.textAlignment = NSTextAlignmentCenter;
        
        self.backgroundColor = [UIColor whiteColor];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = 4;
        self.allowPickDate = NO;
        
        // 防止会出现第三方库如IQKeyboardManager会自动为textField的弹出的inputView键盘添加Toolbar
        UIView *overlayView = [[UIView alloc] init];
        overlayView.backgroundColor = [UIColor clearColor];
        [self addSubview:overlayView];
        [overlayView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        overlayView.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(__handleSingleTap:)];
        singleTapGesture.numberOfTapsRequired = 1;
        singleTapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:singleTapGesture];
        
        
        // datePickerView
        CJDemoDatePickerView *datePickerView = [[CJDemoDatePickerView alloc] initWithCancelHandle:nil confirmHandle:^(NSDate *seletedDate, NSString *seletedDateString) {
            [self __updateCurrentDate:seletedDate];
            if (confirmCompleteBlock) {
                confirmCompleteBlock(seletedDate, seletedDateString);
            }
        }];
        self.datePickerView = datePickerView;
    }
    return self;
}

#pragma mark - Setter
- (void)setAllowPickDate:(BOOL)allowPickDate {
    _allowPickDate = allowPickDate;
    if (allowPickDate) {
        self.backgroundColor = [UIColor whiteColor];
        self.layer.borderColor = CJColorFromHexString(@"#CCCCCC").CGColor;
        self.layer.borderWidth = 1;
    } else {
        self.backgroundColor = CJColorFromHexString(@"#F9F9F9");
        self.layer.borderWidth = 0;
    }
}

- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    self.datePickerView.maximumDate = maximumDate;
    //self.datePickerView.maximumDate = [NSDate date];
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    self.datePickerView.minimumDate = minimumDate;
    //self.datePickerView.minimumDate = [datePickerView.dateFormatter dateFromString:@"1900-01-01"];
}


#pragma mark - Event

/**
 *  同时更新 TextField 和 datePicker 弹出时候的默认选中日期
 *
 *  @param dateString datePicker弹出时候的默认选中日期,未设置时候是显示当前日期
 */
- (void)updateTextFieldAndDatePickerWithDateString:(NSString *)dateString {
    self.text = dateString;
    NSDate *date = [[NSDateFormatterCJHelper sharedInstance] yyyyMMdd_dateFromString:dateString];
    if (date) {
        [self.datePickerView updateDefaultDate:date];
    }
}

- (void)__handleSingleTap:(UIGestureRecognizer *)gr {
    if (self.allowPickDate) {
        [self.datePickerView show];
    }
}


#pragma mark - Private
- (void)__updateCurrentDate:(NSDate *)date {
    NSString *dateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMdd_stringFromDate:date];
    self.text = dateString;
    _date = date;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
