//
//  LOTAnimationView.h
//  UIKit-Overlay-iOS
//
//  Created by dvlproad on 2021/1/6.
//  Copyright © 2021 ciyouzen. All rights reserved.
//
//  Lottie animation view

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@interface LOTAnimationView : UIView {
    
}
@property (nonatomic, assign) CGFloat animationProgress;
@property (nonatomic, assign) BOOL loopAnimation;

#pragma mark - Action
- (void)forceDrawingUpdate;
- (void)play;
- (void)stop;

#pragma mark - Init
- (instancetype)initWithFrame:(CGRect)frame NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithContentsOfURL:(NSURL *)URL;
- (instancetype)initWithAnimationNamed:(nonnull NSString *)animationName inBundle:(nonnull NSBundle *)bundle;

#pragma mark - Config
- (void)setAnimationContentsOfURL:(NSURL *)URL;
- (void)setAnimationNamed:(NSString *)animationName inBundle:(nullable NSBundle *)bundle;

@end

NS_ASSUME_NONNULL_END
