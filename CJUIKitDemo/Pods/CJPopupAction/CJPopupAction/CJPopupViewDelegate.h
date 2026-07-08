//
//  CJPopupViewDelegate.h
//  CJPopupAction
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CJPopupViewDelegate <NSObject>

@optional
- (void)cjPopupView_Confirm:(UIView *)popupView;
- (void)cjPopupView_Cancel:(UIView *)popupView;

@end

