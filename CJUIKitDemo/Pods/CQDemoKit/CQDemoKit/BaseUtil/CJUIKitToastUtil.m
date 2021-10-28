//
//  CJUIKitToastUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUIKitToastUtil.h"

@implementation CJUIKitToastUtil

/// 在window的中心显示message信息
+ (void)showMessage:(NSString *)message {
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [self showToast:message inView:keyWindow centerOffset:CGPointZero];
}

/*
 *  在指定View上显示Toast信息(系统的 UIAlertController 没法同时弹出多个，但这里每个toast都是单独的视图)
 *
 *  @param text         要显示的信息
 *  @param superView    要显示在什么视图上
 *  @param centerOffset 弹框中心与视图中心的偏移(用于显示多个toast时候，能够都在界面上显示出来)
 */
+ (void)showToast:(NSString *)text inView:(nullable UIView *)superView centerOffset:(CGPoint)centerOffset {
    if (superView == nil) {
        superView = [UIApplication sharedApplication].keyWindow;
    }
    
    UILabel *label = [[UILabel alloc] init];
    UIColor *randomColor = [UIColor colorWithRed:arc4random()%255/256.0f green:arc4random()%255/256.0f blue:arc4random()%255/256.0f alpha:1.0f];
    label.backgroundColor = randomColor;
    //label.backgroundColor = [UIColor colorWithRed:.16 green:.17 blue:.21 alpha:.6];
    label.textColor = [UIColor whiteColor];
    label.layer.masksToBounds = YES;
    label.layer.cornerRadius = 6;
    label.font = [UIFont systemFontOfSize:14];
    label.text = text;
    label.numberOfLines = 0;
    
    // show
    [superView addSubview:label];
    
    // 布局方法1：
//    //计算textSize的方法1：有效
//    [label sizeToFit];
//    CGFloat textWidth1 = CGRectGetWidth(label.frame);
//    CGFloat textHeight1 = CGRectGetHeight(label.frame);
    //计算textSize的方法2：有效
    CGFloat maxTextWidth = [UIScreen mainScreen].bounds.size.width - 20;
    CGSize textSize = [self calculateTextSizeForText:text
                                        withFont:label.font
                                         maxSize:CGSizeMake(maxTextWidth, MAXFLOAT)
                                   lineBreakMode:NSLineBreakByWordWrapping
                                  paragraphStyle:nil];
    CGFloat textWidth = ceil(textSize.width) + 1;
    CGFloat textHeight = ceil(textSize.height) + 1;
    CGFloat textLabelCenterX = CGRectGetWidth(superView.frame)/2 - centerOffset.x;
    CGFloat textLabelCenterY = CGRectGetHeight(superView.frame)/2 - centerOffset.y;
    label.frame = CGRectMake(textLabelCenterX-textWidth/2,
                             textLabelCenterY-textHeight/2,
                             textWidth,
                             textHeight);
    // 布局方法2：
//    [label mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.mas_equalTo(superView).mas_offset(centerOffset.x);
//        make.centerY.mas_equalTo(superView).mas_offset(centerOffset.y);
//        make.left.mas_greaterThanOrEqualTo(superView).mas_offset(20);//让宽可以抗压缩
//    }];
    
    // hide
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [label removeFromSuperview];
    });
}


/*
 *  计算文本/富文本大小(假设最大宽高可以maxSize)
 *
 *  @param text             要计算的文本
 *  @param font             字符串的字体大小font
 *  @param maxSize          字符串允许占用的最大maxSize
 *  @param lineBreakMode    lineBreakMode
 *  @param paragraphStyle   paragraphStyle(可以为nil,为nil时候会用默认设置lineBreakMode)
 *
 *  @return 文本/富文本大小
 */
+ (CGSize)calculateTextSizeForText:(NSString *)text
                          withFont:(UIFont *)font
                           maxSize:(CGSize)maxSize
                     lineBreakMode:(NSLineBreakMode)lineBreakMode
                    paragraphStyle:(nullable NSMutableParagraphStyle *)paragraphStyle
{
    if (text.length == 0) {
        return CGSizeZero;
    }
    
    if ([self respondsToSelector:@selector(boundingRectWithSize:options:attributes:context:)]) {
        if (paragraphStyle == nil) {
            paragraphStyle = [[NSParagraphStyle defaultParagraphStyle] mutableCopy];
            paragraphStyle.lineBreakMode = lineBreakMode;
        }
        
        NSDictionary *attributes = @{NSParagraphStyleAttributeName: paragraphStyle,
                                     NSFontAttributeName:           font,
                                     //NSForegroundColorAttributeName:textColor
                                     //NSKernAttributeName:           @1.5f       //字体间距
                                     };
        
        NSStringDrawingOptions options = NSStringDrawingUsesLineFragmentOrigin;
        
        CGRect textRect = [text boundingRectWithSize:maxSize
                                             options:options
                                          attributes:attributes
                                             context:nil];
        CGSize size = textRect.size;
        return CGSizeMake(ceil(size.width), ceil(size.height));
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [text sizeWithFont:font constrainedToSize:maxSize lineBreakMode:lineBreakMode];
#pragma clang diagnostic push
    }
}

+ (CGSize)calculateTextSizeForText:(NSString *)text withFont:(UIFont *)font
{
    if (text.length == 0)
        return CGSizeZero;
    if ([self respondsToSelector:@selector(sizeWithAttributes:)])
    {
        CGSize size = [text sizeWithAttributes:@{NSFontAttributeName:font}];
        return CGSizeMake(ceil(size.width), ceil(size.height));
    }
    else
    {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        return [text sizeWithFont:font];
#pragma clang diagnostic pop
    }
}

@end
