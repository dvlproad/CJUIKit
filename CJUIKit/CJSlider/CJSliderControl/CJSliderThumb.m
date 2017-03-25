//
//  CJSliderThumb.m
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJSliderThumb.h"

@implementation CJSliderThumb


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setupUI];
    }
    
    return self;
}

- (void)setupUI {
    
    self.adjustsImageWhenHighlighted = NO;
    
    [self setImage:[UIImage imageNamed:@"slider_thumbImage"]
          forState:UIControlStateNormal];
    [self setImage:[UIImage imageNamed:@"slider_thumbImage"]
          forState:UIControlStateSelected];
}

- (void)sizeToFit {
    CGRect frame = self.frame;
    frame.size = [self backgroundImageForState:UIControlStateNormal].size;
    self.frame = frame;
}

#pragma mark - Getter and Setter

-(void)setNormalImage:(UIImage *)normalImage {
    
    [self setImage:normalImage forState:UIControlStateNormal];
}

-(void)setSelectedImage:(UIImage *)selectedImage {
    
    [self setImage:selectedImage forState:UIControlStateSelected];
}

-(void)setThumbStatus:(BOOL)isNormal {
    
    _isNormal = isNormal;
    
    if (isNormal) {
        
        [self setImage:[UIImage imageNamed:@"slider_double_thumbImage_a"] forState:UIControlStateNormal];
    } else {
        
        [self setImage:[UIImage imageNamed:@"slider_double_thumbImage_b"] forState:UIControlStateNormal];
    }
}



@end
