//
//  OperateSliderViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShimmeringSwitchSlider.h"

@interface OperateSliderViewController : UIViewController

@property (nonatomic, strong) IBOutlet CJSwitchSlider *switchSlider;
@property (nonatomic, strong) IBOutlet ShimmeringSwitchSlider *shimmeringSwitchSlider;
@property (nonatomic, strong) IBOutlet UILabel *operateSliderControlValueLabel;

@end
