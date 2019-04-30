//
//  CJBaseTableViewCell+ConfigureForDataModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/1/25.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CJBaseTableViewCell+ConfigureForDataModel.h"

@implementation CJBaseTableViewCell (ConfigureForDataModel)


- (void)default_configureForDataModel:(TestDataModel *)dataModel {
    self.showCJImageView = YES;
    [self.cjBadgeButton setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
    [self.cjBadgeButton setTitle:@"年年年年" forState:UIControlStateNormal];
    [self.cjBadgeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    self.cjBadgeButton.layer.cornerRadius = 10;
    self.cjBadgeButton.badge = 100;
    
    self.cjTextLabel.text = dataModel.name;
}

- (void)leftDetail_configureForDataModel:(TestDataModel *)dataModel {
    [self.cjBadgeButton setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
    
    self.cjTextLabel.text = dataModel.name;
    self.cjDetailTextLabel.text = dataModel.nickname;
    
    self.cjTextLabelWidth = 25;
}

- (void)rightDetail_configureForDataModel:(TestDataModel *)dataModel {
    [self.cjBadgeButton setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
    
    self.cjTextLabel.text = dataModel.name;
    self.cjDetailTextLabel.text = dataModel.nickname;
    
    self.cjTextLabelWidth = 40;
}

- (void)subTitle_configureForDataModel:(TestDataModel *)dataModel {
    [self.cjBadgeButton setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
    
    self.cjTextLabel.text = dataModel.name;
    self.cjDetailTextLabel.text = dataModel.nickname;
}

@end
