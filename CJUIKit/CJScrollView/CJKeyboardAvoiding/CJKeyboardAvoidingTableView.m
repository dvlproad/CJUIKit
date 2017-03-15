//
//  CJKeyboardAvoidingTableView.m
//  AllScrollViewDemo
//
//  Created by lichq on 8/10/13.
//  Copyright (c) 2013 ciyouzen. All rights reserved.
//

#import "CJKeyboardAvoidingTableView.h"

@interface CJKeyboardAvoidingTableView () {
    
}

@end


@implementation CJKeyboardAvoidingTableView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)init {
    self = [super init];
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

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (void)dealloc {
    [self cj_unRegisterKeyboardNotifications];
}

- (void)commonInit {
    [self cj_registerKeyboardNotifications];
}

@end
