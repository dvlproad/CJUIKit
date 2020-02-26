//
//  BadgeButtonViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "BadgeButtonViewController.h"
#import "UIColor+CJHex.h"
#import "CJBadgeButton.h"

@interface BadgeButtonViewController ()

@end

@implementation BadgeButtonViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"CJBadgeButton", nil);
    
    CJBadgeButton *badgeButton = [self defaultBadgeButton];
    [self.view addSubview:badgeButton];
    [badgeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.view);
        make.top.mas_equalTo(self.view).mas_offset(100);
        make.height.mas_equalTo(60);
    }];
    [badgeButton setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
    [badgeButton setTitle:@"年年年年" forState:UIControlStateNormal];
    [badgeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [badgeButton addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    badgeButton.badge = 100;
    
    CJBadgeButton *badgeButton2 = [self goDeliverBadgeButton];
    [self.view addSubview:badgeButton2];
    [badgeButton2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(badgeButton.mas_bottom).mas_offset(40);
        make.centerX.mas_equalTo(self.view);
        make.width.mas_equalTo(104+5);
        make.height.mas_equalTo(104);
    }];
    [badgeButton2 setTitle:NSLocalizedString(@"去配送", nil) forState:UIControlStateNormal];
    [badgeButton2 addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    badgeButton2.badge = 6;
}

- (void)buttonAction {
    NSLog(@"点击照片");
}


#pragma mark - Private Method
- (CJBadgeButton *)defaultBadgeButton {
    CJBadgeButton *badgeButton = [CJBadgeButton buttonWithType:UIButtonTypeCustom];
    badgeButton.badgeLabel.backgroundColor = [UIColor redColor];
    badgeButton.badgeLabel.textColor = [UIColor whiteColor];
    badgeButton.layer.cornerRadius = 10;
    
    return badgeButton;
}

- (CJBadgeButton *)goDeliverBadgeButton {
    CJBadgeButton *badgeButton = [CJBadgeButton buttonWithType:UIButtonTypeCustom];
    badgeButton.backgroundColor = [UIColor cyanColor];
    badgeButton.badgeLabel.backgroundColor = [UIColor redColor];
    badgeButton.badgeLabel.textColor = [UIColor whiteColor];
    badgeButton.badgeLabel.font = [UIFont boldSystemFontOfSize:17];
    badgeButton.badgeLabel.layer.cornerRadius = 3;
    badgeButton.badgeLabelTop = 5;
    badgeButton.badgeLabelRight = 0;
    badgeButton.badgeLabelWidth = 40;
    badgeButton.badgeLabelHeight = 23;
    [badgeButton setImage:[UIImage imageNamed:@"badgeButton_normal"] forState:UIControlStateNormal];
    [badgeButton setImage:[UIImage imageNamed:@"badgeButton_highlighted"] forState:UIControlStateHighlighted];
    badgeButton.titleLabel.font = [UIFont systemFontOfSize:18];
    [badgeButton setTitleEdgeInsets:UIEdgeInsetsMake(44, -104, 0, 0)];
    
    return badgeButton;
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
