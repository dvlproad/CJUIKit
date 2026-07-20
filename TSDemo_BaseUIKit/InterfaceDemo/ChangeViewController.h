//
//  ChangeViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/11/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeViewController : UIViewController

@property (nonatomic, copy) void(^changeBlock)(NSString *text);

@end
