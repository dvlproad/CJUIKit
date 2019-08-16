//
//  PopupInWindowVC.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "PopupInWindowVC.h"

#import "WelcomeViewToPop.h"
#import "WelcomePopupView.h"

#import "UIView+CJPopupInView.h"

@interface PopupInWindowVC ()<CJPopupViewDelegate>

@end

@implementation PopupInWindowVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)popupInWindow_center:(id)sender{
//    WelcomeViewToPop *popupView = (WelcomeViewToPop *)[[[NSBundle mainBundle] loadNibNamed:@"WelcomeViewToPop" owner:nil options:nil] lastObject];
    WelcomePopupView *popupView = (WelcomePopupView *)[[[NSBundle mainBundle] loadNibNamed:@"WelcomePopupView" owner:nil options:nil] lastObject];
//    popupView.cjExtraOffset = 20;
    
    popupView.popupViewDelegate = self;
    popupView.outestView = self.view;
    
    CGSize popupViewSize = popupView.frame.size;
    //popupViewSize = CGSizeMake(200, 200);
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    [popupView cj_popupInCenterWindow:CJAnimationTypeCATransform3D withSize:popupViewSize blankBGColor:blankBGColor showComplete:^{
        NSLog(@"显示完成");
        
    } tapBlankComplete:^{
        NSLog(@"点击背景完成");
        [popupView cj_hidePopupView];
    }];
}


- (IBAction)popupInWindow_bottom:(id)sender{
    WelcomeViewToPop *popupView = (WelcomeViewToPop *)[[[NSBundle mainBundle] loadNibNamed:@"WelcomeViewToPop" owner:nil options:nil] lastObject];
    popupView.popupViewDelegate = self;
    
    CGFloat popupViewHeight = CGRectGetHeight(popupView.frame);
    UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    [popupView cj_popupInBottomWindow:CJAnimationTypeNormal withHeight:popupViewHeight edgeInsets:UIEdgeInsetsZero blankBGColor:blankBGColor showComplete:^{
        NSLog(@"显示完成");
        
    } tapBlankComplete:^{
        NSLog(@"点击背景完成");
        [popupView cj_hidePopupView];
    }];
}

#pragma mark - CJPopupViewDelegate
- (void)cjPopupView_Confirm:(UIView *)popupView {
    [popupView cj_hidePopupView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
