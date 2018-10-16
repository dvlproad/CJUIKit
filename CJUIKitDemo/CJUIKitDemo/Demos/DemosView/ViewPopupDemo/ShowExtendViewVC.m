//
//  ShowExtendViewVC.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/16.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "ShowExtendViewVC.h"
#import "UIView+CJShowExtendView.h"

@interface ShowExtendViewVC ()

@end

@implementation ShowExtendViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (IBAction)showPopupInView1:(UIButton *)sender{
    UIView *popupView = [[UIView alloc]initWithFrame:CGRectZero];
    popupView.backgroundColor = [UIColor greenColor];
    popupView.tag = 1001;//技巧：为避免每个弹出框的tag一样，这里设置sender.tag，从而弹出框的tag就是sender.tag+固定值了
    
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        UIView *popupSuperview = self.view;
        CGFloat h_popupView = 50;
        
        CGPoint pointBtnConvert = [sender.superview convertPoint:sender.frame.origin toView:popupSuperview];
        CGPoint pointLocation = CGPointMake(pointBtnConvert.x, pointBtnConvert.y + CGRectGetHeight(sender.frame));
        CGSize size_popupView = CGSizeMake(CGRectGetWidth(sender.frame), h_popupView);
        
        UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
        [sender cj_showExtendView:popupView inView:popupSuperview atLocation:pointLocation withSize:size_popupView blankBGColor:blankBGColor showComplete:^{
            NSLog(@"显示完成");
            
        } tapBlankComplete:^{
            NSLog(@"点击背景完成");
            sender.selected = !sender.selected;
            
            [popupView cj_hidePopupView];
        }];
        
    }else{
        [sender cj_hideExtendViewAnimated:YES];
    }

}


- (IBAction)showPopupInView2:(UIButton *)sender{ //Clip Subviews
    UIView *popupView = [[UIView alloc]initWithFrame:CGRectZero];
    popupView.backgroundColor = [UIColor greenColor];
    popupView.tag = 1002;
    
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        UIView *popupSuperview = self.smallView1;
        CGFloat h_popupView = 50;
        
        CGPoint pointBtnConvert = [sender.superview convertPoint:sender.frame.origin toView:popupSuperview];
        CGPoint pointLocation = CGPointMake(pointBtnConvert.x, pointBtnConvert.y + CGRectGetHeight(sender.frame));
        CGSize size_popupView = CGSizeMake(CGRectGetWidth(sender.frame), h_popupView);
        
        UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
        [sender cj_showExtendView:popupView inView:popupSuperview atLocation:pointLocation withSize:size_popupView blankBGColor:blankBGColor showComplete:^{
            NSLog(@"显示完成");
            
        } tapBlankComplete:^{
            NSLog(@"点击背景完成");
            sender.selected = !sender.selected;
            
            [popupView cj_hidePopupView];
        }];
        
    }else{
        [sender cj_hideExtendViewAnimated:YES];
    }
}

- (IBAction)showPopupInView3:(UIButton *)sender{
    UIView *popupView = [[UIView alloc]initWithFrame:CGRectZero];
    popupView.backgroundColor = [UIColor greenColor];
    popupView.tag = 1003;
    
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        UIView *popupSuperview = self.view;
        CGFloat h_popupView = 50;
        
        CGPoint pointBtnConvert = [sender.superview convertPoint:sender.frame.origin toView:popupSuperview];
        CGPoint pointLocation = CGPointMake(pointBtnConvert.x, pointBtnConvert.y + CGRectGetHeight(sender.frame));
        CGSize size_popupView = CGSizeMake(CGRectGetWidth(sender.frame), h_popupView);
        
        UIColor *blankBGColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
        [sender cj_showExtendView:popupView inView:popupSuperview atLocation:pointLocation withSize:size_popupView blankBGColor:blankBGColor showComplete:^{
            NSLog(@"显示完成");
            
        } tapBlankComplete:^{
            NSLog(@"点击背景完成");
            sender.selected = !sender.selected;
            
            [sender cj_hideExtendViewAnimated:YES];
        }];
        
    }else{
        [sender cj_hideExtendViewAnimated:YES];
    }
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
