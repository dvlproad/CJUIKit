//
//  UITextField+CJAddInputAccessoryView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/10/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UITextField+CJAddInputAccessoryView.h"
#import <objc/runtime.h>

@interface UITextField ()  {
    
}
@property (nonatomic, copy) void (^doneButtonClickBlock)(UITextField *textField);

@end



@implementation UITextField (CJAddInputAccessoryView)

#pragma mark - runtime
static NSString * const doneButtonClickBlockKey = @"doneButtonClickBlockKey";

- (void (^)(UITextField *))doneButtonClickBlock {
    return objc_getAssociatedObject(self, (__bridge const void *)(doneButtonClickBlockKey));
}

- (void)setDoneButtonClickBlock:(void (^)(UITextField *))doneButtonClickBlock {
    objc_setAssociatedObject(self, (__bridge const void *)(doneButtonClickBlockKey), doneButtonClickBlock, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

- (void)addDefaultInputAccessoryViewWithDoneButtonClickBlock:(void (^)(UITextField *textField))doneButtonClickBlock {
    self.doneButtonClickBlock = doneButtonClickBlock;
    
    CGFloat screenWidth = [[UIScreen mainScreen] bounds].size.width;
    UIToolbar *inputToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0, screenWidth, 44)];
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [doneButton setTitle:NSLocalizedString(@"完成", nil) forState:UIControlStateNormal];
    [doneButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    doneButton.titleLabel.font = [UIFont systemFontOfSize:14];
    [doneButton addTarget:self action:@selector(inputFinishEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    //知识点(iOS11):[iOS11 UIToolBar Contentview](https://stackoverflow.com/questions/46107640/ios11-uitoolbar-contentview)
    [doneButton setFrame:CGRectMake(screenWidth - 60, 0, 50, 44)];
    //[inputToolBar addSubview:doneButton];
    //[inputToolBar layoutIfNeeded];
    UIBarButtonItem *flexibleSpaceBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    UIBarButtonItem *doneBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:doneButton];
    [inputToolBar setItems:@[flexibleSpaceBarButtonItem, doneBarButtonItem] animated:YES];
    
    self.inputAccessoryView = inputToolBar;
}

- (void)inputFinishEvent:(UIButton *)doneButton {
    if (self.doneButtonClickBlock) {
        self.doneButtonClickBlock(self);
    }
}

@end
