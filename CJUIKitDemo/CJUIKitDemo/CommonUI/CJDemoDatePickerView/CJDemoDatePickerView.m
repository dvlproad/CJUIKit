//
//  CJDemoDatePickerView.m
//  CJPickerDemo
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
@property (nonatomic, strong, readonly) NSDate *defaultDate;/**< 初始化时候的默认现实的日期 */
@property (nonatomic, copy) void (^cancelHandle)(void);     /**< 点击取消执行的操作 */
@property (nonatomic, copy) void (^confirmHandle)(NSDate *seletedDate, NSString *seletedDateString);    /**< 点击确定执行的操作 */
@property (nonatomic, copy) void(^valueChangedHandel)(UIDatePicker *datePicker);

@property (nonatomic, strong, readonly) UIView *serviceView;    /**< 是否是作为inputView使用的,是的话是给哪个view,如作为textField的inputView */

@end




@implementation CJDemoDatePickerView

#pragma mark - Init
- (instancetype)initWithDefaultDate:(NSDate *)defaultDate
                       cancelHandle:(void (^)(void))cancelHandle
                      confirmHandle:(void (^)(NSDate *seletedDate, NSString *seletedDateString))confirmHandle
{
    self = [super initWithFrame:CGRectMake(0, 0, 0, 260)];
    if (self) {
        if (defaultDate == nil) {
            _defaultDate = [NSDate date];
        } else {
            _defaultDate = defaultDate;
        }
        
        _cancelHandle = cancelHandle;
        _confirmHandle = confirmHandle;
        [self setupViews];
    }
    return self;
}

/**
 *  设置日期选择是作为哪个视图的inputView(如textField的inputView)
 *
 *  @param serviceView 作为哪个视图的inputView
 */
- (void)autoShowFromView:(UIView *)serviceView {
    _serviceView = serviceView;
}


#pragma mark - Event
/**
 *  显示日期选择视图，并显示默认日期(默认日期可为nil)
 *
 *  @param defaultDate  默认显示日期
 */
- (void)showWithDefaultDate:(NSDate *)defaultDate {
    if (defaultDate) { //.date未设置时显示上次日期，未有上次日期显示今天日期
        self.datePicker.date = defaultDate;
    }
    [self __valueChangedAction:self.datePicker];
    
    CGFloat popupViewHeight = CGRectGetHeight(self.frame);
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    __weak typeof(self)weakSelf = self;
    [self cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight blankBGColor:blankBGColor showComplete:^{
        NSLog(@"日期选择:显示完成");
    } tapBlankComplete:^() {
        NSLog(@"日期选择:点击背景完成");
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
    [self __valueChangedAction:self.datePicker]; //及时显示datePicker对应的值
}


- (UIDatePicker *)datePicker {
    if (_datePicker == nil) {
        _datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
        //_datePicker.backgroundColor = [UIColor whiteColor];
        _datePicker.datePickerMode = UIDatePickerModeDate;
        [_datePicker addTarget:self action:@selector(__valueChangedAction:) forControlEvents:UIControlEventValueChanged];
        _datePicker.date = self.defaultDate;
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
    [self __updateSeletedDate:datePicker.date];
    
    if (self.valueChangedHandel) {
        self.valueChangedHandel(datePicker);
    }
}

/// 更新当前选择的日期
- (void)__updateSeletedDate:(NSDate *)seletedDate {
    NSDate *maximumDate = self.datePicker.maximumDate;
    if (maximumDate && [seletedDate compare:maximumDate] == NSOrderedDescending) {
        NSLog(@"当前选择日期太大");
    }
    NSDate *minimumDate = self.datePicker.minimumDate;
    if (minimumDate && [seletedDate compare:minimumDate] == NSOrderedAscending) {
        NSLog(@"当前选择日期太小");
    }
    
    NSTimeZone *zone =[NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:seletedDate];
    NSDate *localDate =[seletedDate dateByAddingTimeInterval:interval];
    NSString *localDateString = [self.dateFormatter stringFromDate:localDate];
    NSLog(@"当前选择日期:%@\n%@", localDate, localDateString);
    
    [self.toolbar updateShowingValue:localDateString];
}

- (void)__cancel {
    if (self.serviceView) {
        [self.serviceView endEditing:YES];
    } else {
        [self cj_hidePopupView];
    }
    
    !self.cancelHandle ?: self.cancelHandle();
}

- (void)__confirm {
    if (self.serviceView) {
        [self.serviceView endEditing:YES];
    } else {
        [self cj_hidePopupView];
    }
    
    NSDate *seletedDate = self.datePicker.date;
    NSTimeZone *zone =[NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:seletedDate];
    NSDate *localDate =[seletedDate dateByAddingTimeInterval:interval];
    NSString *localDateString = [self.dateFormatter stringFromDate:localDate];
    NSLog(@"当前选择日期:%@\n%@", localDate, localDateString);
    !self.confirmHandle ?: self.confirmHandle(seletedDate, localDateString);
}

@end
