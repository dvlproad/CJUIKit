//
//  DateViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DateViewController.h"
#import <IQKeyboardManager/IQKeyboardManager.h>
#import "CJDemoDateTextField.h"
#import "CJDemoDateLabel.h"

#import "NSDateFormatterCJHelper.h"
#import "NSCalendarCJHelper.h"

#import "CJDefaultToolbar.h"
#import "CJDemoDatePickerView.h"



@interface DateViewController () {
    
}
@property (nonatomic, strong) CJDemoDateTextField *shortDateTextField;
@property (nonatomic, strong) CJDemoDateTextField *longDateTextField;
@property (nonatomic) NSDate *currentTFDate;

@property (nonatomic, strong) CJDemoDateLabel *dateLabel;
@property (nonatomic) NSDate *currentLabelDate;

@property (nonatomic, weak) IBOutlet UILabel *originCurrentTime1;
@property (nonatomic, weak) IBOutlet UISwitch *correctConvertSwitch1;
@property (nonatomic, weak) IBOutlet UILabel *resultCurrentTime1;

@property (nonatomic, weak) IBOutlet UILabel *originCurrentTime2;
@property (nonatomic, weak) IBOutlet UISwitch *correctConvertSwitch2;
@property (nonatomic, weak) IBOutlet UILabel *resultCurrentTime2;

@end

@implementation DateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationItem.title = NSLocalizedString(@"日期字符串", nil);
    
    [[[IQKeyboardManager sharedManager] disabledToolbarClasses] addObject:[self class]];
    
    NSDate *defaultDate = [[NSDateFormatterCJHelper sharedInstance] yyyyMMdd_dateFromString:@"2018-09-27"];
    self.currentTFDate = defaultDate;
    
    [self setupViews];
    
    NSDate *birthdayDate = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_dateFromString:@"1989-12-27 01:10:22"];
    NSInteger yearInterval = NSCalendarCJHelper_yearInterval(birthdayDate, [NSDate date]);
    NSInteger age = NSCalendarCJHelper_age(birthdayDate, NO);
    NSLog(@"今年周岁为：%zd, %zd", yearInterval, age);
}

//参考：http://blog.sina.com.cn/s/blog_708663ad0102wf1z.html
- (IBAction)getStringFromDate1:(id)sender {
    NSLog(@"-------------------------------------------");
    NSString *currentTime = self.originCurrentTime1.text; //2017-04-17 20:20:08
    NSLog(@"originDateString       = %@", currentTime);
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    
    if (self.correctConvertSwitch1.isOn) {
        [dateFormatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]]; //解决NSString转NSDate差8小时的问题
    }
    
    //①string转换为date少了8个小时，加上UTC后，正常
    NSDate *date = [dateFormatter dateFromString:currentTime];
    NSLog(@"after convert to date  = %@", date);//错误时候为2017-04-17 12:20:08 +0000，即少了8个小时
    
    self.resultCurrentTime1.text = [dateFormatter stringFromDate:date];
    
    //②date转换为string又多了8个小时
    NSDateFormatter *dateFormatter2 = [[NSDateFormatter alloc]init];
    [dateFormatter2 setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter2 setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    NSString *dateString = [dateFormatter stringFromDate:self.currentTFDate];
//    self.resultCurrentTime1.text = [dateFormatter stringFromDate:date];
    NSLog(@"date convert to string = %@", dateString);
}

- (IBAction)getStringFromDate2:(id)sender {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self.shortDateTextField endEditing:YES];
    [self.longDateTextField endEditing:YES];
}

#pragma mark - SetupViews & Lazy
- (void)setupViews {
    [self.view addSubview:self.shortDateTextField];
    [self.shortDateTextField setFrame:CGRectMake(20, 100, 180, 30)];
    
    [self.view addSubview:self.longDateTextField];
    [self.longDateTextField setFrame:CGRectMake(20, 150, 280, 30)];
    
    [self.view addSubview:self.dateLabel];
    [self.dateLabel setFrame:CGRectMake(20, 200, 180, 30)];
}

- (CJDemoDateTextField *)shortDateTextField {
    if (_shortDateTextField == nil) {
        __weak typeof(self)weakSelf = self;
        _shortDateTextField = [[CJDemoDateTextField alloc] initWithConfirmCompleteBlock:^(NSDate * _Nonnull seletedDate, NSString * _Nonnull seletedDateString) {
            weakSelf.currentTFDate = seletedDate;
        }];
        _shortDateTextField.placeholder = NSLocalizedString(@"选择日期", nil);
        _shortDateTextField.backgroundColor = [UIColor greenColor];
        _shortDateTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
        
        NSString *dateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMdd_stringFromDate:self.currentTFDate];
        [_shortDateTextField updateTextFieldAndDatePickerWithDateString:dateString];
    }
    return _shortDateTextField;
}

- (CJDemoDateTextField *)longDateTextField {
    if (_longDateTextField == nil) {
        __weak typeof(self)weakSelf = self;
        _longDateTextField = [[CJDemoDateTextField alloc] initWithConfirmCompleteBlock:^(NSDate * _Nonnull seletedDate, NSString * _Nonnull seletedDateString) {
            weakSelf.currentTFDate = seletedDate;
        }];
        _longDateTextField.placeholder = NSLocalizedString(@"选择日期", nil);
        _longDateTextField.backgroundColor = [UIColor greenColor];
        _longDateTextField.clearButtonMode = UITextFieldViewModeUnlessEditing;
    }
    return _longDateTextField;
}

- (CJDemoDateLabel *)dateLabel {
    if (_dateLabel == nil) {
        __weak typeof(self)weakSelf = self;
        _dateLabel = [[CJDemoDateLabel alloc] initWithDefaultDate:self.currentLabelDate confirmCompleteBlock:^(NSDate * _Nonnull seletedDate, NSString * _Nonnull seletedDateString) {
            weakSelf.currentLabelDate = seletedDate;
        }];
        _dateLabel.placeholder = NSLocalizedString(@"选择日期", nil);
        _dateLabel.backgroundColor = [UIColor greenColor];
    }
    return _dateLabel;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
