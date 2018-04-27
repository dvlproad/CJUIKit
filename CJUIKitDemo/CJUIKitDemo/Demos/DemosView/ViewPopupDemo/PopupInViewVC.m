//
//  PopupInViewVC.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import "PopupInViewVC.h"
#import "UIView+CJPopupInView.h"

@interface PopupInViewVC ()

@end

@implementation PopupInViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


//注意点：使用popupInView必须保证执行popupInView:的实例是同一个，所以需要将要popup的view设置为全局变量，否则重复点击会出现错误
- (IBAction)popupInView1:(UIButton *)sender{
    if (popupView1 == nil) {
        UIView *popupView = [[UIView alloc]initWithFrame:CGRectZero];
        popupView.backgroundColor = [UIColor greenColor];
        popupView.tag = 1001;//技巧：为避免每个弹出框的tag一样，这里设置sender.tag，从而弹出框的tag就是sender.tag+固定值了
        
        popupView1 = popupView;
    }
    UIView *popupView = popupView1;
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        UIView *popupSuperview = self.view;
        CGFloat h_popupView = 100;
        
        CGPoint pointBtnConvert = [sender.superview convertPoint:sender.frame.origin toView:popupSuperview];
        CGPoint pointLocation = CGPointMake(pointBtnConvert.x, pointBtnConvert.y + CGRectGetHeight(sender.frame));
        CGSize size_popupView = CGSizeMake(CGRectGetWidth(sender.frame), h_popupView);
        
        [popupView cj_popupInView:popupSuperview withOrigin:pointLocation size:size_popupView showComplete:^{
            NSLog(@"显示完成");
        } tapBlankComplete:^() {
            NSLog(@"点击背景隐藏完成");
            sender.selected = !sender.selected;
            
            [popupView cj_hidePopupView];
        }];
    }else{
        [popupView cj_hidePopupViewWithAnimationType:CJAnimationTypeNormal];
    }
}


- (IBAction)popupInView2:(UIButton *)sender{ //Clip Subviews
    if (popupView2 == nil) {
        UIView *popupView = [[UIView alloc]initWithFrame:CGRectZero];
        popupView.backgroundColor = [UIColor greenColor];
        popupView.tag = 1002;//技巧：为避免每个弹出框的tag一样，这里设置sender.tag，从而弹出框的tag就是sender.tag+固定值了
        
        popupView2 = popupView;
    }
    UIView *popupView = popupView2;
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        UIView *popupSuperview = self.smallView1;
        CGFloat h_popupView = 50;
        
        CGPoint pointBtnConvert = [sender.superview convertPoint:sender.frame.origin toView:popupSuperview];
        CGPoint pointLocation = CGPointMake(pointBtnConvert.x, pointBtnConvert.y + CGRectGetHeight(sender.frame));
        CGSize size_popupView = CGSizeMake(CGRectGetWidth(sender.frame), h_popupView);
        
        [popupView cj_popupInView:popupSuperview withOrigin:pointLocation   size:size_popupView showComplete:^{
            NSLog(@"显示完成");
        } tapBlankComplete:^() {
            NSLog(@"点击背景完成");
            sender.selected = !sender.selected;
            
            [popupView cj_hidePopupView];
        }];
    }else{
        [popupView cj_hidePopupViewWithAnimationType:CJAnimationTypeNormal];
    }
}

- (IBAction)popupInView3:(UIButton *)sender{
    if (popupView3 == nil) {
        UIView *popupView = [[UIView alloc]initWithFrame:CGRectZero];
        popupView.backgroundColor = [UIColor greenColor];
        popupView.tag = 1003;//技巧：为避免每个弹出框的tag一样，这里设置sender.tag，从而弹出框的tag就是sender.tag+固定值了
        
        popupView3 = popupView;
    }
    UIView *popupView = popupView3;
    
    sender.selected = !sender.selected;
    if (sender.selected) {
        UIView *popupSuperview = self.view;
        CGFloat h_popupView = 50;
        
        CGPoint pointBtnConvert = [sender.superview convertPoint:sender.frame.origin toView:popupSuperview];
        CGPoint pointLocation = CGPointMake(pointBtnConvert.x, pointBtnConvert.y + CGRectGetHeight(sender.frame));
        CGSize size_popupView = CGSizeMake(CGRectGetWidth(sender.frame), h_popupView);
        
        [popupView cj_popupInView:popupSuperview withOrigin:pointLocation size:size_popupView showComplete:^{
            NSLog(@"显示完成");
        } tapBlankComplete:^() {
            NSLog(@"点击背景完成");
            sender.selected = !sender.selected;
            
            [popupView cj_hidePopupView];
        }];
    }else{
        [popupView cj_hidePopupViewWithAnimationType:CJAnimationTypeNormal];
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
