//
//  LOTAnimationView.m
//  UIKit-Overlay-iOS
//
//  Created by dvlproad on 2021/1/6.
//  Copyright © 2021 ciyouzen. All rights reserved.
//

#import "LOTAnimationView.h"
//#import "CQBridgeSTOLottie-Swift.h"                         // Podfile中没使用use_frameworks!的时候
//#import <CQBridgeSTOLottie/CQBridgeSTOLottie-Swift.h>       // Podfile中有使用use_frameworks!的时候
#if __has_include("CQBridgeSTOLottie-Swift.h")
#import "CQBridgeSTOLottie-Swift.h"                         // Podfile中没使用use_frameworks!的时候
#else
    #if __has_include(<CQBridgeSTOLottie/CQBridgeSTOLottie-Swift.h>)
    #import <CQBridgeSTOLottie/CQBridgeSTOLottie-Swift.h>   // Podfile中有使用use_frameworks!的时候
    #else
    #endif
#endif

@interface LOTAnimationView ()

@property (nonatomic, strong) AnimationViewContainer *animationView;


@end

@implementation LOTAnimationView


- (void)setAnimationProgress:(CGFloat)animationProgress {
    _animationProgress = animationProgress;
    
    self.animationView.animationProgress = animationProgress;
}

#pragma mark - Action
- (void)forceDrawingUpdate {
    [self.animationView forceDrawingUpdate];
}

- (void)play {
    [self.animationView play];
}

- (void)stop {
    [self.animationView stop];
}

#pragma mark - Init
// 如果需要支持从 xib/storyboard 加载
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super initWithCoder:coder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithContentsOfURL:(NSURL *)URL {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        [self setAnimationContentsOfURL:URL];
    }
    return self;
}

- (instancetype)initWithAnimationNamed:(nonnull NSString *)animationName inBundle:(nonnull NSBundle *)bundle {
    self = [self initWithFrame:CGRectZero];
    if (self) {
        [self setAnimationNamed:animationName inBundle:bundle];
    }
    return self;
}

#pragma mark - Private Methods
- (void)commonInit {
    self.animationView = [[AnimationViewContainer alloc] init];
    [self addSubview:self.animationView];
}


#pragma mark - Config
- (void)setAnimationContentsOfURL:(NSURL *)URL {
    //[self.animationView configAnimationWithName:@"tab_search_animate" filePath:nil];
        
    NSString *filePath = [URL absoluteString];
    NSString *jsonFileFullName = [filePath lastPathComponent];
    NSString *jsonFileName;
    NSArray *jsonFileFullNameComponent = [jsonFileFullName componentsSeparatedByString:@"."];
    if ([jsonFileFullNameComponent count] != 2) {
        jsonFileName = nil;
    } else {
        NSString *fileTitle = [jsonFileFullNameComponent objectAtIndex:0];
        //NSString *fileType = [jsonFileFullNameComponent objectAtIndex:1];
        jsonFileName = fileTitle;
    }
    
    [self setAnimationNamed:jsonFileName inBundle:nil];
}

- (void)setAnimationNamed:(NSString *)animationName inBundle:(nullable NSBundle *)bundle {
    NSAssert(self.animationView != nil, @"self.animationView != nil");
    [self.animationView configAnimationWithName:animationName bundle:bundle subdirectory:nil];
}




- (void)layoutSubviews {
    [super layoutSubviews];
    
    self.animationView.frame = self.bounds;
}

- (void)setLoopAnimation:(BOOL)loopAnimation {
    _loopAnimation = loopAnimation;
}



@end
