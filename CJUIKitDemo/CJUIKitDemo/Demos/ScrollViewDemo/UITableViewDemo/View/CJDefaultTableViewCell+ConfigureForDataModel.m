//
//  CJDefaultTableViewCell+ConfigureForDataModel.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDefaultTableViewCell+ConfigureForDataModel.h"

@implementation CJDefaultTableViewCell (ConfigureForDataModel)

- (void)configureForDataModel:(TestDataModel *)dataModel {
    self.showCJImageView = YES;
    self.cjImageView.image = [UIImage imageNamed:@"icon.png"];
    self.cjImageView.badge = 100;
    self.cjImageView.title = @"年年年年";
    self.cjImageView.titleColor = [UIColor redColor];
    self.cjImageView.imageCornerRadius = 10;
    
    self.cjTextLabel.text = dataModel.name;
}

@end
