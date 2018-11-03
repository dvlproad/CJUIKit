//
//  AttributedStringViewController.h
//  CJFoundationDemo
//
//  Created by ciyouzne on 2017/7/24.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <YYText/YYText.h>

@interface AttributedStringViewController : UIViewController

@property (nonatomic, strong) IBOutlet UITextView *textView1;
@property (nonatomic, strong) IBOutlet UITextView *textView2;

@property (nonatomic, strong) IBOutlet UILabel *sytemLabel;
@property (nonatomic, strong) IBOutlet YYLabel *yyLabel;

@end
