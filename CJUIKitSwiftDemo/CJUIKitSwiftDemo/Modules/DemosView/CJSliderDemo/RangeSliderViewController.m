//
//  RangeSliderViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/9.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "RangeSliderViewController.h"

@interface RangeSliderViewController ()

@end

@implementation RangeSliderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"RangeSliderViewController", nil);
    
    [self.sliderControl2 setupViewWithCreateTrackViewBlock:nil
                               createMinimumTrackViewBlock:nil
                               createMaximumTrackViewBlock:nil];
    [self.sliderControl2.trackView setBackgroundColor:[UIColor redColor]];
    [self.sliderControl2.minimumTrackView setBackgroundColor:[UIColor yellowColor]];
    [self.sliderControl2.maximumTrackView setBackgroundColor:[UIColor redColor]];
    self.sliderControl2.baseValue = 40; // 设置基准值
    self.sliderControl2.minValue = 0.0f;
    self.sliderControl2.maxValue = 100.0f;
    self.sliderControl2.value = 80;
    self.sliderControl2.trackHeight = 5;  // 设置滑道高度
    self.sliderControl2.delegate = self;
    self.sliderControlValueLabel2.text = [NSString stringWithFormat:@"选取的区间是 : [ %.1f, %.1f ]",self.sliderControl2.baseValue, self.sliderControl2.value];
    
    self.sliderControl2.sliderType = CJSliderTypeRange;
//    self.sliderControl2.thumbSize = CGSizeMake(50, 36);
//    self.sliderControl2.thumbMoveMinXMargin = -self.sliderControl2.thumbSize.width/2;
//    self.sliderControl2.thumbMoveMaxXMargin = -self.sliderControl2.thumbSize.width/2;
    UIImage *normalImage = [UIImage imageNamed:@"slider_double_thumbImage_b"];
    UIImage *highlightedImage = [UIImage imageNamed:@"slider_double_thumbImage_a"];
    [self.sliderControl2.mainThumb setImage:normalImage forState:UIControlStateNormal];
    [self.sliderControl2.mainThumb setImage:highlightedImage forState:UIControlStateHighlighted];
    self.sliderControl2.mainThumb.alpha = 0.5;
    [self.sliderControl2.leftThumb setImage:normalImage forState:UIControlStateNormal];
    [self.sliderControl2.leftThumb setImage:highlightedImage forState:UIControlStateHighlighted];
    self.sliderControl2.leftThumb.alpha = 0.5;
    
    self.sliderControl2.popoverType = CJSliderPopoverDispalyTypeNum;

    
    
    /* CJRangeSliderControl */
    self.rangeSliderControl.minValue = 0.0f;    //设置滑竿的最小值
    self.rangeSliderControl.maxValue = 100.0f;  //设置滑竿的最大值
    self.rangeSliderControl.delegate = self;
    
    self.rangeSliderControlValueLabel.text = [NSString stringWithFormat:@"选取的区间是 : [ %.1f, %.1f ]",self.rangeSliderControl.minValue, self.rangeSliderControl.maxValue];
}

#pragma mark - CJSliderControlDelegate
- (void)slider:(CJSliderControl *)slider didDargToValue:(CGFloat)value {
    NSLog(@"slider value is %1.2f",value);
    if (slider == self.sliderControl2) {
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
