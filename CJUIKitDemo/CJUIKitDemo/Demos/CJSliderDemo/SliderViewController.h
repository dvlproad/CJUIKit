//
//  SliderViewController.h
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJBaseUISlider.h"
#import "CJPlayerSlider.h"

#import "CJSliderControl.h"
#import "CJRangeSliderControl.h"

@interface SliderViewController : UIViewController <CJSliderControlDelegate, CJRangeSliderControlDelegate> {
    
}
@property (nonatomic, weak) IBOutlet CJBaseUISlider *baseSlider;
@property (nonatomic, weak) IBOutlet UILabel *baseSliderValuelabel;

@property (nonatomic, weak) IBOutlet CJPlayerSlider *playerSlider;


@property (nonatomic, weak) IBOutlet CJSliderControl *sliderControl1;
@property (nonatomic, weak) IBOutlet UILabel *sliderControlValueLabel1;

@property (nonatomic, weak) IBOutlet CJSliderControl *sliderControl2;
@property (nonatomic, weak) IBOutlet UILabel *sliderControlValueLabel2;

@property (nonatomic, weak) IBOutlet CJSliderControl *sliderControl3;
@property (nonatomic, weak) IBOutlet UILabel *sliderControlValueLabel3;

@property (nonatomic, weak) IBOutlet CJSliderControl *rangeSliderControl;
@property (nonatomic, weak) IBOutlet UILabel *rangeSliderControlValueLabel;


@end
