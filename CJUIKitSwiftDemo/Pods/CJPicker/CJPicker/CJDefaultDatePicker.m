//
//  CJDefaultDatePicker.m
//  CJPickerDemo
//
//  Created by ciyouzen on 6/20/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJDefaultDatePicker.h"

@implementation CJDefaultDatePicker

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];//NSDateFormatter的优化
        [_dateFormatter setDateFormat:@"yyyy-MM-dd"];
    }
    
    self.backgroundColor = [UIColor whiteColor];
    [self setFrame:CGRectMake(0, 0, 0, 260)];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectZero];
    //datePicker.backgroundColor = [UIColor whiteColor];
    [datePicker addTarget:self action:@selector(valueChangedAction:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:datePicker];
    datePicker.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:datePicker
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:datePicker
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:datePicker
                                  attribute:NSLayoutAttributeHeight //height
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:216]];  //UIDatePicker默认216的高
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:datePicker
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];

    self.datePicker = datePicker;
}

- (void)addToolbar:(UIToolbar *)toolbar {
    _toolbar = toolbar;
    
    [self addSubview:toolbar];
    toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:toolbar
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:toolbar
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:toolbar
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:toolbar
                                  attribute:NSLayoutAttributeHeight //height
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:44]];
}


/** datePicker值改变触发 */
- (void)valueChangedAction:(UIDatePicker *)datePicker {
    if (self.valueChangedHandel) {
        self.valueChangedHandel(datePicker);
    }
}


@end
