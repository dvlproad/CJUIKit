//
//  UIView+CJPopupInSuspendWindow.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (CJPopupInSuspendWindow)

- (void)cj_popupInSuspendWindowWithIdentifier:(NSString *)windowIdentifier
                                  windowFrame:(CGRect)suspendWindowFrame;

@end
