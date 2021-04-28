//
//  DemoSuspendWindowRootViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoSuspendWindowRootViewController : UIViewController {
    
}
@property (nullable, nonatomic, copy) void (^clickWindowBlock)(UIButton *clickButton);
@property (nullable, nonatomic, copy) void (^closeWindowBlock)(void);

@end
