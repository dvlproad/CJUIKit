//
//  CQBaseImageView.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQBaseImageView.h"
#import "UIImageView+CQUtil.h"

@implementation CQBaseImageView

- (void)updateImageWithUrl:(nullable NSString *)imageUrl {
    [self cq_setImageWithUrl:imageUrl];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
