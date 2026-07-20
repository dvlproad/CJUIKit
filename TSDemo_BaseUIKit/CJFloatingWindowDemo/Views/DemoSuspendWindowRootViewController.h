//
//  DemoSuspendWindowRootViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface DemoSuspendWindowRootViewController : UIViewController {
    
}
@property (nullable, nonatomic, copy) void (^clickWindowBlock)(UIButton *bClickButton);
@property (nullable, nonatomic, copy) void (^closeWindowBlock)(void);

@end

NS_ASSUME_NONNULL_END
