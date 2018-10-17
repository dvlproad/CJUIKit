//
//  WelcomePopupView.m
//  CJPopupViewDemo
//
//  Created by 李超前 on 16/9/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "WelcomePopupView.h"

@implementation WelcomePopupView

- (IBAction)cjPopupView_Confirm:(id)sender {
    if (self.popupViewDelegate && [self.popupViewDelegate respondsToSelector:@selector(cjPopupView_Confirm:)]) {
        [self.popupViewDelegate cjPopupView_Confirm:self];
    }

}

- (IBAction)cjPopupView_Cancel:(id)sender {
    if (self.popupViewDelegate && [self.popupViewDelegate respondsToSelector:@selector(cjPopupView_Cancel:)]) {
        [self.popupViewDelegate cjPopupView_Cancel:self];
    }
}

@end
