//
//  UIViewController+CJHookImagePicker.h
//  CJHookDemo
//
//  Created by ciyouzen on 2019/1/20.
//  Copyright © 2019 dvlproad. All rights reserved.
//
//  warning:need correcte it

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (CJHookImagePicker)

@property (nonatomic, assign) BOOL cjShouldHookFileUploadPanelFinishPicking;

@end

NS_ASSUME_NONNULL_END
