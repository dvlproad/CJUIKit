//
//  CJDefaultTableViewCell+ConfigureForDataModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDefaultTableViewCell+ConfigureForDataModel.h"

@implementation CJDefaultTableViewCell (ConfigureForDataModel)

- (void)configureForDataModel:(TestDataModel *)dataModel {
    self.showCJImageView = YES;
    [self.cjBadgeButton setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
    [self.cjBadgeButton setTitle:@"年" forState:UIControlStateNormal];
    [self.cjBadgeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.cjBadgeButton.layer.cornerRadius = 10;
    self.cjBadgeButton.badge = 100;
    
    self.cjTextLabel.text = dataModel.name;
}

@end
