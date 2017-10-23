//
//  CJBaseCollectionViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJBaseCollectionViewCell.h"

@interface CJBaseCollectionViewCell ()


@end


@implementation CJBaseCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self cjBaseCollectionViewCell_commonInit];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self cjBaseCollectionViewCell_commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self cjBaseCollectionViewCell_commonInit];
        
    }
    return self;
}

- (void)cjBaseCollectionViewCell_commonInit {
    //在子类中对init做具体实现
}

/**
 *  添加cjTextLabel和cjImageView（一个图片占满，文字在中的collectionViewCell）
 *
 *  @param imageViewEdgeInsets  cjImageView的edgeInsets
 */
- (void)addCenterTextLabelAndFullImageViewWithEdgeInsets:(UIEdgeInsets)imageViewEdgeInsets {
    [self addCJImageViewWithEdgeInsets:imageViewEdgeInsets];
    [self addCJTextLabelWithPosition:CJTextLabelPositionCenter];
}

/**
 *  添加cjTextLabel和cjImageView（一个文字在上，图片占满的collectionViewCell）
 *
 *  @param imageViewEdgeInsets  cjImageView的edgeInsets
 */
- (void)addTopTextLabelAndFullImageViewWithEdgeInsets:(UIEdgeInsets)imageViewEdgeInsets {
    [self addCJTextLabelWithPosition:CJTextLabelPositionTop];
    [self addCJImageViewWithEdgeInsets:imageViewEdgeInsets];
}

/**
 *  添加cjTextLabel和cjImageView（一个文字在上，图片在下的collectionViewCell）
 *
 *  @param space                cjTextLabel和cjImageView之间的间隔
 */
- (void)addTopTextLabelAndBottomImageViewWithSpace:(CGFloat)space {
    [self addCJTextLabelWithPosition:CJTextLabelPositionTop];
    
    UIView *parentView = self.contentView;
    
    self.cjImageView = [[UIImageView alloc] init];
    self.cjImageView.contentMode = UIViewContentModeScaleToFill;
    [parentView addSubview:self.cjImageView];
    self.cjImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.cjTextLabel
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:space]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];
}

/**
 *  添加cjTextLabel和cjImageView（一个文字在下，图片占满的collectionViewCell）
 *
 *  @param imageViewEdgeInsets  cjImageView的edgeInsets
 */
- (void)addBottomTextLabelAndFullImageViewWithEdgeInsets:(UIEdgeInsets)imageViewEdgeInsets {
    [self addCJImageViewWithEdgeInsets:imageViewEdgeInsets];
    [self addCJTextLabelWithPosition:CJTextLabelPositionBottom];
}


/**
 *  添加cjTextLabel和cjImageView（图片在中，一个文字在指定位置的collectionViewCell）
 *
 *  @param textLabelPosition    cjTextLabel的textLabelPosition
 *  @param space                cjTextLabel和cjImageView之间的间隔
 */
- (void)addCenterImageViewWithImageViewSize:(CGSize)imageViewSize
                      textLabelWithPosition:(CJTextLabelPosition)textLabelPosition
                                      space:(CGFloat)space
{
    [self addCenterImageViewWithSize:imageViewSize];
    
    UIView *parentView = self.contentView;
    
    self.cjTextLabel = [[UILabel alloc] init];
    self.cjTextLabel.textAlignment = NSTextAlignmentCenter;
    [parentView addSubview:self.cjTextLabel];
    self.cjTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:10]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:-10]];
    
    switch (textLabelPosition) {
        case CJTextLabelPositionCenter:
        {
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeTop    //top
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeTop
                                         multiplier:1
                                           constant:0]];
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeBottom //bottom
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeBottom
                                         multiplier:1
                                           constant:0]];
            break;
        }
        case CJTextLabelPositionTop:
        {
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeBottom    //bottom
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.cjImageView
                                          attribute:NSLayoutAttributeTop
                                         multiplier:1
                                           constant:-space]];
            
            self.cjTextLabelHeightConstraint =
            [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                         attribute:NSLayoutAttributeHeight //height
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1
                                          constant:30];
            [parentView addConstraint:self.cjTextLabelHeightConstraint];
            
            break;
        }
        case CJTextLabelPositionBottom:
        default:
        {
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeTop //top
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.cjImageView
                                          attribute:NSLayoutAttributeBottom
                                         multiplier:1
                                           constant:space]];
            self.cjTextLabelHeightConstraint =
            [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                         attribute:NSLayoutAttributeHeight //height
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1
                                          constant:30];
            [parentView addConstraint:self.cjTextLabelHeightConstraint];
            break;
        }
    }
}


#pragma mark - 添加单个的方法
/**
 *  添加cjTextLabel
 *
 *  @param textLabelPosition    cjTextLabel的textLabelPosition
 */
- (void)addCJTextLabelWithPosition:(CJTextLabelPosition)textLabelPosition {
    UIView *parentView = self.contentView;
    
    self.cjTextLabel = [[UILabel alloc] init];
    self.cjTextLabel.textAlignment = NSTextAlignmentCenter;
    [parentView addSubview:self.cjTextLabel];
    self.cjTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:10]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:-10]];
    
    switch (textLabelPosition) {
        case CJTextLabelPositionCenter:
        {
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeTop    //top
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeTop
                                         multiplier:1
                                           constant:0]];
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeBottom //bottom
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeBottom
                                         multiplier:1
                                           constant:0]];
            break;
        }
        case CJTextLabelPositionTop:
        {
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeTop    //top
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeTop
                                         multiplier:1
                                           constant:0]];
            
            self.cjTextLabelHeightConstraint =
            [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                         attribute:NSLayoutAttributeHeight //height
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1
                                          constant:30];
            [parentView addConstraint:self.cjTextLabelHeightConstraint];
            
            break;
        }
        case CJTextLabelPositionBottom:
        default:
        {
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeBottom //bottom
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeBottom
                                         multiplier:1
                                           constant:0]];
            self.cjTextLabelHeightConstraint =
            [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                         attribute:NSLayoutAttributeHeight //height
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1
                                          constant:30];
            [parentView addConstraint:self.cjTextLabelHeightConstraint];
            break;
        }
    }
}

/**
 *  添加cjImageView
 *
 *  @param edgeInsets    cjImageView的edgeInsets
 */
- (void)addCJImageViewWithEdgeInsets:(UIEdgeInsets)edgeInsets {
    UIView *parentView = self.contentView;
    
    self.cjImageView = [[UIImageView alloc] init];
    self.cjImageView.contentMode = UIViewContentModeScaleToFill;
    [parentView addSubview:self.cjImageView];
    self.cjImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:edgeInsets.left]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:edgeInsets.right]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:edgeInsets.top]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:edgeInsets.bottom]];
}


/**
 *  添加cjImageView
 *
 *  @param imageViewSize    cjImageView和size
 */
- (void)addCenterImageViewWithSize:(CGSize)imageViewSize {
    UIView *parentView = self.contentView;
    
    self.cjImageView = [[UIImageView alloc] init];
    self.cjImageView.contentMode = UIViewContentModeScaleToFill;
    [parentView addSubview:self.cjImageView];
    self.cjImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeCenterX    //centerX
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeCenterX
                                 multiplier:1
                                   constant:0]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeCenterY //centerY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                   constant:0]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeWidth   //width
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:imageViewSize.width]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeHeight  //height
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:imageViewSize.height]];
}





/**
 *  添加cjTextLabel和cjImageView（一个文字在下，图片在上的collectionViewCell）
 *
 *  @param space                cjTextLabel和cjImageView之间的间隔
 */
- (void)addBottomTextLabelAndTopImageViewWithSpace:(CGFloat)space {
    [self addCJTextLabelWithPosition:CJTextLabelPositionBottom];
    
    UIView *parentView = self.contentView;
    
    self.cjImageView = [[UIImageView alloc] init];
    self.cjImageView.contentMode = UIViewContentModeScaleToFill;
    [parentView addSubview:self.cjImageView];
    self.cjImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:0]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjImageView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self.cjTextLabel
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:-space]];
}


/**
 *  添加cjDeleteButton
 *
 */
- (void)addCJDeleteButton {
    UIView *parentView = self.contentView;
    self.cjDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cjDeleteButton setImage:[UIImage imageNamed:@"cjCollectionViewCellDelete"] forState:UIControlStateNormal];
    [self.cjDeleteButton addTarget:self action:@selector(deleteButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [parentView addSubview:self.cjDeleteButton];
    self.cjDeleteButton.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjDeleteButton
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:0]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjDeleteButton
                                  attribute:NSLayoutAttributeHeight //height
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:25]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjDeleteButton
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjDeleteButton
                                  attribute:NSLayoutAttributeWidth   //width
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:25]];
    //[self.contentView bringSubviewToFront:self.cjDeleteButton];
}


- (void)deleteButtonAction:(UIButton *)sender {
    if (self.deleteHandle) {
        self.deleteHandle(self);
    }
}

@end
