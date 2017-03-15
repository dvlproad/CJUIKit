//
//  CJKeyboardAvoidingScrollView.m
//  AllScrollViewDemo
//
//  Created by lichq on 8/10/13.
//  Copyright (c) 2013 ciyouzen. All rights reserved.
//

#import "CJKeyboardAvoidingScrollView.h"

@interface CJKeyboardAvoidingScrollView () {
    
}

@end


@implementation CJKeyboardAvoidingScrollView

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

- (void)dealloc {
    [self cj_unRegisterKeyboardNotifications];
}

- (void)commonInit {
    [self cj_registerKeyboardNotifications];
}

@end
