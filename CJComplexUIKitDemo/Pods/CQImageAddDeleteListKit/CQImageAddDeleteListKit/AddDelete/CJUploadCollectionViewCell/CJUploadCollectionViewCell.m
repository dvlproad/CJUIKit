//
//  CJUploadCollectionViewCell.m
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJUploadCollectionViewCell.h"

@interface CJUploadCollectionViewCell () {
    
}

@end

@implementation CJUploadCollectionViewCell

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self commonInit];
        
    }
    return self;
}

- (void)commonInit {
    UIView *parentView = self.contentView;
    
    [self addCJImageViewWithEdgeInsets:UIEdgeInsetsZero];
    self.cjImageView.image = [UIImage imageNamed:@"CQImageAddDeleteListKit_AddDeleteBundle.bundle/cjCollectionViewCellAdd"];
    [self addCJDeleteButton];
    
    [parentView bringSubviewToFront:self.cjDeleteButton]; //把cjDeleteButton移动最前
}

/**
 *  添加cjTextLabel和cjImageView（一个文字在下，图片占满的collectionViewCell）
 *
 *  @param imageViewEdgeInsets  cjImageView的edgeInsets
 */
- (void)addBottomTextLabelAndFullImageViewWithEdgeInsets:(UIEdgeInsets)imageViewEdgeInsets {
    [self addCJImageViewWithEdgeInsets:imageViewEdgeInsets];
    [self addCJTextLabelWithBottomPosition];
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
 *  添加cjTextLabel
 */
- (void)addCJTextLabelWithBottomPosition {
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
}

/**
 *  添加cjDeleteButton
 *
 */
- (void)addCJDeleteButton {
    UIView *parentView = self.contentView;
    self.cjDeleteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.cjDeleteButton setImage:[UIImage imageNamed:@"CQImageAddDeleteListKit_AddDeleteBundle.bundle/cjCollectionViewCellDelete"] forState:UIControlStateNormal];
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


#pragma mark - addSubView
- (void)cj_makeView:(UIView *)superView addSubView:(UIView *)subView withEdgeInsets:(UIEdgeInsets)edgeInsets {
    [superView addSubview:subView];
    subView.translatesAutoresizingMaskIntoConstraints = NO;
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:edgeInsets.left]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:edgeInsets.right]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:edgeInsets.top]];
    
    [superView addConstraint:
     [NSLayoutConstraint constraintWithItem:subView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:superView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:edgeInsets.bottom]];
}

- (void)deleteButtonAction:(UIButton *)sender {
    if (self.deleteHandle) {
        self.deleteHandle(self);
    }
}


@end
