//
//  CJLeftDetailTableViewCell+ConfigureForDataModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/13.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJLeftDetailTableViewCell+ConfigureForDataModel.h"

@implementation CJLeftDetailTableViewCell (ConfigureForDataModel)

- (void)configureForDataModel:(TestDataModel *)dataModel {
    [self.cjBadgeButton setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
    
    self.cjTextLabel.text = dataModel.name;
    self.cjDetailTextLabel.text = dataModel.nickname;
    
    self.cjTextLabelWidth = 25;
}

@end
