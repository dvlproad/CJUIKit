//
//  SuspendWindowFactory.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  用于弹出log视图的悬浮球
 */
@interface SuspendWindowFactory : NSObject {
    
}

+ (UIWindow *)windowWithIdentifier:(NSString *)windowIdentifier;

@end
