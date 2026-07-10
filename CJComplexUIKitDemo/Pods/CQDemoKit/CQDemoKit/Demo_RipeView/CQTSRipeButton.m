//
//  CQTSRipeButton.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CQTSRipeButton.h"
#import "CQTSButtonFactory.h"
#import "CJUIKitToastUtil.h"

@interface CQTSRipeButton () {
    
}

@end

@implementation CQTSRipeButton

#pragma mark - 成熟的测试Button(已含标题和事件)
/*
 *  成熟的测试Button的构建方法(已含标题和事件)
 *
 *  @param index index
 *
 *  @return Button
 */
UIButton *tsRipeButtonIndex(NSInteger index) {
    NSString *title = [NSString stringWithFormat:@"按钮%zd", index];
    UIButton *button = [CQTSButtonFactory themeBGButtonWithTitle:title actionBlock:^(UIButton * _Nonnull bButton) {
        NSString *message = [NSString stringWithFormat:@"你点击了按钮%zd", index];
        [CJUIKitToastUtil showMessage:message];
    }];
    return button;
}

@end
