//
//  TextViewController.h
//  CJUIKitDemo
//
//  Created by dvlproad on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJTextView.h"

@interface TextViewController : UIViewController

@property (nonatomic, weak) IBOutlet CJTextView *textView;


@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewBottomConstranit;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomViewHeightConstraint;

@end

