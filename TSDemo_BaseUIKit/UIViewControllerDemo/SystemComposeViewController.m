//
//  SystemComposeViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "SystemComposeViewController.h"
#import <CJBaseUIKit/UIViewController+CJSystemComposeView.h>
#import <CQBaseUIKit/CQHorizontalTabBar.h>
#import <Masonry/Masonry.h>

#import "DemoChildViewController.h"

@interface SystemComposeViewController ()

@property (nonatomic, strong) CQHorizontalTabBar *tabBar;

@end

@implementation SystemComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = NSLocalizedString(@"SystemComposeView", nil);
    self.view.backgroundColor = [UIColor whiteColor];

    [self setupViews];
}

- (void)setupViews {
    UIView *composeView = [[UIView alloc] init];
    [self.view addSubview:composeView];
    self.cjComposeView = composeView;

    NSArray *titles = @[
        NSLocalizedString(@"Home1第一页", nil),
        NSLocalizedString(@"Home2", nil),
        NSLocalizedString(@"Home3是佛恩", nil),
        NSLocalizedString(@"Home4", nil),
        NSLocalizedString(@"Home5", nil),
        NSLocalizedString(@"Home6", nil),
    ];

    NSMutableArray *vcs = [NSMutableArray array];
    for (NSString *title in titles) {
        DemoChildViewController *vc = [[DemoChildViewController alloc] initWithTitle:title];
        [vcs addObject:vc];
    }
    self.cjComponentViewControllers = vcs;

    __weak typeof(self) weakSelf = self;
    CQHorizontalTabBar *tabBar = [[CQHorizontalTabBar alloc] initWithTitles:titles tabSelectedBlock:^(NSInteger index) {
        __strong typeof(self) strongSelf = weakSelf;
        if (!strongSelf) return;

        NSInteger oldIndex = strongSelf.tabBar.selectedIndex;
        [strongSelf cjReplaceChildViewControllerIndex:oldIndex newChildViewControllerIndex:index completeBlock:^(NSInteger index_cur) {
            strongSelf.tabBar.selectedIndex = index;
        }];
    }];
    [self.view addSubview:tabBar];
    [tabBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.view.mas_safeAreaLayoutGuideTop);
        make.left.right.mas_equalTo(self.view);
        make.height.mas_equalTo(44);
    }];
    self.tabBar = tabBar;

    [self.cjComposeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.tabBar.mas_bottom);
        make.left.right.bottom.mas_equalTo(self.view);
    }];
}

@end
