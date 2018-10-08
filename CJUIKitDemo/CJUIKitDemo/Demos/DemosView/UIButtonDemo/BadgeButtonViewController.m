//
//  BadgeButtonViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "BadgeButtonViewController.h"
#import "UIColor+CJHex.h"

@interface BadgeButtonViewController ()

@end

@implementation BadgeButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"CJBadgeButton", nil);
    self.view.backgroundColor = [UIColor whiteColor];
    
    CJBadgeButton *badgeButton = [ButtonFactory defaultBadgeButton];
    [self.view addSubview:badgeButton];
    [badgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(60);
    }];
    [badgeButton setImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
    badgeButton.badge = 100;
    [badgeButton setTitle:@"年年年年" forState:UIControlStateNormal];
    [badgeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    badgeButton.layer.cornerRadius = 10;
    [badgeButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonAction {
    NSLog(@"点击照片");
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
