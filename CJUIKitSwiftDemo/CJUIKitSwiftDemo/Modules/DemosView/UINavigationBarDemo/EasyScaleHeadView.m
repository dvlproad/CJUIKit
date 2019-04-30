//
//  EasyScaleHeadView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/5/16.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "EasyScaleHeadView.h"

@implementation EasyScaleHeadView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.button.layer.masksToBounds = YES;
    self.button.layer.cornerRadius = CGRectGetHeight(self.frame)/2;
}

- (IBAction)doPortrait:(id)sender {
    NSLog(@"点击头像");
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
