//
//  UIViewController+CJHookImagePicker.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/20.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "UIViewController+CJHookImagePicker.h"
#import <objc/runtime.h>
#import <CJBaseHelper/UIViewControllerCJHelper.h>
#import "HookCJHelper.h"

@interface UIViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>


@end

@implementation UIViewController (CJHookImagePicker)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = NSClassFromString(@"WKFileUploadPanel"); //don't write wrong
        //Class class = NSClassFromString(@"UIWebFileUploadPanel");
        SEL originalSelector1 = @selector(imagePickerController:didFinishPickingMediaWithInfo:);
        SEL swizzledSelector1 = @selector(cjHook_imagePickerController:didFinishPickingMediaWithInfo:);
        HookCJHelper_swizzleMethod(class, originalSelector1, swizzledSelector1);
    });
}

// runtime
- (BOOL)cjShouldHookFileUploadPanelFinishPicking {
    return [objc_getAssociatedObject(self, @selector(cjShouldHookFileUploadPanelFinishPicking)) boolValue];
}

- (void)setCjShouldHookFileUploadPanelFinishPicking:(BOOL)cjShouldHookFileUploadPanelFinishPicking {
    objc_setAssociatedObject(self, @selector(cjShouldHookFileUploadPanelFinishPicking), @(cjShouldHookFileUploadPanelFinishPicking), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)cjHook_imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIViewController *viewController = [UIViewControllerCJHelper findCurrentShowingViewController];
    if (viewController.cjShouldHookFileUploadPanelFinishPicking == NO) {
        [self cjHook_imagePickerController:picker didFinishPickingMediaWithInfo:info];
        return;
    }
    
    BOOL isPickingFromFileUploadPanel = [picker.delegate isKindOfClass:NSClassFromString(@"WKFileUploadPanel")] || [picker.delegate isKindOfClass:NSClassFromString(@"UIWebFileUploadPanel")];
    if (isPickingFromFileUploadPanel) {
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            NSDictionary *newInfo = [self cjHook_onFileUploadPanelFinishPicking:info];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self cjHook_imagePickerController:picker didFinishPickingMediaWithInfo:newInfo];
            });
        });
        
    } else {
        [self cjHook_imagePickerController:picker didFinishPickingMediaWithInfo:info];
    }
}


- (NSDictionary *)cjHook_onFileUploadPanelFinishPicking:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIViewController *viewController = [UIViewControllerCJHelper findCurrentShowingViewController];
    SEL selector = NSSelectorFromString(@"cjHook_FileUploadPanelFinishPicking:");
    if ([viewController respondsToSelector:selector]) {
        NSDictionary *newInfo = [viewController performSelector:@selector(cjHook_FileUploadPanelFinishPicking:) withObject:info];
        return newInfo;
    }
    return info;
}

//- (void)cjHook_FileUploadPanelFinishPicking:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
//    NSLog(@"cjHook_FileUploadPanelFinishPicking");
//}




@end
