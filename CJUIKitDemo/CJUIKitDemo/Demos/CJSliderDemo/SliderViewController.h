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

@interface SliderViewController : UIViewController <CJSliderControlDelegate> {
    
}
@property (nonatomic, weak) IBOutlet CJBaseUISlider *baseSlider;
@property (nonatomic, weak) IBOutlet UILabel *baseSliderValuelabel;

@property (nonatomic, weak) IBOutlet CJPlayerSlider *playerSlider;


@property (nonatomic, weak) IBOutlet CJSliderControl *sliderControl1;
@property (nonatomic, weak) IBOutlet UILabel *sliderControlValueLabel1;


@end
