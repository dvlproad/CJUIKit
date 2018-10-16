//
//  UIViewController+CJChangeEnvironment.h
//  CJUIKitDemo
//
//  Created by 李超前 on 2018/10/12.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIViewController (CJChangeEnvironment)

@property (nonatomic, strong) UIButton *cjChangeEnvironmentButton;
@property (nonatomic, assign, readonly) NSInteger cjCurrentEnvironmentIndex;

@property (nonatomic, strong) NSMutableArray<NSString *> *cjEnvironmentTitles;
@property (nonatomic, copy) NSString *cjCurrentEnvironmentTitle;

@end
