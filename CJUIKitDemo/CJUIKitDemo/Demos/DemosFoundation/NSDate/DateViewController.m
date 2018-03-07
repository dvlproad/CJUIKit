//
//  DateViewController.m
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DateViewController.h"

#import "UITextField+CJAddLeftRightView.h"
#import "CJChooseTextTextField.h"

#import <CJPicker/CJDefaultDatePicker.h>
#import <CJPopupAction/UIView+CJShowExtendView.h>

#import "CJDefaultToolbar.h"

#import "CJCalendarUtil.h"

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
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    self.dateTextField.text = [dateFormatter stringFromDate:self.currentDate];
    
    NSDate *birthdayDate = [dateFormatter dateFromString:@"1989-12-27 01:10:22"];
    
    NSInteger yearInterval = [CJCalendarUtil year_unitIntervalFromDate:birthdayDate toDate:[NSDate date]];
    NSInteger age = [CJCalendarUtil age_unitIntervalFromDate:birthdayDate toDate:[NSDate date]];
    NSLog(@"今年周岁为：%ld, %ld", yearInterval, age);
    
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
    
    [self.dateTextField cj_addLeftButton:leftButton withSize:CGSizeMake(30, 30) leftOffset:0 rightOffset:0 leftHandel:^(UITextField *textField) {
        [weakSelf hideDateChoosePicker];
        
        NSDate *date = [CJCalendarUtil yesterday_dateFromSinceDate:weakSelf.currentDate];
        textField.text = [dateFormatter stringFromDate:date];
        
        weakSelf.currentDate = date;
    }];
    
    UIImage *rightNormalImage = [UIImage imageNamed:@"plus"];
    UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightButton setImage:rightNormalImage forState:UIControlStateNormal];
    
    [self.dateTextField cj_addRightButton:rightButton withSize:CGSizeMake(30, 30) rightOffset:0 leftOffset:0 rightHandle:^(UITextField *textField) {
        [weakSelf hideDateChoosePicker];
        
        NSDate *date = [CJCalendarUtil tomorrow_dateFromSinceDate:weakSelf.currentDate];
        textField.text = [dateFormatter stringFromDate:date];
        
        weakSelf.currentDate = date;
    }];
    
    
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
