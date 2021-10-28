//
//  CJUIKitBaseViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseViewController.h"
#import "CQTSButtonFactory.h"

@interface CJUIKitBaseViewController ()

@end

@implementation CJUIKitBaseViewController

- (void)dealloc {
    //NSLog(@"%s", __func__);
    NSLog(@"dealloc -[%@ dealloc], 地址%p", NSStringFromClass([self class]), self);       // 用于检测循环引用
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //NSLog(@"%s", __func__);
    NSLog(@"viewDidLoad -[%@ viewDidLoad], 地址%p", NSStringFromClass([self class]), self);// 用于检测循环引用
    
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1.0]; // #f5f5f5
}

#pragma mark - 测试进入其他视图的情况（从导航栏右键）
/// 测试进入其他视图的情况（从导航栏右键）
- (void)tsGoOtherViewControllerByRightBarButtonItem {
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"进其他视图", nil) style:UIBarButtonItemStylePlain target:self action:@selector(__goOtherViewController)];
}

- (void)__goOtherViewController {
    UIViewController *viewController = [[UIViewController alloc] init];
    
    UIColor *randomColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
    viewController.view.backgroundColor = randomColor;
    viewController.hidesBottomBarWhenPushed = YES;
    
    [self.navigationController pushViewController:viewController animated:YES];
}


#pragma mark - 测试切换不同操作（从导航栏右键）
/// 测试切换不同操作（从导航栏右键）：当前显示的是 editTitle
- (void)tsChangeByRightBarButtonItemWithSubmitTitle:(NSString *)submitTitle
                                          editTitle:(NSString *)editTitle
                              clickSubmitTitleBlock:(void(^)(void))clickSubmitTitleBlock
                                clickEditTitleBlock:(void(^)(void))clickEditTitleBlock
{
    UIButton *button = [CQTSButtonFactory submitButtonWithSubmitTitle:submitTitle editTitle:editTitle showEditTitle:YES clickSubmitTitleHandle:^(UIButton * _Nonnull button) {
        button.selected = !button.selected;
        !clickSubmitTitleBlock ?: clickSubmitTitleBlock();
    } clickEditTitleHandle:^(UIButton * _Nonnull button) {
        button.selected = !button.selected;
        !clickEditTitleBlock ?: clickEditTitleBlock();
    }];

    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
    self.navigationItem.rightBarButtonItems = @[rightBarButtonItem];
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
