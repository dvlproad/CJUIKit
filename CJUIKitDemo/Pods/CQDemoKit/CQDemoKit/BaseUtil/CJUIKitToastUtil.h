//
//  CJUIKitToastUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CJUIKitToastUtil : NSObject {
    
}

+ (void)showMessage:(NSString *)message;
+ (void)showToast:(NSString *)text inView:(UIView *)superView;


@end
