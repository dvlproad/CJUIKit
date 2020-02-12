//
//  CJHUDSettingManager.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/20.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJHUDSettingManager.h"

@implementation CJHUDSettingManager

+ (CJHUDSettingManager *)sharedInstance {
    static CJHUDSettingManager *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[self alloc] init];
    });
    return _sharedInstance;
}

- (instancetype)init {
    self = [super init];
    if(self){
        
        
    }
    return self;
}

#pragma mark - 全局设置(APP启动时候调用)
/**
*  设置全局ProgressHUD的json文件名
*
*  @param animationNamed animationNamed
*/
- (void)configHUDAnimationWithAnimationNamed:(NSString *)animationNamed {
    _animationNamed = animationNamed;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
