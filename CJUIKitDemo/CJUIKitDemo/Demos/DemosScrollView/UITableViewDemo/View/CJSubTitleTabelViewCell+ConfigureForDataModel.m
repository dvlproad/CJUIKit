//
//  CJSubTitleTabelViewCell+ConfigureForDataModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJSubTitleTabelViewCell+ConfigureForDataModel.h"

@implementation CJSubTitleTabelViewCell (ConfigureForDataModel)

- (void)configureForDataModel:(TestDataModel *)dataModel {
    [self.cjBadgeButton setBackgroundImage:[UIImage imageNamed:@"icon.png"] forState:UIControlStateNormal];
    
    self.cjTextLabel.text = dataModel.name;
    self.cjDetailTextLabel.text = dataModel.nickname;
}

@end
