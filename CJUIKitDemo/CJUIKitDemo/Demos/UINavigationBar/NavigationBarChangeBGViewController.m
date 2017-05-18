//
//  NavigationBarChangeBGViewController.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/5/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "NavigationBarChangeBGViewController.h"

@interface NavigationBarChangeBGViewController ()

@end

@implementation NavigationBarChangeBGViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.navigationController.navigationBar cj_reset];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
//    [self scrollViewDidScroll:self.tableView];
//    [self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self addTableScaleHeaderViewWithPullUpMinHeight:64 supportPullSmall:YES];
    
    [self.navigationController.navigationBar cj_setBackgroundColor:[UIColor clearColor]];//改变导航栏背景色
    self.automaticallyAdjustsScrollViewInsets = NO; //设成透明的时候，让顶部不会有一个statusBar的偏差
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    UIColor * color = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top; //注意加上top（top一般为0,但是在下拉图片放大的时候我们改变了contentInset）
    //NSLog(@"offsetY = %.1f", offsetY);
    
    CGFloat navigationBarChangeAtPointY = 100;
    CGFloat alpha = 0;
    if (offsetY > navigationBarChangeAtPointY) {
        alpha = MIN(1, 1 - ((navigationBarChangeAtPointY + 64 - offsetY) / 64));
    }
    
    [self.navigationController.navigationBar cj_setBackgroundColor:[color colorWithAlphaComponent:alpha]];
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
