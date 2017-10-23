//
//  CJRightDetailTableViewCell.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/06/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJRightDetailTableViewCell.h"

@implementation CJRightDetailTableViewCell

- (void)cjBaseTableViewCell_commonInit {
    self.showCJImageView = YES;
    [self addCJImageView];
    [self addCJTextLabelWithType:UITableViewCellStyleValue2];
    [self addCJDetailTextLabelWithType:UITableViewCellStyleValue2];
    [self addCJSeparateLineView];
}

@end
