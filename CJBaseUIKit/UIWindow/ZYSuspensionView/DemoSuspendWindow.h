//
//  DemoSuspendWindow.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJSuspendWindow.h"
#import <Masonry/Masonry.h>

@interface DemoSuspendWindow : CJSuspendWindow {
    
}
@property (nonatomic, copy) void (^clickWindowBlock)(UIButton *clickButton);
@property (nonatomic, copy) void (^closeWindowBlock)(void);

- (void)removeFromScreen;

@end
