//
//  CJLeftDetailTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/06/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJLeftDetailTableViewCell.h"

@implementation CJLeftDetailTableViewCell

- (void)cjBaseTableViewCell_commonInit {
    self.showCJImageView = YES;
    [self addCJImageView];
    [self addCJTextLabelWithType:UITableViewCellStyleValue1];
    [self addCJDetailTextLabelWithType:UITableViewCellStyleValue1];
    [self addCJSeparateLineView];
}

@end
