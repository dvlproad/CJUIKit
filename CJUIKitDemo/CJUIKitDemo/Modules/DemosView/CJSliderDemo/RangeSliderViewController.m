//
//  RangeSliderViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/9.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "RangeSliderViewController.h"
#import "TSSliderFactory.h"

#import "DemoLabelFactory.h"

@interface RangeSliderViewController ()<CJRangeSliderControlDelegate> {
    
}
@property (nonatomic, strong) TSRangeSliderControl1 *sliderControl2;
@property (nonatomic, strong) UILabel *sliderControlValueLabel2;

@property (nonatomic, strong) CJRangeSliderControl *rangeSliderControl;
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
        make.top.mas_equalTo(sliderControlValueLabel2.mas_bottom).mas_offset(20);
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
    
    
    CJRangeSliderControl *rangeSliderControl = [[CJRangeSliderControl alloc] initWithFrame:CGRectZero];
    rangeSliderControl.minValue = 0.0f;    //设置滑竿的最小值
    rangeSliderControl.maxValue = 100.0f;  //设置滑竿的最大值
    rangeSliderControl.delegate = self;
    [self.view addSubview:rangeSliderControl];
    [rangeSliderControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(rangeSliderControlValueLabel);
        make.top.mas_equalTo(rangeSliderControlValueLabel.mas_bottom).mas_offset(20);
        make.height.mas_equalTo(30);
    }];
    self.rangeSliderControl = rangeSliderControl;
}


#pragma mark - CJRangeSliderControlDelegate
- (void)rangeSlider:(CJRangeSliderControl *)slider didChangedMinValue:(CGFloat)minValue didChangedMaxValue:(CGFloat)maxValue {
    NSLog(@"rangeSlider rangion:%f,%f",minValue,maxValue);
    
    self.rangeSliderControlValueLabel.text = [NSString stringWithFormat:@"选取的区间是 : [ %.1f, %.1f ]",minValue,maxValue];
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
