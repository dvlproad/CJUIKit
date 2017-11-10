//
//  UIButton+CJUpDownStructure.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIButton+CJUpDownStructure.h"

@implementation UIButton (CJUpDownStructure)

/* 完整的描述请参见文件头部 */
- (void)cjVerticalImageAndTitle:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    NSString *text = self.titleLabel.text;
    UIFont *font = self.titleLabel.font;
    //CGSize textSize = [text sizeWithFont:font];
    CGSize textSize = [text boundingRectWithSize:CGSizeMake(FLT_MAX, FLT_MAX)
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:@{NSFontAttributeName:font} context:NULL].size;
    
    CGSize frameSize = CGSizeMake(ceilf(textSize.width), ceilf(textSize.height));
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalFrameHeight = (imageSize.height + spacing + titleSize.height);
    self.imageEdgeInsets = UIEdgeInsetsMake(-(totalFrameHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalFrameHeight - titleSize.height), 0);
}

@end
