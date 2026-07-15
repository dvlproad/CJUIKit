//
//  CQTSFPSView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  获取并显示实时fps的视图

#import <UIKit/UIKit.h>

@interface CQTSFPSView : UIButton {
    
}

/// 显示一个能够显示实时FPS的测试视图
+ (void)showInSuperView:(nullable UIView *)superView;

@end
