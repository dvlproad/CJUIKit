//
//  UIImage+CJTransformSize.m
//  CJUIKitDemo
//
//  Created by dvlproad on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIImage+CJTransformSize.h"

@implementation UIImage (CJTransformSize)

/* 完整的描述请参见文件头部 */
- (UIImage *)cj_transformImageToSize:(CGSize)size withScaleType:(CJScaleType)scaleType {
    switch (scaleType) {
        case CJScaleTypeMinification:
        {
            CGFloat ratioWidth = self.size.width/size.width;    //宽度缩小的倍数
            CGFloat ratioHeight = self.size.height/size.height; //高度缩小的倍数
            if (ratioWidth > ratioHeight) {
                size.height = size.width/ratioWidth;
            } else {
                size.width = size.height/ratioHeight;
            }
            
            break;
        }
        case CJScaleTypeAmplification:
        {
            CGFloat ratioWidth = size.width/self.size.width;    //宽度放大的倍数
            CGFloat ratioHeight = size.height/self.size.height; //高度放大的倍数
            if (ratioWidth > ratioHeight) {
                size.height = size.width/ratioWidth;
            } else {
                size.width = size.height/ratioHeight;
            }
            break;
        }
        default:
            break;
    }
    
    return [self cj_transformImageToSize:size];
}

/* 完整的描述请参见文件头部 */
- (UIImage *)cj_transformImageToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);  //创建一个bitmap的context
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];//绘制改变大小的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前context中创建一个改变大小后的图片
    UIGraphicsEndImageContext();    // 使当前的context出堆栈
    
    return newImage;   //返回新的改变大小后的图片
}

/* 完整的描述请参见文件头部 */
- (UIImage *)cj_resizableImageWithCapInsets:(UIEdgeInsets)insets {
    
    return  [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}

@end
