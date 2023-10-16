//
//  CQTSSuspendWindow.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  可拖动的悬浮window

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSSuspendWindow : UIWindow {
    
}
@property(nonatomic, copy) NSString *windowIdentifier;
#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame;

#pragma mark - Event
- (void)removeFromScreen;

@end

NS_ASSUME_NONNULL_END
