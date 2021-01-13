//
//  RangeSliderViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/9.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "RangeSliderViewController.h"
#import "TSRangeSliderControl1.h"
#import "TSRangeSliderControl2.h"
#import "CQAgeRangeSliderControl.h"

#import "DemoLabelFactory.h"

@interface RangeSliderViewController () {
    
}
@property (nonatomic, strong) TSRangeSliderControl1 *sliderControl2;
@property (nonatomic, strong) UILabel *sliderControlValueLabel2;

@property (nonatomic, strong) TSRangeSliderControl2 *rangeSliderControl;
@property (nonatomic, strong) UILabel *rangeSliderControlValueLabel;

@end

@implementation RangeSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"RangeSliderViewController", nil);
    
    [self setupViews];
    
    self.sliderControlValueLabel2.text = [NSString stringWithFormat:@"选取的区间是 : [ %.1f, %.1f ]", self.sliderControl2.baseValue, self.sliderControl2.value];
    self.rangeSliderControlValueLabel.text = [NSString stringWithFormat:@"选取的区间是 : [ %.1f, %.1f ]",self.rangeSliderControl.minValue, self.rangeSliderControl.maxValue];
}

- (void)setupViews {
    self.view.backgroundColor = [UIColor lightGrayColor];
    
    UILabel *sliderControlValueLabel2 = [DemoLabelFactory testExplainLabel];
    [self.view addSubview:sliderControlValueLabel2];
    [sliderControlValueLabel2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.mas_topLayoutGuide).offset(20);
        make.height.equalTo(@29);
    }];
    self.sliderControlValueLabel2 = sliderControlValueLabel2;
    
    TSRangeSliderControl1 *sliderControl2 = [[TSRangeSliderControl1 alloc] initWithChooseCompleteBlock:^(CGFloat minValue, CGFloat maxValue) {
        self.sliderControlValueLabel2.text = [NSString stringWithFormat:@"选取的区间是 : [ %.1f, %.1f ]", minValue, maxValue];
    }];
    [self.view addSubview:sliderControl2];
    [sliderControl2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(sliderControlValueLabel2);
        make.top.mas_equalTo(sliderControlValueLabel2.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(29);
    }];
    self.sliderControl2 = sliderControl2;
    
    
    
    
    /* CJRangeSliderControl */
    UILabel *rangeSliderControlValueLabel = [DemoLabelFactory testExplainLabel];
    [self.view addSubview:rangeSliderControlValueLabel];
    [rangeSliderControlValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.sliderControl2.mas_bottom).offset(100);
        make.height.equalTo(@20);
    }];
    self.rangeSliderControlValueLabel = rangeSliderControlValueLabel;
    
    
    TSRangeSliderControl2 *rangeSliderControl = [[TSRangeSliderControl2 alloc] initWithMinRangeValue:0.0 maxRangeValue:100.0 startRangeValue:20.5 endRangeValue:70.8 chooseCompleteBlock:^(CGFloat minValue, CGFloat maxValue) {
        self.rangeSliderControlValueLabel.text = [NSString stringWithFormat:@"选取的区间是 : [ %.1f, %.1f ]",minValue,maxValue];
    }];
    [self.view addSubview:rangeSliderControl];
    [rangeSliderControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(rangeSliderControlValueLabel);
        make.top.mas_equalTo(rangeSliderControlValueLabel.mas_bottom).mas_offset(30);
        make.height.mas_equalTo(30);
    }];
    self.rangeSliderControl = rangeSliderControl;
    
    
    /* 年龄区间选择 */
    UILabel *ageRangeSliderValueLabel = [DemoLabelFactory testExplainLabel];
    ageRangeSliderValueLabel.text = [NSString stringWithFormat:@"选取的区间是 :\n请验证第一次滑动某个滑块后，另一个滑块上的值不会改变"];
    [self.view addSubview:ageRangeSliderValueLabel];
    [ageRangeSliderValueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(30);
        make.centerX.equalTo(self.view);
        make.top.equalTo(rangeSliderControl.mas_bottom).offset(100);
    }];
    
    CQAgeRangeSliderControl *ageRangeSlider = [[CQAgeRangeSliderControl alloc] initWithMinRangeAge:0 maxRangeAge:100 startRangeAge:18 endRangeAge:32 chooseCompleteBlock:^(NSInteger minAge, NSInteger maxAge) {
        ageRangeSliderValueLabel.text = [NSString stringWithFormat:@"选取的区间是 : [ %zd, %zd ]\n请验证第一次滑动某个滑块后，另一个滑块上的值不会改变",minAge,maxAge];
        
    }];
    [self.view addSubview:ageRangeSlider];
    [ageRangeSlider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(ageRangeSliderValueLabel);
        make.top.mas_equalTo(ageRangeSliderValueLabel.mas_bottom).mas_offset(50);
        make.height.mas_equalTo(30);
    }];
    NSInteger startRangeAge = ageRangeSlider.startRangeAge;
    NSInteger endRangeAge = ageRangeSlider.endRangeAge;
    ageRangeSliderValueLabel.text = [NSString stringWithFormat:@"选取的区间是 : [ %zd, %zd ]\n请验证第一次滑动某个滑块后，另一个滑块上的值不会改变",startRangeAge,endRangeAge];
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
