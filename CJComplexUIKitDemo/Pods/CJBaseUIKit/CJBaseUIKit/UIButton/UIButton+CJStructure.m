//
//  UIButton+CJStructure.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/7/3.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIButton+CJStructure.h"

@implementation UIButton (CJStructure)

/**
 *  上图片、下文字(竖直排放)（调用前提：必须保证你的button的size已经确定后才能调用）
 *  @attention  也要保证Button的宽度一定要大于等于图片的宽
 *
 *  @param spacing 图片和文字的间隔为多少
 */
- (void)cjVerticalImageAndTitle:(CGFloat)spacing
{
    CGSize imageSize = self.imageView.frame.size;
    CGSize titleSize = self.titleLabel.frame.size;
    
    [self cjVerticalImageSize:imageSize spacing:spacing titleSize:titleSize];
}

/*
 *  上图片、下文字(竖直排放)（调用前提：必须保证你的button的size已经确定后才能调用）
 *  @attention  也要保证Button的宽度一定要大于等于图片的宽
 *
 *  @param imageSize    图片大小
 *  @param spacing      图片和文字的间隔为多少
 *  @param titleSize    文字大小
 */
- (void)cjVerticalImageSize:(CGSize)imageSize spacing:(CGFloat)spacing titleSize:(CGSize)titleSize
{
    NSString *text = self.titleLabel.text;
    UIFont *font = self.titleLabel.font;
    //CGSize textSize = [text sizeWithFont:font];
    CGSize maxSize = CGSizeMake(FLT_MAX, FLT_MAX);
    NSDictionary *attributes = @{NSFontAttributeName:font};
    CGRect textRect = [text boundingRectWithSize: maxSize
                                         options:NSStringDrawingUsesLineFragmentOrigin
                                      attributes:attributes context:NULL];
    CGSize textSize = textRect.size;
    CGFloat frameWidth = ceilf(textSize.width);
    CGFloat frameHeight = ceilf(textSize.height);
    CGSize frameSize = CGSizeMake(frameWidth, frameHeight);
    if (titleSize.width + 0.5 < frameSize.width) {
        titleSize.width = frameSize.width;
    }
    CGFloat totalFrameHeight = (imageSize.height + spacing + titleSize.height);
    CGFloat selfFrameHeight = CGRectGetHeight(self.frame);
    if (selfFrameHeight == 0) {
        NSLog(@"CJError:您的按钮高度高度未设置");
    } else {
        if (totalFrameHeight > selfFrameHeight) {
            NSLog(@"CJError:您的按钮高度太小不足以设置这个间隔,请给您的button高度至少为%.1f", totalFrameHeight);
        }
    }
    
    self.imageEdgeInsets = UIEdgeInsetsMake(-(totalFrameHeight - imageSize.height), 0.0, 0.0, - titleSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width, - (totalFrameHeight - titleSize.height), 0);
}

/**
 *  左图片、右文字(水平排放)
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

/**
 *  左文字、右图片(水平排放)
 *
 *  @param spacing          图片与文字的间隔
 *  @param rightOffset      视图与右边缘的距离
 */
- (void)cjLeftTextRightImageWithSpacing:(CGFloat)spacing
                            rightOffset:(CGFloat)rightOffset
{
    self.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight; //水平右对齐
    self.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter; //垂直居中对齐
    
    //文字的size
//    CGSize imageSize = self.imageView.frame.size;
//    CGSize titleSize = self.titleLabel.frame.size;
    CGSize imageSize = CGSizeMake(30, 30);
    CGSize titleSize = [self.titleLabel.text sizeWithAttributes:@{NSFontAttributeName:self.titleLabel.font}];//iOS7.0+

    self.imageEdgeInsets = UIEdgeInsetsMake(0, titleSize.width + spacing - imageSize.width, 0, -rightOffset- titleSize.width - spacing + imageSize.width);
    self.titleEdgeInsets = UIEdgeInsetsMake(0, - imageSize.width - spacing, 0, rightOffset + imageSize.width + spacing);
}
@end
