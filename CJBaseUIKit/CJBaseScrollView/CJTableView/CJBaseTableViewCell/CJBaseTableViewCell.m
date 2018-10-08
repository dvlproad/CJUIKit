//
//  CJBaseTableViewCell.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/06/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJBaseTableViewCell.h"

#define kDefaultCJImageViewSize CGSizeMake(40, 40)  //默认cjBadgeButton的大小

static CGFloat kDefaultCJTableViewCellPadding = 10;
static CGFloat kDefaultCJTableViewCellTailingPadding = -40;
static CGFloat kDefaultCJTextLabelHeight = 20;
static CGFloat kDefaultCJDetailTextLabelHeight = 15;

@interface CJBaseTableViewCell () {
    
}
//cjBadgeButton
@property (nonatomic, strong) NSLayoutConstraint *cjImageViewLeftConstraint;
@property (nonatomic, strong) NSLayoutConstraint *cjImageViewWidthConstraint;
@property (nonatomic, strong) NSLayoutConstraint *cjImageViewHeightConstraint;

//cjDetailTextLabel
@property (nonatomic, strong) NSLayoutConstraint *cjDetailTextLabelWidthConstraint;

//cjSeparateLineView
@property (nonatomic, strong) UIView *cjSeparateLineView;

@end



@implementation CJBaseTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self cjBaseTableViewCell_commonInit];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

/** 完整的描述请参见文件头部 */
- (void)cjBaseTableViewCell_commonInit {
    UILongPressGestureRecognizer *longPressGR = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
    [self addGestureRecognizer:longPressGR];
}

- (void)longPressAction:(UILongPressGestureRecognizer *)longPress {
    if (longPress.state == UIGestureRecognizerStateBegan) {
        if(self.delegate && self.indexPath
           && [self.delegate respondsToSelector:@selector(cjBaseTableViewCell:longPress:atIndexPath:)]) {
            [_delegate cjBaseTableViewCell:self longPress:longPress atIndexPath:self.indexPath];
        }
    }
}

#pragma mark - setupViews
/** 完整的描述请参见文件头部 */
- (void)addCJSeparateLineView {
    UIView *parentView = self.contentView;
    
    _cjSeparateLineView = [[UIView alloc] init];
    _cjSeparateLineView.backgroundColor = [UIColor colorWithRed:207/255.0 green:210/255.0 blue:213/255.0 alpha:0.7];
    [parentView addSubview:_cjSeparateLineView];//不是添加到contentView，防止被原本的覆盖
    
    self.cjSeparateLineView.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjSeparateLineView
                                  attribute:NSLayoutAttributeBottom //Bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];
    
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjSeparateLineView
                                  attribute:NSLayoutAttributeHeight //height
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:1]];
    
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjSeparateLineView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjSeparateLineView
                                  attribute:NSLayoutAttributeRight //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
}

/** 完整的描述请参见文件头部 */
- (void)addCJImageView {
    UIView *parentView = self.contentView;
    
    self.cjBadgeButton = [[CJBadgeButton alloc] initWithFrame:CGRectZero];
    [parentView addSubview:self.cjBadgeButton];
    
    self.cjImageViewSize = kDefaultCJImageViewSize;
    self.cjBadgeButton.translatesAutoresizingMaskIntoConstraints = NO;
    [parentView addConstraint:
     [NSLayoutConstraint constraintWithItem:self.cjBadgeButton
                                  attribute:NSLayoutAttributeCenterY//centerY
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:parentView
                                  attribute:NSLayoutAttributeCenterY
                                 multiplier:1
                                   constant:0]];
    
    
    self.cjImageViewHeightConstraint =
    [NSLayoutConstraint constraintWithItem:self.cjBadgeButton
                                 attribute:NSLayoutAttributeHeight //height
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1
                                  constant:self.cjImageViewSize.height];
    [parentView addConstraint:self.cjImageViewHeightConstraint];
    
    self.cjImageViewLeftConstraint =
    [NSLayoutConstraint constraintWithItem:self.cjBadgeButton
                                 attribute:NSLayoutAttributeLeft   //left
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:parentView
                                 attribute:NSLayoutAttributeLeft
                                multiplier:1
                                  constant:kDefaultCJTableViewCellPadding];
    [parentView addConstraint:self.cjImageViewLeftConstraint];
    
    
    self.cjImageViewWidthConstraint =
    [NSLayoutConstraint constraintWithItem:self.cjBadgeButton
                                 attribute:NSLayoutAttributeWidth //width
                                 relatedBy:NSLayoutRelationEqual
                                    toItem:nil
                                 attribute:NSLayoutAttributeNotAnAttribute
                                multiplier:1
                                  constant:self.cjImageViewSize.width];
    [parentView addConstraint:self.cjImageViewWidthConstraint];
}

/** 完整的描述请参见文件头部 */
- (void)addCJTextLabelWithType:(UITableViewCellStyle)tableViewCellStyle {
    UIView *parentView = self.contentView;
    
    _cjTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [parentView addSubview:_cjTextLabel];
    self.cjTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    //left
    [parentView addConstraint:[NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                                           attribute:NSLayoutAttributeLeft
                                                           relatedBy:NSLayoutRelationEqual
                                                              toItem:self.cjBadgeButton
                                                           attribute:NSLayoutAttributeRight
                                                          multiplier:1
                                                            constant:kDefaultCJTableViewCellPadding]];
    
    switch (tableViewCellStyle) {
        case UITableViewCellStyleDefault:
        case UITableViewCellStyleValue1:    //leftDetail
        case UITableViewCellStyleValue2:    //rightDetail
        {
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeCenterY    //centerY
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeCenterY
                                         multiplier:1
                                           constant:0]];
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeHeight     //height
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeHeight
                                         multiplier:1
                                           constant:-kDefaultCJTableViewCellPadding]];
            if (tableViewCellStyle == UITableViewCellStyleDefault) {
                [parentView addConstraint:
                 [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                              attribute:NSLayoutAttributeRight //right
                                              relatedBy:NSLayoutRelationEqual
                                                 toItem:parentView
                                              attribute:NSLayoutAttributeRight
                                             multiplier:1
                                               constant:kDefaultCJTableViewCellTailingPadding]];
            } else if (tableViewCellStyle == UITableViewCellStyleValue1) {
                self.cjTextLabelWidthConstraint =
                [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                             attribute:NSLayoutAttributeWidth //width
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:nil
                                             attribute:NSLayoutAttributeNotAnAttribute
                                            multiplier:1
                                              constant:40];
                [parentView addConstraint:self.cjTextLabelWidthConstraint];
                
            } else if (tableViewCellStyle == UITableViewCellStyleValue2) {
                self.cjTextLabelWidthConstraint =
                [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                             attribute:NSLayoutAttributeWidth //width
                                             relatedBy:NSLayoutRelationEqual
                                                toItem:nil
                                             attribute:NSLayoutAttributeNotAnAttribute
                                            multiplier:1
                                              constant:100];
                [parentView addConstraint:self.cjTextLabelWidthConstraint];
            }
            
            break;
        }
        case UITableViewCellStyleSubtitle:
        {
            //cjTextLabel
            self.cjTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeBottom//bottom
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeCenterY
                                         multiplier:1
                                           constant:0]];
            
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeHeight //height
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:nil
                                          attribute:NSLayoutAttributeNotAnAttribute
                                         multiplier:1
                                           constant:kDefaultCJTextLabelHeight]];
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeRight //right
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeRight
                                         multiplier:1
                                           constant:kDefaultCJTableViewCellTailingPadding]];
            break;
        }
        default:
            break;
    }
}

/**
 *  添加cjDetailTextLabel
 *
 */
- (void)addCJDetailTextLabelWithType:(UITableViewCellStyle)tableViewCellStyle {
    UIView *parentView = self.contentView;
    
    //cjDetailTextLabel
    _cjDetailTextLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    _cjDetailTextLabel.backgroundColor = [UIColor clearColor];
    _cjDetailTextLabel.textColor = [UIColor lightGrayColor];
    _cjDetailTextLabel.font = [UIFont systemFontOfSize:14];
    [parentView addSubview:_cjDetailTextLabel];
    self.cjDetailTextLabel.translatesAutoresizingMaskIntoConstraints = NO;
    switch (tableViewCellStyle) {
        case UITableViewCellStyleValue1:
        {
            _cjDetailTextLabel.textAlignment = NSTextAlignmentLeft;
            
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjDetailTextLabel
                                          attribute:NSLayoutAttributeCenterY    //centerY
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeCenterY
                                         multiplier:1
                                           constant:0]];
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjDetailTextLabel
                                          attribute:NSLayoutAttributeHeight //height
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:nil
                                          attribute:NSLayoutAttributeNotAnAttribute
                                         multiplier:1
                                           constant:kDefaultCJDetailTextLabelHeight]];
            
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjDetailTextLabel
                                          attribute:NSLayoutAttributeLeft   //left
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeRight
                                         multiplier:1
                                           constant:0]];
            
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjDetailTextLabel
                                          attribute:NSLayoutAttributeRight //right
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeRight
                                         multiplier:1
                                           constant:kDefaultCJTableViewCellTailingPadding]];
            break;
        }
        case UITableViewCellStyleValue2:
        {
            _cjDetailTextLabel.textAlignment = NSTextAlignmentRight;
            
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjDetailTextLabel
                                          attribute:NSLayoutAttributeCenterY    //centerY
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeCenterY
                                         multiplier:1
                                           constant:0]];
            
            
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjDetailTextLabel
                                          attribute:NSLayoutAttributeHeight //height
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:nil
                                          attribute:NSLayoutAttributeNotAnAttribute
                                         multiplier:1
                                           constant:kDefaultCJDetailTextLabelHeight]];
            /*
             [self addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjDetailTextLabel
             attribute:NSLayoutAttributeLeft   //left
             relatedBy:NSLayoutRelationEqual
             toItem:self.cjTextLabel
             attribute:NSLayoutAttributeRight
             multiplier:1
             constant:kDefaultCJTableViewCellPadding]];
             */
            self.cjDetailTextLabelWidthConstraint =
            [NSLayoutConstraint constraintWithItem:self.cjDetailTextLabel
                                         attribute:NSLayoutAttributeWidth   //width
                                         relatedBy:NSLayoutRelationEqual
                                            toItem:nil
                                         attribute:NSLayoutAttributeNotAnAttribute
                                        multiplier:1
                                          constant:100];
            [parentView addConstraint:self.cjDetailTextLabelWidthConstraint];
            
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjDetailTextLabel
                                          attribute:NSLayoutAttributeRight //right
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeRight
                                         multiplier:1
                                           constant:kDefaultCJTableViewCellTailingPadding]];
            break;
        }
        case UITableViewCellStyleSubtitle:
        {
            _cjDetailTextLabel.textAlignment = NSTextAlignmentLeft;
            
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjDetailTextLabel
                                          attribute:NSLayoutAttributeTop    //top
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:parentView
                                          attribute:NSLayoutAttributeCenterY
                                         multiplier:1
                                           constant:0]];
            
            
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjDetailTextLabel
                                          attribute:NSLayoutAttributeHeight //height
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:nil
                                          attribute:NSLayoutAttributeNotAnAttribute
                                         multiplier:1
                                           constant:kDefaultCJDetailTextLabelHeight]];
            
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjDetailTextLabel
                                          attribute:NSLayoutAttributeLeft   //left
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeLeft
                                         multiplier:1
                                           constant:0]];
            
            [parentView addConstraint:
             [NSLayoutConstraint constraintWithItem:self.cjDetailTextLabel
                                          attribute:NSLayoutAttributeRight //right
                                          relatedBy:NSLayoutRelationEqual
                                             toItem:self.cjTextLabel
                                          attribute:NSLayoutAttributeRight
                                         multiplier:1
                                           constant:0]];
            break;
        }
        default:
        {
            [self.cjDetailTextLabel removeFromSuperview];
            break;
        }
    }
    
    [self bringSubviewToFront:self.cjDetailTextLabel];
}


#pragma mark - Setter
- (void)setShowCJImageView:(BOOL)showCJImageView {
    if (_showCJImageView != showCJImageView) {
        _showCJImageView = showCJImageView;
        
        if (showCJImageView) {
            self.cjBadgeButton.hidden = NO;
            self.cjImageViewLeftConstraint.constant = kDefaultCJTableViewCellPadding;
            self.cjImageViewWidthConstraint.constant = self.cjImageViewSize.width;
            
        } else {
            self.cjBadgeButton.hidden = YES;
            self.cjImageViewLeftConstraint.constant = 0;
            self.cjImageViewWidthConstraint.constant = 0;
        }
    }
}

- (void)setCjTextLabelWidth:(CGFloat)cjTextLabelWidth {
    _cjTextLabelWidth = cjTextLabelWidth;
    
    self.cjTextLabelWidthConstraint.constant = cjTextLabelWidth;
}

- (void)setCjDetailTextLabelWidth:(CGFloat)cjDetailTextLabelWidth {
    _cjDetailTextLabelWidth = cjDetailTextLabelWidth;
    
    self.cjDetailTextLabelWidthConstraint.constant = cjDetailTextLabelWidth;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if (self.cjBadgeButton.badge) {
        self.cjBadgeButton.badgeLabel.backgroundColor = [UIColor redColor];
    }
}

-(void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated{
    [super setHighlighted:highlighted animated:animated];
    
    if (self.cjBadgeButton.badge) {
        self.cjBadgeButton.badgeLabel.backgroundColor = [UIColor redColor];
    }
}


@end
