//
//  CJLineCell.m
//  CJCollectionViewDemo
//
//  Created by ciyouzen on 16/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJLineCell.h"

@interface CJLineCell () {
    NSLayoutConstraint *_lineHeightConstraint;
}

@end


@implementation CJLineCell

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    self.backgroundColor = [UIColor clearColor];
    if (self)
    {
        self.clipsToBounds = YES;
        _lineThick = 1;
        
        _line = [[UIView alloc]initWithFrame:CGRectZero];
        _line.backgroundColor = [UIColor redColor];
        [self.contentView addSubview:_line];
        [self layoutLine];
        
        
        _label = [[UILabel alloc]initWithFrame:CGRectZero];
        _label.textAlignment = NSTextAlignmentCenter;
        _label.textColor = [UIColor blueColor];
        _label.font = [UIFont systemFontOfSize:15];
        _label.backgroundColor = [UIColor greenColor];
        [self.contentView addSubview:_label];
        [self layoutLabel];
        
    }
    
    return self;
}


/**
 *  布局线条
 */
- (void)layoutLine {
    _line.translatesAutoresizingMaskIntoConstraints = NO;
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_line
                                                     attribute:NSLayoutAttributeLeft
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeLeft
                                                    multiplier:1
                                                      constant:10]];//距离左10
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_line
                                                     attribute:NSLayoutAttributeRight
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeRight
                                                    multiplier:1
                                                      constant:-10]];//距离右10
    
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_line
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];//竖直居中
    
    _lineHeightConstraint = [NSLayoutConstraint constraintWithItem:_line
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:0
                                                          constant:_lineThick];
    [_line addConstraint:_lineHeightConstraint];
}


/**
 *  布局文字
 */
- (void)layoutLabel {
    _label.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_label
                                                     attribute:NSLayoutAttributeCenterX
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterX
                                                    multiplier:1
                                                      constant:0]];//水平居中
    [self addConstraint:[NSLayoutConstraint constraintWithItem:_label
                                                     attribute:NSLayoutAttributeCenterY
                                                     relatedBy:NSLayoutRelationEqual
                                                        toItem:self
                                                     attribute:NSLayoutAttributeCenterY
                                                    multiplier:1
                                                      constant:0]];//竖直居中
}

/**
 *  设置线条的粗细
 *
 *  @param lineThick The thick you want to set to line.
 */
- (void)setLineThick:(CGFloat)lineThick {
    _lineThick = lineThick;
    _lineHeightConstraint.constant = _lineThick;
    [_line layoutIfNeeded];
}


@end
