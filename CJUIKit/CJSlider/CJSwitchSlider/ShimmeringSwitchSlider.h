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

//#import "OrderListModel.h"

@interface ShimmeringSwitchSlider : FBShimmeringView

@property (nonatomic, strong) IBOutlet CJSwitchSlider *switchSlider;

//@property (nonatomic, strong) OrderListModel *model;
@property (nonatomic, assign) NSIndexPath *indexPath;

@property (nonatomic, assign) NSInteger stautsValue;

- (void)initSwitchSlider;

@end
