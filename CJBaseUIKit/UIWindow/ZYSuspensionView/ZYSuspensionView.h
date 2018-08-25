//
//  ZYSuspensionView.h
//  ZYSuspensionView
//
//  GitHub https://github.com/ripperhe
//  Created by ripper on 16-02-25.
//  Copyright (c) 2016年 ripper. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CJSuspendWindow.h"
#import "CJSuspendRootViewController.h"

@class ZYSuspensionView;
@protocol ZYSuspensionViewDelegate <NSObject>
/** callback for click on the ZYSuspensionView */
- (void)suspensionViewClick:(ZYSuspensionView *)suspensionView;
@end



typedef NS_ENUM(NSUInteger, ZYSuspensionViewLeanType) {
    /** Can only stay in the left and right */
    ZYSuspensionViewLeanTypeHorizontal,
    /** Can stay in the upper, lower, left, right */
    ZYSuspensionViewLeanTypeEachSide
};

@interface ZYSuspensionView : UIButton

/** delegate */
@property (nonatomic, weak) id<ZYSuspensionViewDelegate> delegate;
/** lean type, default is ZYSuspensionViewLeanTypeHorizontal */
@property (nonatomic, assign) ZYSuspensionViewLeanType leanType;
/** container window */
@property (nonatomic, readonly) CJSuspendWindow *containerWindow;


/**
 *  Show
 */
- (void)show;

/**
 *  Remove and dealloc
 */
- (void)removeFromScreen;

@end


