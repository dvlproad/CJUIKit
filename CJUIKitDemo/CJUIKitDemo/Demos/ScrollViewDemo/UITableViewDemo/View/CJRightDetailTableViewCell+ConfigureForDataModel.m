//
//  CJRightDetailTableViewCell+ConfigureForDataModel.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/11/13.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJRightDetailTableViewCell+ConfigureForDataModel.h"

@implementation CJRightDetailTableViewCell (ConfigureForDataModel)

- (void)configureForDataModel:(TestDataModel *)dataModel {
    self.cjImageView.image = [UIImage imageNamed:@"icon.png"];
    
    self.cjTextLabel.text = dataModel.name;
    self.cjDetailTextLabel.text = dataModel.nickname;
    
    self.cjTextLabelWidth = 40;
}

@end
