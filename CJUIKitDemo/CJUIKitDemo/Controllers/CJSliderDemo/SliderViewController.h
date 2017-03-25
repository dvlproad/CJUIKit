//
//  SliderViewController.h
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJBaseSlider.h"
#import "CJPlayerSlider.h"

@interface SliderViewController : UIViewController

@property (nonatomic, weak) IBOutlet CJBaseSlider *baseSlider;
@property (nonatomic, weak) IBOutlet CJPlayerSlider *playerSlider;
@property (nonatomic, weak) IBOutlet UILabel *label;

@end
