//
//  CJDemoDateLabel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/4/3.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJDemoDateLabel.h"
#import "CJDemoDatePickerView.h"

#ifdef TEST_CJBASEUIKIT_POD
#import "UIView+CJPopupInView.h"
#else
#import <CJBaseUIKit/UIView+CJPopupInView.h>
#endif

@interface CJDemoDateLabel () {
    
}
@property (nonatomic, strong) UILabel *dateLabel;
@property (nonatomic, strong) CJDemoDatePickerView *datePickerView;

@property (nonatomic, strong, readonly) NSDate *defaultDate;
@property (nonatomic, copy) void (^confirmCompleteBlock)(NSDate *seletedDate, NSString *seletedDateString);

@end


@implementation CJDemoDateLabel

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
        _defaultDate = defaultDate;
        _confirmCompleteBlock = confirmCompleteBlock;
        
        self.backgroundColor = [UIColor whiteColor];
        
        [self addSubview:self.dateLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self);
        }];
        
        [self addSubview:self.clearButton];
        [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.mas_equalTo(self).mas_offset(-8);
            make.centerY.mas_equalTo(self);
            make.size.mas_equalTo(CGSizeMake(14, 14));
        }];
        
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *singleTapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(__handleSingleTap:)];
        singleTapGesture.numberOfTapsRequired = 1;
        singleTapGesture.numberOfTouchesRequired = 1;
        [self addGestureRecognizer:singleTapGesture];
    }
    return self;
}


#pragma mark - Private
- (void)__handleSingleTap:(UIGestureRecognizer *)gr {
    CGFloat popupViewHeight = CGRectGetHeight(self.datePickerView.frame);
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    __weak typeof(self)weakSelf = self;
    [self.datePickerView cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight edgeInsets:UIEdgeInsetsZero blankBGColor:blankBGColor showComplete:nil tapBlankComplete:^() {
        [weakSelf.datePickerView cj_hidePopupView];
    }];
}

- (void)__updateCurrentDate:(NSDate *)date isFromDatePicker:(BOOL)isFromDatePicker {
    NSString *dateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMdd_stringFromDate:date];
    self.text = dateString;
    _currentDate = date;
    
    if (isFromDatePicker == NO) {
        [self.datePickerView updateDefaultDate:date];
    }
}

- (void)__clearText:(UIButton *)clearButton {
    self.text = nil;
}

- (void)setText:(NSString *)text {
    _text = text;
    
    if (text.length == 0) {
        self.clearButton.hidden = YES;
        self.dateLabel.text = self.placeholder;
        self.dateLabel.textColor = [UIColor grayColor];
    } else {
        self.clearButton.hidden = NO;
        self.dateLabel.text = text;
        self.dateLabel.textColor = [UIColor blackColor];
    }
}

- (void)setPlaceholder:(NSString *)placeholder {
    _placeholder = placeholder;
    if (self.text.length == 0) {
        self.text = nil;
    }
}

#pragma mark - Lazy
- (UILabel *)dateLabel {
    if (_dateLabel == nil) {
        _dateLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _dateLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _dateLabel;
}

- (UIButton *)clearButton {
    if (_clearButton == nil) {
        _clearButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [_clearButton setImage:[UIImage imageNamed:@"cjTextField_clear"] forState:UIControlStateNormal];
        [_clearButton addTarget:self action:@selector(__clearText:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _clearButton;
}

- (CJDemoDatePickerView *)datePickerView {
    if (_datePickerView == nil) {
        // datePickerView
        _datePickerView = [[CJDemoDatePickerView alloc] initWithCancelHandle:nil confirmHandle:^(NSDate *seletedDate, NSString *seletedDateString) {
            [self __updateCurrentDate:seletedDate isFromDatePicker:YES];
            if (self.confirmCompleteBlock) {
                self.confirmCompleteBlock(seletedDate, seletedDateString);
            }
        }];
        _datePickerView.maximumDate = [NSDate date];
        _datePickerView.minimumDate = [_datePickerView.dateFormatter dateFromString:@"1900-01-01"];
        [_datePickerView updateDefaultDate:self.defaultDate];
    }
    return _datePickerView;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
