//
//  CJSuspendWindowManager.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJSuspendWindowManager.h"

@interface CJSuspendWindowManager ()

/** save windows dictionary */
@property (nonatomic, strong) NSMutableDictionary *windowDic;

@end

@implementation CJSuspendWindowManager

static CJSuspendWindowManager *_instance;

+ (instancetype)shared
{
    if (!_instance) {
        static dispatch_once_t onceToken;
        dispatch_once(&onceToken, ^{
            _instance = [[self alloc] init];
        });
    }
    return _instance;
}

+ (id)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [super allocWithZone:zone];
    });
    return _instance;
}


#pragma mark - getter
- (NSMutableDictionary *)windowDic
{
    if (!_windowDic) {
        _windowDic = [NSMutableDictionary dictionary];
    }
    return _windowDic;
}

#pragma mark - public methods

+ (UIWindow *)windowForKey:(NSString *)key
{
    return [[CJSuspendWindowManager shared].windowDic objectForKey:key];
}

+ (void)saveWindow:(UIWindow *)window forKey:(NSString *)key
{
    [[CJSuspendWindowManager shared].windowDic setObject:window forKey:key];
}

+ (void)destroyWindowForKey:(NSString *)key
{
    if (key == nil) {
        return;
    }
    
    UIWindow *window = [[CJSuspendWindowManager shared].windowDic objectForKey:key];
    window.hidden = YES;
    if (window.rootViewController.presentedViewController) {
        [window.rootViewController.presentedViewController dismissViewControllerAnimated:NO completion:nil];
    }
    window.rootViewController = nil;
    [[CJSuspendWindowManager shared].windowDic removeObjectForKey:key];
}

+ (void)destroyAllWindow
{
    for (UIWindow *window in [CJSuspendWindowManager shared].windowDic.allValues) {
        window.hidden = YES;
        window.rootViewController = nil;
    }
    [[CJSuspendWindowManager shared].windowDic removeAllObjects];
    [[UIApplication sharedApplication].delegate.window makeKeyAndVisible];
}

@end
