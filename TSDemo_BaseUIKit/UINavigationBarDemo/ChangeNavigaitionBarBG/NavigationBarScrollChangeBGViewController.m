//
//  NavigationBarScrollChangeBGViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "NavigationBarScrollChangeBGViewController.h"

@interface NavigationBarScrollChangeBGViewController ()

@end

@implementation NavigationBarScrollChangeBGViewController

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self navigationBarReset];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:YES];
    
    [self navigationBarCustomSet];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addTableScaleHeaderViewWithAttachNavigationBar:YES supportPullSmall:YES];
    
    self.automaticallyAdjustsScrollViewInsets = NO; //设成透明的时候，让顶部不会有一个statusBar的偏差
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self navigationBarUpdateByScrollView:scrollView];
}



#pragma mark - 导航栏的设置
///导航栏的重置
- (void)navigationBarReset {
    [self.navigationController.navigationBar cj_resetBackgroundColor];
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor whiteColor]} forState:UIControlStateHighlighted];
}

///导航栏在当前页面的自定义
- (void)navigationBarCustomSet {
    /* 改变导航栏 */
    [self.navigationController.navigationBar cj_hideUnderline:YES];//删除导航栏的下划线
    [self.navigationController.navigationBar cj_setBackgroundColor:[UIColor clearColor]];//改变导航栏背景色
    //[self.navigationController.navigationBar cj_setElementsAlpha:0];
    
    self.navigationItem.title = @"";
    
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateNormal];
    [[UIBarButtonItem appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor clearColor]} forState:UIControlStateHighlighted];
    
    //[self.navigationController.navigationBar setShadowImage:[UIImage new]];
}

///导航栏根据滚动视图的更新
- (void)navigationBarUpdateByScrollView:(UIScrollView *)scrollView {
    UIColor *navigationBarBackgroundColor = [UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1];
    CGFloat offsetY = scrollView.contentOffset.y + scrollView.contentInset.top; //注意加上top（top一般为0,但是在下拉图片放大的时候我们改变了contentInset）
    
    CGFloat navigationBarAlpha0OffsetY = 100;//设置滚动视图移动到(正值代表上移)多少时候，导航栏透明度为0
    
    CGFloat alpha = 0;
    if (offsetY > navigationBarAlpha0OffsetY) {
        alpha = MIN(1, 1 - ((navigationBarAlpha0OffsetY + 64 - offsetY) / 64));
    }
    
    /*
    CGFloat scaleHeadViewChangeHeightFromMaxToMin = self.scaleHeadView.originHeight - self.scaleHeadView.pullUpMinHeight; //scaleHeadView从初始大小缩小到最小大小所改变的大小
    CGFloat navigationBarAlpha1OffsetY = scaleHeadViewChangeHeightFromMaxToMin;//设置滚动视图移动到(正值代表上移)多少时候，导航栏透明度为1
    if (offsetY < navigationBarAlpha0OffsetY) {
        alpha = 0;
        //alpha = MIN(1, 1 - ((navigationBarAlpha0OffsetY + 64 - offsetY) / 64));
    } else if (offsetY > navigationBarAlpha1OffsetY) {
        alpha = 1;
    } else {
        alpha = (offsetY -navigationBarAlpha0OffsetY) /(navigationBarAlpha1OffsetY - navigationBarAlpha0OffsetY);
    }
    //*/
    //NSLog(@"offsetY = %.1f, alpha = %.3f", offsetY, alpha);
    
    UIColor *currentNavigationBarBackgroundColor = [navigationBarBackgroundColor colorWithAlphaComponent:alpha];
    [self.navigationController.navigationBar cj_setBackgroundColor:currentNavigationBarBackgroundColor];
    [self.navigationController.navigationBar cj_setElementsAlpha:alpha];
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
