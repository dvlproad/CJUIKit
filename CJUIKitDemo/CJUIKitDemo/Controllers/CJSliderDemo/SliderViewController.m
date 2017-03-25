//
//  SliderViewController.m
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "SliderViewController.h"
#import "CJSliderControl.h"
#import "CJRangeSliderControl.h"


static CGFloat kCJSliderControlHeight      = 70.0f;
static CGFloat kCJSliderControlMinValue    = 0.0f;
static CGFloat kCJSliderControlMaxValue    = 100.0f;

@interface SliderViewController () <
    CJSliderControlDelegate,
    CJRangeSliderControlDelegate>

@property (nonatomic, strong) UILabel *sliderValueLabel;

@property (nonatomic, strong) UILabel *rangSliderValueLabel;

@end

@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    self.title = NSLocalizedString(@"CJSlider", nil);
    
    /* CJBaseSlider */
    self.baseSlider.minimumValue = -1;
    self.baseSlider.maximumValue = 1;
    self.baseSlider.value = 0;
    self.baseSlider.blankColor = [UIColor greenColor];
    self.baseSlider.rangeColor = [UIColor redColor];
    self.baseSlider.baseValue = 0.7;
    self.baseSlider.adsorbInfo = [[CJAdsorbModel alloc] initWithMin:0.8 max:0.9 toValue:1];
    
    [self.baseSlider addTarget:self action:@selector(bothwaySliderAction:) forControlEvents:UIControlEventValueChanged];
    
    self.label.text = [NSString stringWithFormat:@"%f", self.baseSlider.value];
    
    /* CJPlayerSlider */
    self.playerSlider.enableTip = YES;
    
    
    /* CJSliderControl */
    CGFloat sliderWidth = CGRectGetWidth(self.view.bounds) - 40;
    CJSliderControl *slider = [[CJSliderControl alloc] initWithFrame:CGRectMake(20, 100, sliderWidth, kCJSliderControlHeight)];
    slider.minValue = kCJSliderControlMinValue;                //设置滑竿的最小值
    slider.maxValue = kCJSliderControlMaxValue;                //设置滑竿的最大值
    slider.popoverType = CJSliderPopoverDispalyTypeNum; //设置popover显示的类型,百分比或者纯数字显示
    slider.delegate = self;                             //设置代理对象，用于接收滑竿滑动后值得改变
    [self.view addSubview:slider];
    
    _sliderValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(slider.frame.origin.x, slider.frame.origin.y + kCJSliderControlHeight, 250, 40)];
    _sliderValueLabel.font = [UIFont systemFontOfSize:13.0f];
    _sliderValueLabel.text = [NSString stringWithFormat:@"选取的值是: %.1f",slider.minValue];
    [self.view addSubview:_sliderValueLabel];
    
    
    CJSliderControl *slider2 = [[CJSliderControl alloc] initWithFrame:CGRectMake(20, 220, sliderWidth, kCJSliderControlHeight)];
    slider2.minValue = kCJSliderControlMinValue;
    slider2.maxValue = kCJSliderControlMaxValue;
    slider2.maximumTrackTintColor = [UIColor colorWithRed:48/255.0 green:119/255.0 blue:162/255.0 alpha:1.0];
    slider2.minimumTrackTintColor = [UIColor colorWithRed:255/255.0 green:254/255.0 blue:248/255.0 alpha:1.0];
    slider2.baseValue = 0.5; // 设置基准值
    slider2.lineThick = 5;  // 设置线条粗细
    slider2.baseImage = [UIImage imageNamed:@"slider_double_thumbImage_b"];//设置基准图片
    slider2.delegate = self;
    [self.view addSubview:slider2];
    
    /* CJRangeSliderControl */
    CJRangeSliderControl *rangeSlider = [[CJRangeSliderControl alloc] initWithFrame:CGRectMake(20, 420, sliderWidth, kCJSliderControlHeight)];
    rangeSlider.minValue = kCJSliderControlMinValue;   //设置滑竿的最小值
    rangeSlider.maxValue = kCJSliderControlMaxValue;   //设置滑竿的最大值
    rangeSlider.delegate = self;                //设置滑竿的最大值
    [self.view addSubview:rangeSlider];
    
    
    
    _rangSliderValueLabel = [[UILabel alloc] initWithFrame:CGRectMake(rangeSlider.frame.origin.x, rangeSlider.frame.origin.y + kCJSliderControlHeight, 250, 40)];
    _rangSliderValueLabel.font = [UIFont systemFontOfSize:13.0f];
    _rangSliderValueLabel.text = [NSString stringWithFormat:@"选取的区间是 : [ %.1f, %.1f ]",rangeSlider.minValue,rangeSlider.maxValue];
    [self.view addSubview:_rangSliderValueLabel];

}

- (void)bothwaySliderAction:(UISlider *)slider {
    self.label.text = [NSString stringWithFormat:@"%f", slider.value];
}


#pragma mark - CJSliderControlDelegate

-(void)slider:(CJSliderControl *)slider didDargToValue:(CGFloat)value {
    
    NSLog(@"slider value is %1.0f",value);
    
    _sliderValueLabel.text = [NSString stringWithFormat:@"选取的值是: %.1f",value];
}


#pragma mark - CJRangeSliderControlDelegate

- (void)rangeSlider:(CJRangeSliderControl *)slider didChangedMinValue:(CGFloat)minValue didChangedMaxValue:(CGFloat)maxValue {
    
    NSLog(@"rangeSlider rangion:%f,%f",minValue,maxValue);
    
    _rangSliderValueLabel.text = [NSString stringWithFormat:@"选取的区间是 : [ %.1f, %.1f ]",minValue,maxValue];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
