//
//  UIImagePickerController+CJHookFileUploadPanel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/27.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImagePickerController (CJHookFileUploadPanel)

+ (void)hookDelegate;
+ (void)unHookDelegate;

@end
