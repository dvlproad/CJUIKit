//
//  CJLogSuspendWindow.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#ifdef CJTESTPOD
#import "UIView+CJDragAction.h"
#import "UIView+CJKeepBounds.h"
#else
#import <CJBaseUIKit/UIView+CJDragAction.h>
#import <CJBaseUIKit/UIView+CJKeepBounds.h>
#endif

#import "CJLogViewWindow.h"

/**
 *  用于控制log视图的弹出与隐藏的悬浮球
 */
@interface CJLogSuspendWindow : UIWindow {
    
}
@property(nonatomic, copy) NSString *windowIdentifier;
@property (nonatomic, copy) void (^clickWindowBlock)(UIButton *clickButton);
@property (nonatomic, copy) void (^closeWindowBlock)(void);

///显示
+ (void)showWithFrame:(CGRect)frame;

///移除
+ (void)removeFromScreen;

@end
