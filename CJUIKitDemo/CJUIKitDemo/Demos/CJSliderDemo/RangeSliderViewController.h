//
//  RangeSliderViewController.h
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/7/9.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJSliderControl.h"
#import "CJRangeSliderControl.h"

@interface RangeSliderViewController : UIViewController <CJSliderControlDelegate, CJRangeSliderControlDelegate>

@property (nonatomic, weak) IBOutlet CJSliderControl *sliderControl2;
@property (nonatomic, weak) IBOutlet UILabel *sliderControlValueLabel2;

@property (nonatomic, weak) IBOutlet CJRangeSliderControl *rangeSliderControl;
@property (nonatomic, weak) IBOutlet UILabel *rangeSliderControlValueLabel;

@end
