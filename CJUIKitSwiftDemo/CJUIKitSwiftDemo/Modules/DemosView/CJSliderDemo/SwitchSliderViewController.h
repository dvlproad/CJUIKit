//
//  SwitchSliderViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShimmeringSwitchSlider.h"

@interface SwitchSliderViewController : UIViewController <CJSliderControlDelegate> {
    
}
@property (nonatomic, weak) IBOutlet CJSliderControl *sliderControl3;
@property (nonatomic, weak) IBOutlet UILabel *sliderControlValueLabel3;


@property (nonatomic, strong) IBOutlet CJSwitchSlider *switchSlider;
@property (nonatomic, strong) IBOutlet UILabel *switchSliderControlValueLabel;

@property (nonatomic, strong) IBOutlet ShimmeringSwitchSlider *shimmeringSwitchSlider1;
@property (nonatomic, strong) IBOutlet ShimmeringSwitchSlider *shimmeringSwitchSlider2;
@property (nonatomic, strong) IBOutlet ShimmeringSwitchSlider *shimmeringSwitchSlider3;

@end
