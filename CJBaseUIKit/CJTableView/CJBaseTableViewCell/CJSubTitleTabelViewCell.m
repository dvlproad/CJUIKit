//
//  CJSubTitleTabelViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/06/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJSubTitleTabelViewCell.h"

@implementation CJSubTitleTabelViewCell

- (void)cjBaseTableViewCell_commonInit {
    self.showCJImageView = YES;
    [self addCJImageView];
    [self addCJTextLabelWithType:UITableViewCellStyleSubtitle];
    [self addCJDetailTextLabelWithType:UITableViewCellStyleSubtitle];
    [self addCJSeparateLineView];
}

@end
