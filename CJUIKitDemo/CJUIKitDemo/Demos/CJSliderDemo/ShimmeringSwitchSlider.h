//
//  ShimmeringSwitchSlider.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CJSwitchSlider.h"
#import <Shimmer/FBShimmeringView.h>
#import <Shimmer/FBShimmeringLayer.h>

@interface ShimmeringSwitchSlider : FBShimmeringView

@property (nonatomic, strong) IBOutlet CJSwitchSlider *switchSlider;

@end
