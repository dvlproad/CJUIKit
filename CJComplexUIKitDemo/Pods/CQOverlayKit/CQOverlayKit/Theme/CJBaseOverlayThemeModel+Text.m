//
//  CJBaseOverlayThemeModel+Text.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJBaseOverlayThemeModel+Text.h"
#import <objc/runtime.h>

static NSString * const hudThemeModelKey = @"hudThemeModelKey";

static NSString * const overlayTextModelKey = @"overlayTextModelKey";

@implementation CJBaseOverlayThemeModel (Text)

#pragma mark - runtime
// hudThemeModel
- (CQHUDThemeModel *)hudThemeModel {
    CQHUDThemeModel *hudThemeModel = objc_getAssociatedObject(self, &hudThemeModelKey);
    if (hudThemeModel == nil) {
        @synchronized (self) { // 修复未初始化的问题
            hudThemeModel = [[CQHUDThemeModel alloc] init];
            objc_setAssociatedObject(self, &hudThemeModelKey, hudThemeModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    return hudThemeModel;
}

- (void)setHudThemeModel:(CQHUDThemeModel *)hudThemeModel {
    objc_setAssociatedObject(self, &hudThemeModelKey, hudThemeModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

//overlayTextModel
- (CQOverlayTextModel *)overlayTextModel {
    CQOverlayTextModel *allTextModel = objc_getAssociatedObject(self, &overlayTextModelKey);
    if (allTextModel == nil) {
        @synchronized (self) { // 修复未初始化的问题
            allTextModel = [[CQOverlayTextModel alloc] init];
            objc_setAssociatedObject(self, &overlayTextModelKey, allTextModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    return allTextModel;
}

- (void)setOverlayTextModel:(CQOverlayTextModel *)overlayTextModel {
    objc_setAssociatedObject(self, &overlayTextModelKey, overlayTextModel, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

@end
