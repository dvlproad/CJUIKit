//
//  UIImage+CJQRCode.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/8/24.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  其他参考文档：[iOS中生成指定大小、指定颜色的二维码和条形码](http://www.jianshu.com/p/b893690b472e)

#import <UIKit/UIKit.h>

/**
 *  原生的二维码创建与扫描
 *  (附：iOS7之后，可以使用原生的CIFilter创建二维码。关于二维码生成，网上也是有很多，三方库也是有的如zxing，也是挺好用，这里介绍的是通过CIFilter创建二维码。)
 *
 */
@interface UIImage (CJQRCode)


#pragma mark - 创建二维码
/**
 *  传入二维码的字符串，利用原生的CIFilter生成指定大小的二维码图片
 *
 *  @param qrString 二维码的字符串
 *  @param width    生成的二维码的指定大小
 *
 *  @retrun 二维码图片
 */
+ (UIImage *)cj_QRUIImageForQRString:(NSString *)qrString
                                size:(CGFloat)width;


#pragma mark - 改变二维码颜色
/**
 *  遍历像素点，改变图片的颜色(本方法一般只用于改变二维码的颜色)
 *
 *  @param color 图片要改变成的颜色
 *
 *  @return 处理完后的图片
 */
- (UIImage *)cj_QRImageWithColor:(UIColor *)color;



#pragma mark - 图片添加水印
/**
 *  在图片中心添加水印(常用于在二维码中间添加一张icon图片)
 *
 *  @param waterImage       原图上要添加的水印图片
 *  @param waterImageSize   原图上要添加的水印图片的大小
 *
 *  @retrun 添加了水印图片的图片
 */
- (UIImage *)cj_addWaterImage:(UIImage *)waterImage
                     withSize:(CGSize)waterImageSize;

@end
