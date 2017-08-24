//
//  UIImage+CJQRCode.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/8/24.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UIImage+CJQRCode.h"

@implementation UIImage (CJQRCode)

#pragma mark - 创建二维码
/* 完整的描述请参见文件头部 */
+ (UIImage *)cj_QRUIImageForQRString:(NSString *)qrString
                                size:(CGFloat)width
{
    CIImage *ciImage = [self cj_QRCIImageForQRString:qrString];
    if (ciImage) {
        return [self cj_createNonInterpolatedUIImageFormCIImage:ciImage size:width];
    } else {
        return nil;
    }
}


/**
 *  传入二维码的字符串，利用原生的CIFilter生成二维码图片
 *
 *  @param qrString 二维码的字符串
 *
 *  @return CIImage格式的二维码（生成的二维码是一个CIImage，我们直接转换成UIImage的话大小不好控制，所以使用一些方法返回制定大小的UIImage）
 */
+ (CIImage *)cj_QRCIImageForQRString:(NSString *)qrString {
    // 1.将字符串转换为UTF8编码的NSData对象
    NSData *stringData = [qrString dataUsingEncoding:NSUTF8StringEncoding];
    // 2.创建filter
    CIFilter *qrFilter = [CIFilter filterWithName:@"CIQRCodeGenerator"];
    // 3.设置内容和纠错级别
    [qrFilter setValue:stringData forKey:@"inputMessage"];
    [qrFilter setValue:@"M" forKey:@"inputCorrectionLevel"];
    // 4.返回CIImage
    return qrFilter.outputImage;
}

//生成的二维码是一个CIImage，我们直接转换成UIImage的话大小不好控制，所以使用下面方法返回需要大小的UIImage
+ (UIImage *)cj_createNonInterpolatedUIImageFormCIImage:(CIImage *)image
                                                   size:(CGFloat)size
{
    
    CGRect extent = CGRectIntegral(image.extent);
    CGFloat scale = MIN(size/CGRectGetWidth(extent),
                        size/CGRectGetHeight(extent));
    // 1.创建一个位图图像，绘制到其大小的位图上下文
    size_t width        = CGRectGetWidth(extent) * scale;
    size_t height       = CGRectGetHeight(extent) * scale;
    CGColorSpaceRef cs  = CGColorSpaceCreateDeviceGray();
    CGContextRef bitmapRef = CGBitmapContextCreate(nil, width, height, 8, 0, cs, (CGBitmapInfo)kCGImageAlphaNone);
    CIContext *context     = [CIContext contextWithOptions:nil];
    CGImageRef bitmapImage = [context createCGImage:image fromRect:extent];
    CGContextSetInterpolationQuality(bitmapRef, kCGInterpolationNone);
    CGContextScaleCTM(bitmapRef, scale, scale);
    CGContextDrawImage(bitmapRef, extent, bitmapImage);
    
    
    // 2.创建具有内容的位图图像（保存bitmap到图片）
    CGImageRef scaledImage = CGBitmapContextCreateImage(bitmapRef);
    // 3.清理
    CGContextRelease(bitmapRef);
    CGImageRelease(bitmapImage);
    
    //原图
    UIImage *outputImage = [UIImage imageWithCGImage:scaledImage];
    UIGraphicsBeginImageContextWithOptions(outputImage.size, NO, [[UIScreen mainScreen] scale]);
    [outputImage drawInRect:CGRectMake(0,0 , size, size)];
    
    return outputImage;
}



#pragma mark - 改变二维码颜色
void ProviderReleaseData (void *info, const void *data, size_t size){
    free((void*)data);
}
/* 完整的描述请参见文件头部 */
- (UIImage *)cj_QRImageWithColor:(UIColor *)color
{
    const int imageWidth    = self.size.width;
    const int imageHeight   = self.size.height;
    size_t      bytesPerRow = imageWidth * 4;
    uint32_t* rgbImageBuf   = (uint32_t*)malloc(bytesPerRow * imageHeight);
    
    // 1.创建上下文
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGContextRef context = CGBitmapContextCreate(rgbImageBuf,
                                                 imageWidth,
                                                 imageHeight,
                                                 8,
                                                 bytesPerRow,
                                                 colorSpace,
                                                 kCGBitmapByteOrder32Little | kCGImageAlphaNoneSkipLast);
    CGContextDrawImage(context, CGRectMake(0, 0, imageWidth, imageHeight), self.CGImage);
    
    // 2.遍历像素，改变像素点颜色
    CGFloat r = 0, g = 0, b = 0, a;
    [color getRed:&r green:&g blue:&b alpha:&a];
    CGFloat red     = r*255;
    CGFloat green   = g*255;
    CGFloat blue    = b*255;
    
    int pixelNum = imageWidth * imageHeight;
    uint32_t* pCurPtr = rgbImageBuf;
    for (int i = 0; i < pixelNum; i++, pCurPtr++){
        if ((*pCurPtr & 0xFFFFFF00) < 0x99999900){
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[3] = red; //0~255
            ptr[2] = green;
            ptr[1] = blue;
        }else{
            uint8_t* ptr = (uint8_t*)pCurPtr;
            ptr[0] = 0;
        }
    }
    
    // 3.生成UIImage
    CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL,
                                                                  rgbImageBuf,
                                                                  bytesPerRow * imageHeight,
                                                                  ProviderReleaseData);
    CGImageRef imageRef = CGImageCreate(imageWidth,
                                        imageHeight,
                                        8,
                                        32,
                                        bytesPerRow,
                                        colorSpace,
                                        kCGImageAlphaLast | kCGBitmapByteOrder32Little,
                                        dataProvider,
                                        NULL,
                                        true,
                                        kCGRenderingIntentDefault);
    CGDataProviderRelease(dataProvider);
    UIImage* resultUIImage = [UIImage imageWithCGImage:imageRef];
    
    // 4.释放
    CGImageRelease(imageRef);
    CGContextRelease(context);
    CGColorSpaceRelease(colorSpace);
    
    return resultUIImage;
}





#pragma mark - 图片添加水印
/* 完整的描述请参见文件头部 */
- (UIImage *)cj_addWaterImage:(UIImage *)waterImage
                     withSize:(CGSize)waterImageSize
{
    //原图
    UIImage *image = self;
    UIGraphicsBeginImageContextWithOptions(image.size, NO, [[UIScreen mainScreen] scale]);
    //UIGraphicsBeginImageContext(image.size);
    [image drawInRect:CGRectMake(0,0 , image.size.width, image.size.height)];
    
    //在图片中心添加水印图
    CGFloat waterImageMinX = (image.size.width - waterImageSize.width)/2;
    CGFloat waterImageMinY = (image.size.height - waterImageSize.height)/2;
    [waterImage drawInRect:CGRectMake(waterImageMinX,
                                      waterImageMinY,
                                      waterImageSize.width,
                                      waterImageSize.height)];
    
    //得到新的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return newImage;
}


@end
