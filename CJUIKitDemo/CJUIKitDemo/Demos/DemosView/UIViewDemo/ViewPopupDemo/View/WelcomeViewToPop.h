//
//  WelcomeViewToPop.h
//  CJPopupViewDemo
//
//  Created by ciyouzen on 6/22/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJPopupViewDelegate.h"

@interface WelcomeViewToPop : UIView <UITextFieldDelegate>

@property (assign, nonatomic) id <CJPopupViewDelegate> popupViewDelegate;

@property (nonatomic, weak) UIView *outestView; /**< 最外层的view */
@property (nonatomic, weak) IBOutlet UITextField *textField1;
@property (nonatomic, weak) IBOutlet UITextField *textField2;
@property (nonatomic, weak) IBOutlet UITextField *textField3;

@end
