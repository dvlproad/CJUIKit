//
//  CJSubTitleTabelViewCell+ConfigureForDataModel.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJSubTitleTabelViewCell+ConfigureForDataModel.h"

@implementation CJSubTitleTabelViewCell (ConfigureForDataModel)

- (void)configureForDataModel:(TestDataModel *)dataModel {
    self.cjImageView.image = [UIImage imageNamed:@"icon.png"];
    
    self.cjTextLabel.text = dataModel.name;
    self.cjDetailTextLabel.text = dataModel.nickname;
}

@end
