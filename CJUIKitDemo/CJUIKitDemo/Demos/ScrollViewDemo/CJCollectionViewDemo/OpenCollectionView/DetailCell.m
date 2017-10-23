//
//  DetailCell.m
//  CJCollectionViewDemo
//
//  Created by ciyouzen on 16/3/8.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "DetailCell.h"


@implementation DetailCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

/*
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    if (self)
    {
        _labDetail = [[UILabel alloc]initWithFrame:CGRectZero];
        _labDetail.textAlignment = NSTextAlignmentCenter;
        _labDetail.textColor = [UIColor blueColor];
        _labDetail.font = [UIFont systemFontOfSize:15];
        _labDetail.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_labDetail];
        _labDetail.translatesAutoresizingMaskIntoConstraints = NO;
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_labDetail
                                                         attribute:NSLayoutAttributeCenterX
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeCenterX
                                                        multiplier:1
                                                          constant:0]];//水平居中
        [self addConstraint:[NSLayoutConstraint constraintWithItem:_labDetail
                                                         attribute:NSLayoutAttributeBottom
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:self
                                                         attribute:NSLayoutAttributeBottom
                                                        multiplier:1
                                                          constant:0]];//距离底0
        [_labDetail addConstraint:[NSLayoutConstraint constraintWithItem:_labDetail
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:0
                                                          constant:20]];//高为20
    }
    
    return self;
}
*/


@end
