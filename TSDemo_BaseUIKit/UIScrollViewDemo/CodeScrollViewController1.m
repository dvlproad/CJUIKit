//
//  CodeScrollViewController1.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2015/12/23.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CodeScrollViewController1.h"
#import "TSButtonFactory.h"

@interface CodeScrollViewController1 ()

@end

@implementation CodeScrollViewController1

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.scrollView.backgroundColor = [UIColor yellowColor];
    self.containerView.backgroundColor = [UIColor greenColor];
    //self.scrollView.showsVerticalScrollIndicator = NO;
    //self.scrollView.showsHorizontalScrollIndicator = NO;
    //self.scrollView.alwaysBounceVertical = YES;
    
//    [self updateScrollHeightWithBottomInterval:1 accordingToLastBottomView:nil];
    
    UIButton *blueButton = [TSButtonFactory themeBGButton];
    [self.containerView addSubview:blueButton];
    [blueButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.containerView).mas_offset(20);
        make.right.mas_equalTo(self.containerView).mas_offset(-20);
        make.top.mas_equalTo(self.containerView).mas_offset(120);
        make.height.mas_equalTo(44);
    }];
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
