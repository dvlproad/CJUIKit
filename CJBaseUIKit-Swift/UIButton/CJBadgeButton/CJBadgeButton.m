//
//  CJBadgeButton.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/06/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJBadgeButton.h"

@interface CJBadgeButton () {

}
@property (nonatomic) NSLayoutConstraint *badgeLabelTopConstraint;
@property (nonatomic) NSLayoutConstraint *badgeLabelRightConstraint;
@property (nonatomic) NSLayoutConstraint *badgeLabelWidthConstraint;
@property (nonatomic) NSLayoutConstraint *badgeLabelHeightConstraint;

@end


@implementation CJBadgeButton

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self cjImageView_CommonInit];
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self cjImageView_CommonInit];
    }
    return self;
}

- (void)cjImageView_CommonInit {
    self.backgroundColor = [UIColor clearColor];
    self.layer.masksToBounds = YES;
    self.clipsToBounds = YES;
    
    self.badgeLabelTop = 0;
    self.badgeLabelRight = 0;
    self.badgeLabelWidth = 20;
    self.badgeLabelHeight = 20;
    
    _badgeLabel = [[UILabel alloc] init];
    _badgeLabel.textAlignment = NSTextAlignmentCenter;
    _badgeLabel.textColor = [UIColor whiteColor];
    _badgeLabel.backgroundColor = [UIColor redColor];
    _badgeLabel.font = [UIFont boldSystemFontOfSize:11];
    _badgeLabel.hidden = YES;
    _badgeLabel.layer.cornerRadius = self.badgeLabelHeight / 2;
    _badgeLabel.clipsToBounds = YES;
    [self addSubview:_badgeLabel];
    [self setupBadgeLabelConstraints];
}

#pragma mark - SetupConstraint
- (void)setupBadgeLabelConstraints {
    self.badgeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    
    //top
    self.badgeLabelTopConstraint =
     [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                  attribute:NSLayoutAttributeTop
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1.0
                                   constant:self.badgeLabelTop];
    [self addConstraint:self.badgeLabelTopConstraint];
    
    //right
    self.badgeLabelRightConstraint =
     [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                  attribute:NSLayoutAttributeRight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1.0
                                   constant:self.badgeLabelRight];
    [self addConstraint:self.badgeLabelRightConstraint];
    
    //width
    self.badgeLabelWidthConstraint =
    [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                 attribute:NSLayoutAttributeWidth
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:0
                                  constant:self.badgeLabelWidth];
    [self addConstraint:self.badgeLabelWidthConstraint];
    
    //height
    self.badgeLabelHeightConstraint =
     [NSLayoutConstraint constraintWithItem:self.badgeLabel
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:0
                                   constant:self.badgeLabelHeight];
    [self addConstraint:self.badgeLabelHeightConstraint];
}

- (void)setBadgeLabelTop:(CGFloat)badgeLabelTop {
    if (_badgeLabelTop != badgeLabelTop) {
        _badgeLabelTop = badgeLabelTop;
        self.badgeLabelTopConstraint.constant = badgeLabelTop;
//        [self removeConstraint:self.badgeLabelWidthConstraint];
//
//        self.badgeLabelWidthConstraint =
//        [NSLayoutConstraint constraintWithItem:self.badgeLabel
//                                     attribute:NSLayoutAttributeWidth
//                                     relatedBy:NSLayoutRelationEqual
//                                        toItem:nil
//                                     attribute:NSLayoutAttributeNotAnAttribute
//                                    multiplier:0
//                                      constant:self.badgeLabelWidth];
//        [self addConstraint:self.badgeLabelWidthConstraint];
    }
}

- (void)setBadgeLabelRight:(CGFloat)badgeLabelRight {
    _badgeLabelRight = badgeLabelRight;
    self.badgeLabelRightConstraint.constant = badgeLabelRight;
}

- (void)setBadgeLabelWidth:(CGFloat)badgeLabelWidth {
    _badgeLabelWidth = badgeLabelWidth;
    self.badgeLabelWidthConstraint.constant = badgeLabelWidth;
}

- (void)setBadgeLabelHeight:(CGFloat)badgeLabelHeight {
    _badgeLabelHeight = badgeLabelHeight;
    self.badgeLabelHeightConstraint.constant = badgeLabelHeight;
}

- (void)setBadge:(NSInteger)badge {
    _badge = badge;
    if (badge > 0) {
        self.badgeLabel.hidden = NO;
    } else {
        self.badgeLabel.hidden = YES;
    }
    
    if (badge > 99) {
        self.badgeLabel.text = @"99+";
        self.badgeLabel.font = [UIFont boldSystemFontOfSize:9];
                          
    } else {
        self.badgeLabel.text = [NSString stringWithFormat:@"%zd", (long)_badge];
    }
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
