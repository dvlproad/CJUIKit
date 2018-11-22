//
//  SystemComposeViewController.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2018/10/10.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "SystemComposeViewController.h"
#import "UIViewController+CJSystemComposeView.h"

#import "AChildViewController.h"
#import "BChildViewController.h"
#import "CChildViewController.h"
#import "DChildViewController.h"
#import "EChildViewController.h"
#import "FChildViewController.h"

@interface SystemComposeViewController ()

@end

@implementation SystemComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"SystemComposeView", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *sliderRadioButtons = [UIButton buttonWithType:UIButtonTypeCustom];
    [sliderRadioButtons setFrame:CGRectMake(50, 100, 200, 40)];
    [sliderRadioButtons setBackgroundColor:[UIColor colorWithRed:0.4 green:0.3 blue:0.4 alpha:0.5]];
    [sliderRadioButtons setTitle:@"暂替sliderRadioButtons" forState:UIControlStateNormal];
    [sliderRadioButtons setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [sliderRadioButtons.titleLabel setFont:[UIFont systemFontOfSize:14]];
    [sliderRadioButtons addTarget:self action:@selector(changeShowViewIndex:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:sliderRadioButtons];
    [sliderRadioButtons mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view).mas_offset(20);
        make.right.mas_equalTo(self.view).mas_offset(-20);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(44);
    }];
    
    UIView *composeView = [[UIView alloc] init];
    [self.view addSubview:composeView];
    [composeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(sliderRadioButtons.mas_bottom);
        make.left.right.mas_equalTo(self.view);
        make.bottom.mas_equalTo(self.view);
    }];
    self.cjComposeView = composeView;
    
    NSArray *vcs = @[[[AChildViewController alloc] init],
                     [[BChildViewController alloc] init],
                     [[CChildViewController alloc] init],
                     [[DChildViewController alloc] init],
                     [[EChildViewController alloc] init],
                     [[FChildViewController alloc] init]
                     ];
    self.cjComponentViewControllers = [NSMutableArray arrayWithArray:vcs];
}

- (IBAction)changeShowViewIndex:(id)sender {
    NSLog(@"---------------------");
    NSInteger viewControllerCount = [self.cjComponentViewControllers count];
    NSInteger newIndex = rand()%viewControllerCount;
    [self cjReplaceChildViewControllerIndex:self.cjCurrentSelectedIndex newChildViewControllerIndex:newIndex completeBlock:^(NSInteger index_cur) {
//        [self doSomethingToCon_whereIndex:index_cur];
    }];
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
