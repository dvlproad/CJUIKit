//
//  SliderViewController.m
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "SliderViewController.h"
#import "UIImage+CJTransformSize.h"

#import "OperateSliderViewController.h"

@interface SliderViewController ()

@end



@implementation SliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"CJSlider", nil);
    
    [self setupBaseSlier];
    
    
    [self setupPlayerSlider];
    
    
    [self setupSliderControl];

}

#pragma mark - CJBaseSlider
- (void)setupBaseSlier {
    
    CGRect baseSliderFrame = self.baseSlider.frame;
    baseSliderFrame.size.height = 80;
    self.baseSlider.frame = baseSliderFrame;
    self.baseSlider.backgroundColor = [UIColor redColor];
    
    self.baseSlider.minimumValue = -1;
    self.baseSlider.maximumValue = 1;
    self.baseSlider.value = 0;
    
    
    self.baseSlider.adsorbInfos = @[[[CJAdsorbModel alloc] initWithMin:-1 max:0.4 toValue:-1],
                                    [[CJAdsorbModel alloc] initWithMin:0.4 max:1 toValue:1]
                                    ];
    
    self.baseSlider.trackHeight = 40;  

    UIImage *thumbImage = [[UIImage imageNamed:@"bg.jpg"] cj_transformImageToSize:CGSizeMake(80, 80)];
    
    thumbImage = [thumbImage stretchableImageWithLeftCapWidth:1 topCapHeight:0];
    [self.baseSlider setThumbImage:thumbImage forState:UIControlStateNormal];
    
//    self.baseSlider.sliderType = CJSliderTypeRange;
//    self.baseSlider.blankColor = [UIColor greenColor];
//    self.baseSlider.rangeColor = [UIColor cyanColor];
//    self.baseSlider.basePercentValue = 0.7;
    
    
    [self.baseSlider addTarget:self action:@selector(bothwaySliderAction:) forControlEvents:UIControlEventValueChanged];
    
    self.baseSliderValuelabel.text = [NSString stringWithFormat:@"%f", self.baseSlider.value];
}

- (void)bothwaySliderAction:(UISlider *)slider {
    self.baseSliderValuelabel.text = [NSString stringWithFormat:@"%f", slider.value];
}


#pragma mark - CJPlayerSlider
- (void)setupPlayerSlider {
    self.playerSlider.enableTip = YES;
}


- (void)setupSliderControl {
    /* 基于UIControl封装的CJSliderControl */
    self.sliderControl1.minValue = 0.0f;        //设置滑竿的最小值
    self.sliderControl1.maxValue = 100.0f;      //设置滑竿的最大值
    self.sliderControl1.value = 52;
    self.sliderControl1.popoverType = CJSliderPopoverDispalyTypeNum; //设置popover显示的类型,百分比或者纯数字显示
    self.sliderControl1.delegate = self;                             //设置代理对象，用于接收滑竿滑动后值得改变
    self.sliderControl1.mainThumbAlpha = 0.5;
    
    self.sliderControlValueLabel1.text = [NSString stringWithFormat:@"选取的值是: %.1f",self.sliderControl1.value];
    
    
    self.sliderControl2.minValue = 0.0f;
    self.sliderControl2.maxValue = 100.0f;
    self.sliderControl2.popoverType = CJSliderPopoverDispalyTypeNone;
    self.sliderControl2.maximumTrackTintColor = [UIColor colorWithRed:48/255.0 green:119/255.0 blue:162/255.0 alpha:1.0];
    self.sliderControl2.minimumTrackTintColor = [UIColor colorWithRed:255/255.0 green:254/255.0 blue:248/255.0 alpha:1.0];
    self.sliderControl2.baseValue = 40; // 设置基准值
    self.sliderControl2.value = 80;
    self.sliderControl2.trackHeight = 5;  // 设置滑道高度
    self.sliderControl2.leftThumbImage = [UIImage imageNamed:@"slider_double_thumbImage_b"];//设置基准图片
    self.sliderControl2.delegate = self;
    self.sliderControl2.mainThumbAlpha = 0.5;
    self.sliderControl2.leftThumbAlpha = 0.5;
    self.sliderControlValueLabel2.text = [NSString stringWithFormat:@"选取的区间是 : [ %.1f, %.1f ]",self.sliderControl2.baseValue, self.sliderControl2.value];
    
    /*
    CGRect baseSliderFrame = self.sliderControl3.frame;
    baseSliderFrame.size.height = 40;
    self.sliderControl3.frame = baseSliderFrame;
    self.sliderControl3.backgroundColor = [UIColor greenColor];
    */
    self.sliderControl3.thumbCannotBeyongXType = CJSliderControlThumbCannotBeyongXTypeAllX;
    self.sliderControl3.trackHeight = 30;
    self.sliderControl3.mainThumbImage = [[UIImage imageNamed:@"bg.jpg"] cj_transformImageToSize:CGSizeMake(80, 80)];
    self.sliderControl3.adsorbInfos = @[[[CJAdsorbModel alloc] initWithMin:0 max:0.70 toValue:0],
                                        [[CJAdsorbModel alloc] initWithMin:0.71 max:1 toValue:1]];
    
    
    
    /* CJRangeSliderControl */
    self.rangeSliderControl.minValue = 0.0f;    //设置滑竿的最小值
    self.rangeSliderControl.maxValue = 100.0f;  //设置滑竿的最大值
    self.rangeSliderControl.delegate = self;
    
    self.rangeSliderControlValueLabel.text = [NSString stringWithFormat:@"选取的区间是 : [ %.1f, %.1f ]",self.rangeSliderControl.minValue, self.rangeSliderControl.maxValue];
}

- (IBAction)goOperateSliderViewController:(id)sender {
    OperateSliderViewController *viewController = [[OperateSliderViewController alloc] initWithNibName:@"OperateSliderViewController" bundle:nil];
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark - CJSliderControlDelegate
- (void)slider:(CJSliderControl *)slider didDargToValue:(CGFloat)value {
    NSLog(@"slider value is %1.2f",value);
    if (slider == self.sliderControl1) {
        self.sliderControlValueLabel1.text = [NSString stringWithFormat:@"选取的值是: %.1f", value];
    } else if (slider == self.sliderControl2) {
        self.sliderControlValueLabel2.text = [NSString stringWithFormat:@"选取的区间是 : [ %.1f, %.1f ]",self.sliderControl2.baseValue, self.sliderControl2.value];
    }
}


#pragma mark - CJRangeSliderControlDelegate
- (void)rangeSlider:(CJRangeSliderControl *)slider didChangedMinValue:(CGFloat)minValue didChangedMaxValue:(CGFloat)maxValue {
    NSLog(@"rangeSlider rangion:%f,%f",minValue,maxValue);
    
    self.rangeSliderControlValueLabel.text = [NSString stringWithFormat:@"选取的区间是 : [ %.1f, %.1f ]",minValue,maxValue];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
