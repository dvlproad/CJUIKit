//
//  CQTSSuspendButtonRootViewController.h
//  CQDemoKit
//
//  Created by ciyouzen on 2017/5/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSSuspendButtonRootViewController : UIViewController {
    
}

- (instancetype)initWithButtonTitle:(NSString *)buttonTitle
                  buttonClickHandle:(void(^)(void))buttonClickHandle NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

@end

NS_ASSUME_NONNULL_END
