//
//  UIViewController+CJHookPresent.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/20.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIViewController+CJHookPresent.h"
#import <objc/runtime.h>
#import <CJBaseHelper/UIViewControllerCJHelper.h>
#import <CJBaseHelper/HookCJHelper.h>

@interface UIViewController ()

@property (nonatomic, assign) BOOL isCJFileUploadPanelPresent;

@end

@implementation UIViewController (CJHookPresent)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector1 = @selector(dismissViewControllerAnimated:completion:);
        SEL swizzledSelector1 = @selector(cjHook_dismissViewControllerAnimated:completion:);
        HookCJHelper_swizzleMethod(class, originalSelector1, swizzledSelector1);
        
        SEL originalSelector2 = @selector(presentViewController:animated:completion:);
        SEL swizzledSelector2 = @selector(cjHook_presentViewController:animated:completion:);
        HookCJHelper_swizzleMethod(class, originalSelector2, swizzledSelector2);
    });
}


// runtime
- (BOOL)cjShouldHookFileUploadPanelPresent {
    return [objc_getAssociatedObject(self, @selector(cjShouldHookFileUploadPanelPresent)) boolValue];
}

- (void)setCjShouldHookFileUploadPanelPresent:(BOOL)cjShouldHookFileUploadPanelPresent {
    objc_setAssociatedObject(self, @selector(cjShouldHookFileUploadPanelPresent), @(cjShouldHookFileUploadPanelPresent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isCJFileUploadPanelPresent {
    return [objc_getAssociatedObject(self, @selector(isCJFileUploadPanelPresent)) boolValue];
}

- (void)setIsCJFileUploadPanelPresent:(BOOL)isCJFileUploadPanelPresent {
    objc_setAssociatedObject(self, @selector(isCJFileUploadPanelPresent), @(isCJFileUploadPanelPresent), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)cjHook_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    UIViewController *viewController = [UIViewControllerCJHelper findCurrentShowingViewController];
    if (viewController.cjShouldHookFileUploadPanelPresent == NO) {
        [self cjHook_presentViewController:viewControllerToPresent animated:flag completion:completion];
        return;
    }
    
    //如果present的viewcontroller是UIDocumentMenuViewController类型,且代理是WKFileUploadPanel或UIWebFileUploadPanel,则进行拦截
    if ([viewControllerToPresent isKindOfClass:[UIDocumentMenuViewController class]]) {
        UIDocumentMenuViewController *dvc = (UIDocumentMenuViewController*)viewControllerToPresent;
        if ([dvc.delegate isKindOfClass:NSClassFromString(@"WKFileUploadPanel")] || [dvc.delegate isKindOfClass:NSClassFromString(@"UIWebFileUploadPanel")]) {
            
            self.isCJFileUploadPanelPresent = YES;
            [dvc.delegate documentMenuWasCancelled:dvc];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self cjHook_onFileUploadPanelPresent];
            });
            
            return;
        }
    }
    //正常情况下的present
    [self cjHook_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)cjHook_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    
    //如果进行了拦截，禁止当前viewcontroller的dismiss
    if (self.isCJFileUploadPanelPresent) {
        self.isCJFileUploadPanelPresent = NO;
        completion();
        return;
    }
    
    //正常情况下viewcontroller的dismiss
    [self cjHook_dismissViewControllerAnimated:flag completion:^{
        if (completion) {
            completion();
        }
    }];
}

- (void)cjHook_onFileUploadPanelPresent {
    UIViewController *viewController = [UIViewControllerCJHelper findCurrentShowingViewController];
    SEL selector = NSSelectorFromString(@"cjHook_onFileInputClicked");
    if ([viewController respondsToSelector:selector]) {
        [viewController performSelector:@selector(cjHook_onFileInputClicked)];
    }
}

//- (void)cjHook_onFileInputClicked {
//    NSLog(@"cjHook_onFileInputClicked");
//}


@end
