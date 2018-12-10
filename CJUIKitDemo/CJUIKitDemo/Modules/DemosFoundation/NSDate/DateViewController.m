//
//  DateViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DateViewController.h"

#import "NSDateFormatterCJHelper.h"
#import "NSCalendarCJHelper.h"

#import "CJChooseTextTextField.h"

#import <CJPicker/CJDefaultDatePicker.h>
#import "UIView+CJShowExtendView.h"

#import "CJDefaultToolbar.h"



@interface DateViewController () {
    
}
@property (nonatomic, strong) CJChooseTextTextField *dateTextField;
@property (nonatomic) NSDate *currentDate;

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
    
    [self setupChooseDatePicker];
    
    self.currentDate = [NSDate date];

    NSString *currentDateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:self.currentDate];
    self.dateTextField.text = currentDateString;
    
    NSDate *birthdayDate = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_dateFromString:@"1989-12-27 01:10:22"];
    
    NSInteger yearInterval = NSCalendarCJHelper_yearInterval(birthdayDate, [NSDate date]);
    NSInteger age = NSCalendarCJHelper_age(birthdayDate);
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
    NSString *dateString = [dateFormatter stringFromDate:self.currentDate];
//    self.resultCurrentTime1.text = [dateFormatter stringFromDate:date];
    NSLog(@"date convert to string = %@", dateString);
}

- (IBAction)getStringFromDate2:(id)sender {
    
}

- (void)setupChooseDatePicker {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    self.dateTextField = [[CJChooseTextTextField alloc] initWithFrame:CGRectZero];
//    self.dateTextField.hideCursor = YES;
    self.dateTextField.hideMenuController = YES;
    
    __weak typeof(self)weakSelf = self;
    UIImage *leftNormalImage = [UIImage imageNamed:@"plus"];
    UIButton *leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftButton setImage:leftNormalImage forState:UIControlStateNormal];
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [leftButton setFrame:CGRectMake(0, 0, 30, 30)];
    self.dateTextField.leftView = leftButton;
    self.dateTextField.leftViewMode = UITextFieldViewModeAlways;
    self.dateTextField.leftViewLeftOffset = 0;
    self.dateTextField.leftViewRightOffset = 0;
    
    UIImage *rightNormalImage = [UIImage imageNamed:@"plus"];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:rightNormalImage forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [rightButton setFrame:CGRectMake(0, 0, 30, 30)];
    self.dateTextField.rightView = rightButton;
    self.dateTextField.rightViewMode = UITextFieldViewModeAlways;
    self.dateTextField.rightViewLeftOffset = 0;
    self.dateTextField.rightViewRightOffset = 0;
    
    
    CJDefaultDatePicker *datePicker = [[CJDefaultDatePicker alloc] init];
    CJDefaultToolbar *toolbar = [[CJDefaultToolbar alloc] initWithFrame:CGRectZero];
    [datePicker addToolbar:toolbar];
    
    datePicker.datePicker.datePickerMode = UIDatePickerModeDate;
    __weak typeof(datePicker)weakdatePicker = datePicker;
    [toolbar setConfirmHandle:^{
        [weakSelf hideDateChoosePicker];
        
        NSDate *date = weakdatePicker.datePicker.date ;
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        self.dateTextField.text = dateString;
    }];
    /*
    [datePicker setValueChangedHandel:^(UIDatePicker *datePicker) {
        [weakSelf hideDateChoosePicker];
        NSDate *date = datePicker.date ;
        NSString *dateString = [dateFormatter stringFromDate:date];
        
        self.dateTextField.text = dateString;
    }];
    */
    self.dateTextField.inputView = datePicker;
    
    [self.dateTextField setFrame:CGRectMake(20, 100, 280, 30)];
    [self.view addSubview:self.dateTextField];
}

- (void)leftButtonAction:(UIButton *)button {
    NSLog(@"左边按钮点击");
    [self hideDateChoosePicker];
    
    NSDate *date = NSCalendarCJHelper_yesterday(self.currentDate);
    NSString *dateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:date];
    self.dateTextField.text = dateString;
    
    self.currentDate = date;
}

- (void)rightButtonAction:(UIButton *)button {
    NSLog(@"右边按钮点击");
    [self hideDateChoosePicker];
    
    NSDate *date = NSCalendarCJHelper_tomorrow(self.currentDate);
    NSString *dateString = [[NSDateFormatterCJHelper sharedInstance] yyyyMMddHHmmss_stringFromDate:date];
    self.dateTextField.text = dateString;
    
    self.currentDate = date;
}


- (void)hideDateChoosePicker {
    [self.dateTextField endEditing:YES];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    
    [self hideDateChoosePicker];
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
