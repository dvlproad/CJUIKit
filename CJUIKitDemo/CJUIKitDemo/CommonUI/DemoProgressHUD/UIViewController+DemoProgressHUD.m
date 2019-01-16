//
//  UIViewController+DemoProgressHUD.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/11/1.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "UIViewController+DemoProgressHUD.h"
#import <objc/runtime.h>
#import "DemoProgressHUD.h"

@interface UIViewController () {
    
}
@property (nonatomic, strong) DemoProgressHUD *DemoProgressHUD;


@end

@implementation UIViewController (DemoProgressHUD)

//DemoProgressHUD
- (DemoProgressHUD *)DemoProgressHUD {
    return objc_getAssociatedObject(self, @selector(DemoProgressHUD));
}

- (void)setDemoProgressHUD:(DemoProgressHUD *)DemoProgressHUD {
    objc_setAssociatedObject(self, @selector(DemoProgressHUD), DemoProgressHUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)showDemoProgressHUD {
    if (!self.DemoProgressHUD) {
        self.DemoProgressHUD = [[DemoProgressHUD alloc] init];
    }
    
    [self.DemoProgressHUD showInView:self.view withShowBackground:NO];
}

- (void)dismissDemoProgressHUD {
    BOOL dismissSuccess = [self.DemoProgressHUD dismissWithForce:NO];
    if (dismissSuccess) {
        self.DemoProgressHUD = nil;
    }
}

@end
