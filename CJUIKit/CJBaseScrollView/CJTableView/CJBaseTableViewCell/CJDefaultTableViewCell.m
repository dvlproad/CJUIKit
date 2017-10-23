//
//  CJDefaultTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/06/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJDefaultTableViewCell.h"

@implementation CJDefaultTableViewCell

- (void)cjBaseTableViewCell_commonInit {
    self.showCJImageView = YES;
    [self addCJImageView];
    [self addCJTextLabelWithType:UITableViewCellStyleDefault];
    [self addCJSeparateLineView];
}

@end
