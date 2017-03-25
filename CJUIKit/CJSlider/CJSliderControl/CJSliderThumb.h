//
//  CJSliderThumb.h
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CJSliderThumb : UIButton


@property (nonatomic, strong) UIImage *normalImage;

@property (nonatomic, strong) UIImage *selectedImage;

@property (nonatomic, assign, setter=setThumbStatus:) BOOL isNormal;
@end
