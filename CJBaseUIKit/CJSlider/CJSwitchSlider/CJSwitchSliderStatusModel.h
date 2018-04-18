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

//normalState
@property (nonatomic, strong) UIImage *normalImage;
@property (nonatomic, copy) NSString *normalText;
@property (nonatomic, strong) UIColor *normalColor;

//dragingState
@property (nonatomic, strong) UIImage *dragingImage;
@property (nonatomic, copy) NSString *dragingText;
@property (nonatomic, strong) UIColor *dragingColor;
//@property (nonatomic, assign) BOOL useDragingStatusWhenDraging; /**< 当移动的时候是否使用移动的样式(注：移动时候，又移动回初始0的时候这个位置算为不是移动状态) */


@property (nonatomic, assign) BOOL goNextStepWhenSwitchEventOccur;   /**< 已默认初始化为YES(只对非最后一步有效) */

@end
