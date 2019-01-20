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

@interface UIViewController ()

@property (nonatomic) BOOL isFileInputIntercept;

@end

@implementation UIViewController (CJHookPresent)

// runtime
- (BOOL)isFileInputIntercept {
    return [objc_getAssociatedObject(self, @selector(isFileInputIntercept)) boolValue];
}

- (void)setIsFileInputIntercept:(BOOL)boolValue {
    objc_setAssociatedObject(self, @selector(isFileInputIntercept), @(boolValue), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}


- (void)cjHook_presentViewController:(UIViewController *)viewControllerToPresent animated:(BOOL)flag completion:(void (^)(void))completion {
    
    //如果present的viewcontroller是UIDocumentMenuViewController
    //类型，且代理是WKFileUploadPanel或UIWebFileUploadPanel
    //进行拦截
    if ([viewControllerToPresent isKindOfClass:[UIDocumentMenuViewController class]]) {
        UIDocumentMenuViewController *dvc = (UIDocumentMenuViewController*)viewControllerToPresent;
        if ([dvc.delegate isKindOfClass:NSClassFromString(@"WKFileUploadPanel")] || [dvc.delegate isKindOfClass:NSClassFromString(@"UIWebFileUploadPanel")]) {
            
            self.isFileInputIntercept = YES;
            [dvc.delegate documentMenuWasCancelled:dvc];
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [self cjHook_onFileInputIntercept];
            });
            
            return;
        }
    }
    //正常情况下的present
    [self cjHook_presentViewController:viewControllerToPresent animated:flag completion:completion];
}

- (void)cjHook_dismissViewControllerAnimated:(BOOL)flag completion:(void (^)(void))completion {
    
    //如果进行了拦截，禁止当前viewcontroller的dismiss
    if (self.isFileInputIntercept) {
        self.isFileInputIntercept = NO;
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


- (void)cjHook_onFileInputIntercept {
    UIViewController *viewController = [UIViewControllerCJHelper findCurrentShowingViewController];
    if ([viewController respondsToSelector:@selector(cjHook_onFileInputClicked)]) {
        [viewController performSelector:@selector(cjHook_onFileInputClicked)];
    }
}



+ (void)load {
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        SEL originalSelector = @selector(dismissViewControllerAnimated:completion:);
        SEL swizzledSelector = @selector(cjHook_dismissViewControllerAnimated:completion:);
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        BOOL success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
        
        originalSelector = @selector(presentViewController:animated:completion:);
        swizzledSelector = @selector(cjHook_presentViewController:animated:completion:);
        originalMethod = class_getInstanceMethod(class, originalSelector);
        swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        success = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        if (success) {
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}

@end
