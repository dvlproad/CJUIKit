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

/**
 *  左图片、右文字时候
 *
 *  @param spacing          图片与文字的间隔
 *  @param leftOffset       视图与左边缘的距离
 */
- (void)cjLeftImageOffset:(CGFloat)leftOffset imageAndTitleSpacing:(CGFloat)spacing
{
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft; //水平左对齐
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //垂直居中对齐
    /**
     * 按照上面的操作 按钮的内容对津贴屏幕左边缘 不美观 可以添加一下代码实现间隔已达到美观
     * UIEdgeInsetsMake(CGFloat top, CGFloat left, CGFloat bottom, CGFloat right)
     *    top: 为正数：表示向下偏移  为负数：表示向上偏移
     *   left: 为整数：表示向右偏移  为负数：表示向左偏移
     * bottom: 为整数：表示向上偏移  为负数：表示向下偏移
     *  right: 为整数：表示向左偏移  为负数：表示向右偏移
     *
     **/
    self.imageEdgeInsets = UIEdgeInsetsMake(0, leftOffset, 0, 0);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, leftOffset + spacing, 0, 0);
}

@end
