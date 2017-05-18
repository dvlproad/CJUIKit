//
//  NavigationBarChangePositonViewController.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/5/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "NavigationBarChangePositonViewController.h"

#import "UINavigationBar+CJChangeBG.h"

@interface NavigationBarChangePositonViewController () {
    
}
@property (nonatomic, assign) CGFloat oldOffsetY;

@end

@implementation NavigationBarChangePositonViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar cj_reset];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTableScaleHeaderViewWithPullUpMinHeight:0 supportPullSmall:NO];
}

- (void)setNavigationBarTransformProgress:(CGFloat)progress
{
    [self.navigationController.navigationBar cj_setTranslationY:(-44 * progress)];
    [self.navigationController.navigationBar cj_setElementsAlpha:(1-progress)];
}

///停止拖拽的时候开始执行
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate {
    NSLog(@"拖动结束后是否会有减速动作decelerate = %@", decelerate ? @"YES" : @"NO");
    [self navigationBarAdujstToScrollView:scrollView];
}

///减速停止的时候开始执行
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSLog(@"减速停止的时候开始执行");
    [self navigationBarAdujstToScrollView:scrollView];
}

- (void)navigationBarAdujstToScrollView:(UIScrollView *)scrollView {
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    if (currentOffsetY <= 200) {
        [self setNavigationBarTransformProgress:0];
        self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
        
    } else {
        [UIView animateWithDuration:0.35 animations:^{
            if (currentOffsetY > self.oldOffsetY) {
                [self setNavigationBarTransformProgress:1];
            } else {
                [self setNavigationBarTransformProgress:0]; //显示导航栏
                self.navigationController.navigationBar.backIndicatorImage = [UIImage new];
            }
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
    self.oldOffsetY = scrollView.contentOffset.y;
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
