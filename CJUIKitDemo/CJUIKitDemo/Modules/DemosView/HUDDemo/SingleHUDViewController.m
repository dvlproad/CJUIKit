//
//  SingleHUDViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/12/25.
//  Copyright © 2019 luckinteam. All rights reserved.
//

#import "SingleHUDViewController.h"
#include <CJBaseOverlayKit/CJProgressHUD.h>

@interface SingleHUDViewController ()

@property (nonatomic, strong) CJProgressHUD *hud;

@end

@implementation SingleHUDViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    CJProgressHUD *hud = [[CJProgressHUD alloc] initWithAnimationNamed:@"loading_tea"];
    [hud.lotAnimationView play];
    [self.view addSubview:hud];
    [hud mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    self.hud = hud;
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
