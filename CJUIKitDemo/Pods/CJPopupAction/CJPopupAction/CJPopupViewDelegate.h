//
//  CJPopupViewDelegate.h
//  CJPopupViewDemo
//
//  Created by lichq on 15/11/12.
//  Copyright (c) 2015年 ciyouzen. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CJPopupViewDelegate <NSObject>

@optional
- (void)cjPopupView_Confirm:(UIView *)popupView;
- (void)cjPopupView_Cancel:(UIView *)popupView;

@end

