//
//  CJDemoDatePickerView.m
//  AppCommonUICollect
//
//  Created by ciyouzen on 6/20/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJDemoDatePickerView.h"
#ifdef TEST_CJBASEUIKIT_POD
#import "UIView+CJPopupInView.h"
#else
#import <CJBaseUIKit/UIView+CJPopupInView.h>
#endif

@interface CJDemoDatePickerView () {
    
}
@property (nonatomic, strong) CJDefaultToolbar *toolbar;
@property (nonatomic, strong) UIDatePicker *datePicker; //UIDatePicker默认216的高
@property (nonatomic, copy) void (^cancelHandle)(void);     /**< 点击取消执行的操作 */
@property (nonatomic, copy) void (^confirmHandle)(NSDate *seletedDate, NSString *seletedDateString);    /**< 点击确定执行的操作 */
@property (nonatomic, copy) void(^valueChangedHandel)(UIDatePicker *datePicker);

@end




@implementation CJDemoDatePickerView

#pragma mark - Init
- (instancetype)initWithCancelHandle:(void (^ _Nullable )(void))cancelHandle
                       confirmHandle:(void (^)(NSDate *seletedDate, NSString *seletedDateString))confirmHandle
{
    self = [super initWithFrame:CGRectMake(0, 0, 0, 260)];
    if (self) {
        _cancelHandle = cancelHandle;
        _confirmHandle = confirmHandle;
        [self setupViews];
    }
    return self;
}

#pragma mark - Setter
- (void)setMaximumDate:(NSDate *)maximumDate {
    _maximumDate = maximumDate;
    self.datePicker.maximumDate = maximumDate;
}

- (void)setMinimumDate:(NSDate *)minimumDate {
    _minimumDate = minimumDate;
    self.datePicker.minimumDate = minimumDate;
}

#pragma mark - Event
/**
 *  设置datePicker弹出时候默认的显示日期
 *
 *  @param defaultDate  默认显示日期
 */
- (void)updateDefaultDate:(NSDate *)defaultDate {
    if (defaultDate) { //.date未设置时显示上次日期，未有上次日期显示今天日期
        self.datePicker.date = defaultDate;
    }
    [self __updateToolbarSeletedDate:defaultDate]; //保证toolbar显示datePicker对应的值
}

/**
 *  显示日期选择视图
 */
- (void)show {
    if (self.toolbar.hasValue == NO) {
        [self __updateToolbarSeletedDate:[NSDate date]];
    }

    CGFloat popupViewHeight = CGRectGetHeight(self.frame);
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    __weak typeof(self)weakSelf = self;
    [self cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight blankBGColor:blankBGColor showComplete:nil tapBlankComplete:^() {
        [weakSelf cj_hidePopupView];
    }];
}

#pragma mark - SetupView & Lazy
- (void)setupViews {
    self.backgroundColor = [UIColor whiteColor];
    
    // datePicker
    [self addSubview:self.datePicker];
    self.datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.datePicker
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.datePicker
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.datePicker
                                  attribute:NSLayoutAttributeHeight //height
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:216]];  //UIDatePicker默认216的高
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.datePicker
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];
    
    
    // toolbar
    [self addSubview:self.toolbar];
    self.toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.toolbar
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.toolbar
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.toolbar
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:self.toolbar
                                  attribute:NSLayoutAttributeHeight //height
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:44]];
}


- (UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        _datePicker.locale = [NSLocale localeWithLocaleIdentifier:@"zh"];//设置地区: zh-中国
        //_datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker addTarget:self action:@selector(__valueChangedAction:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _datePicker;
}

- (CJDefaultToolbar *)toolbar {
    if (_toolbar == nil) {
        _toolbar = [[CJDefaultToolbar alloc] initWithFrame:CGRectZero];
        _toolbar.option = CJDefaultToolbarOptionConfirm | CJDefaultToolbarOptionValue | CJDefaultToolbarOptionCancel;
        __weak typeof(self)weakSelf = self;
        [self.toolbar setCancelHandle:^{
            [weakSelf __cancel];
        }];
        
        [self.toolbar setConfirmHandle:^{
            [weakSelf __confirm];
        }];
    }
    return _toolbar;
}

- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];    //NSDateFormatter的优化
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    return _dateFormatter;
}


#pragma mark - Private
/// datePicker值改变触发
- (void)__valueChangedAction:(UIDatePicker *)datePicker {
    [self __updateToolbarSeletedDate:datePicker.date];
    
    if (self.valueChangedHandel) {
        self.valueChangedHandel(datePicker);
    }
}

/// 更新当前选择的日期
- (void)__updateToolbarSeletedDate:(NSDate *)seletedDate {
    NSDate *maximumDate = self.datePicker.maximumDate;
    if (maximumDate && [seletedDate compare:maximumDate] == NSOrderedDescending) {
        NSLog(@"当前选择日期太大");
    }
    NSDate *minimumDate = self.datePicker.minimumDate;
    if (minimumDate && [seletedDate compare:minimumDate] == NSOrderedAscending) {
        NSLog(@"当前选择日期太小");
    }
    
    NSString *seletedDateFullString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:seletedDate];
    NSLog(@"当前选择日期:%@\n%@", seletedDate, seletedDateFullString);
    
    NSString *seletedDateString = [self.dateFormatter stringFromDate:seletedDate];
    [self.toolbar updateShowingValue:seletedDateString];
}

- (void)__cancel {
    [self cj_hidePopupView];
    
    !self.cancelHandle ?: self.cancelHandle();
}

- (void)__confirm {
    [self cj_hidePopupView];
    
    NSDate *seletedDate = self.datePicker.date;
    
    NSString *seletedDateFullString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:seletedDate];
    NSLog(@"当前选择日期:%@\n%@", seletedDate, seletedDateFullString);
    
    NSString *seletedDateString = [self.dateFormatter stringFromDate:seletedDate];
    !self.confirmHandle ?: self.confirmHandle(seletedDate, seletedDateString);
}

@end
