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

- (void)cjBaseCollectionViewCell_commonInit {
    [super cjBaseCollectionViewCell_commonInit];
    
    UIView *parentView = self.contentView;
    
    [self addCJImageViewWithEdgeInsets:UIEdgeInsetsZero];
    self.cjImageView.image = [UIImage imageNamed:@"cjCollectionViewCellAdd"];
    [self addCJDeleteButton];
    
    self.uploadProgressView = [[CJUploadProgressView alloc] initWithFrame:CGRectZero];
    [self cj_makeView:parentView addSubView:self.uploadProgressView withEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 0)];
    
    [parentView bringSubviewToFront:self.cjDeleteButton]; //把cjDeleteButton移动最前
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


@end
