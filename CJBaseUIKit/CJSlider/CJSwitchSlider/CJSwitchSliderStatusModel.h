//
//  CJSwitchSliderStatusModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/6/26.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CJSwitchSliderStatusModel : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) UIColor *dragingColor;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, assign) BOOL goNextStepWhenSwitchEventOccur;   /**< 已默认初始化为YES(只对非最后一步有效) */

@end
