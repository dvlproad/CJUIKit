//
//  DemoSuspendWindow.h
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


/**
 *  用于弹出log视图的悬浮球
 */
@interface DemoSuspendWindow : UIWindow {
    
}
@property(nonatomic, copy) NSString *windowIdentifier;
@property (nonatomic, copy) void (^clickWindowBlock)(UIButton *clickButton);
@property (nonatomic, copy) void (^closeWindowBlock)(void);

- (void)removeFromScreen;

@end
