//
//  UIImage+CJTransformSize.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIImage+CJTransformSize.h"
#import "CQImageRatioModel.h"

@implementation UIImage (CJTransformSize)

/**
 *  按指定模式修正大小
 *  @brief 假设原始(100,100),给定size(50,60),那么最终裁剪成的大小有可能有不进行缩放(50,60)、缩放后尽量小(50,50)、缩放后尽量大(60,60)
 *
 *  @param correctionSize   待修正的大小
 *  @param lastPossibleSize 最后可能的大小
 *  @param scaleType        图片指定的缩放模式(不进行缩放、缩放后尽量小、缩放后尽量大)
 *
 *  @return 修正后的大小
 */
+ (CGSize)cj_correctionSize:(CGSize)correctionSize
         toLastPossibleSize:(CGSize)lastPossibleSize
              withScaleType:(CJScaleType)scaleType
{
    switch (scaleType) {
        case CJScaleTypeAsFarAsPossibleLittle:
        {
            // 在保持等比的情况下，修正size的值，使得size尽量小
            CGFloat ratioWidth = correctionSize.width/lastPossibleSize.width;    //宽度需变化的倍数
            CGFloat ratioHeight = correctionSize.height/lastPossibleSize.height; //高度需变化的倍数
            if (ratioWidth > ratioHeight) {
                //lastPossibleSize.width = lastPossibleSize.width;
                lastPossibleSize.height = (lastPossibleSize.width/correctionSize.width)*correctionSize.height;
            } else {
                lastPossibleSize.width = (lastPossibleSize.height/correctionSize.height)*correctionSize.width;
                //lastPossibleSize.height = lastPossibleSize.height;
            }
            
            break;
        }
        case CJScaleTypeAsFarAsPossibleBig:
        {
            // 在保持等比的情况下，修正size的值，使得size尽量大
            CGFloat ratioWidth = correctionSize.width/lastPossibleSize.width;    //宽度需变化的倍数
            CGFloat ratioHeight = correctionSize.height/lastPossibleSize.height; //高度需变化的倍数
            if (ratioWidth < ratioHeight) {
                //lastPossibleSize.width = lastPossibleSize.width;
                lastPossibleSize.height = (lastPossibleSize.width/correctionSize.width)*correctionSize.height;
            } else {
                lastPossibleSize.width = (lastPossibleSize.height/correctionSize.height)*correctionSize.width;
                //lastPossibleSize.height = lastPossibleSize.height;
            }
            break;
        }
        default:
            break;
    }
    return lastPossibleSize;
}

/* 完整的描述请参见文件头部 */
- (UIImage *)cj_transformImageToSize:(CGSize)size {
    UIGraphicsBeginImageContext(size);  //创建一个bitmap的context
    [self drawInRect:CGRectMake(0, 0, size.width, size.height)];//绘制改变大小的图片
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();//从当前context中创建一个改变大小后的图片
    UIGraphicsEndImageContext();    // 使当前的context出堆栈
    
    return newImage;   //返回新的改变大小后的图片
}


/**
 *  从图片中按指定的位置大小截取图片的一部分
 *
 *  @param image UIImage image 原始的图片
 *  @param rect  CGRect rect 要截取的区域
 *
 *  @return UIImage
 */
+ (UIImage *)ct_imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    //把像 素rect 转化为 点rect（如无转化则按原图像素取部分图片）
    CGFloat scale = [UIScreen mainScreen].scale;
    CGFloat x = rect.origin.x*scale;
    CGFloat y = rect.origin.y*scale;
    CGFloat w = rect.size.width*scale;
    CGFloat h = rect.size.height*scale;
    CGRect dianRect = CGRectMake(x, y, w, h);

    //截取部分图片并生成新图片
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, dianRect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef scale:scale orientation:UIImageOrientationUp];
    return newImage;
}

//传入size记得屏幕的1x的size
+ (UIImage *)cutCenterImageSize:(CGSize)size iMg:(UIImage *)img {
    CGFloat scale = [UIScreen mainScreen].scale;
    size.width = size.width*scale;
    size.height = size.height *scale;
    CGSize imageSize = img.size;
    CGRect pixelRect;
    //根据图片的大小计算出图片中间矩形区域的位置与大小
//    if (imageSize.width > imageSize.height) {
//        float leftMargin = (imageSize.width - imageSize.height) *0.5;
//        rect = CGRectMake(leftMargin,0, imageSize.height, imageSize.height);
//    }else{
//        float topMargin = (imageSize.height - imageSize.width) *0.5;
//        rect = CGRectMake(0, topMargin, imageSize.width, imageSize.width);
//    }
    
    float topMargin = (imageSize.height - size.height) *0.5;
    float leftMargin = (imageSize.width - size.width) *0.5;
    
    pixelRect = CGRectMake(leftMargin, topMargin, size.width, size.height);
    
    return [self cutImage:img inPixelRect:pixelRect];
}


/*
 *  裁剪pixelRect像素区域中的图片
 *
 *  @param img img
 *  @param tooWidthWidthHeightRatio     宽太长时候，裁剪宽，保持高，裁剪后的图片比例
 *  @param tooHeightWidthHeightRatio    高太高时候，裁剪高，保持宽，裁剪后的图片比例
 *
 *  @return 裁剪后的新图
 */
+ (UIImage *)cutImage:(nullable UIImage *)image
tooWidthTrimmedWidthKeepHeightWithRatio:(CGFloat)tooWidthWidthHeightRatio
tooHeightTrimmedHeightKeepWithWithRatio:(CGFloat)tooHeightWidthHeightRatio
{
    CQImageRatioModel *ratioModel = [self correctImageViewRatioWithImage:image tooWidthTrimmedWidthKeepHeightWithRatio:tooWidthWidthHeightRatio tooHeightTrimmedHeightKeepWithWithRatio:tooHeightWidthHeightRatio];
    CGFloat newPixelWidth = ratioModel.newWidth;
    CGFloat newPixelHeight = ratioModel.newHeight;
    
    CGFloat newPixelX = (image.size.width - newPixelWidth) *0.5;
    CGFloat newPixelY = (image.size.height - newPixelHeight) *0.5;
    
    CGRect pixelRect = CGRectMake(newPixelX, newPixelY, newPixelWidth, newPixelHeight);
    
    UIImage *newImage = [self cutImage:image inPixelRect:pixelRect];
    
    return newImage;;
}


/*
 *  根据图片比例，纠正最后的图片视图所希望的比例
 *
 *  @param imageRatio   图片比例
 *
 *  @return 最后的图片视图所希望的比例
 */
+ (CQImageRatioModel *)correctImageViewRatioWithImage:(nullable UIImage *)image
              tooWidthTrimmedWidthKeepHeightWithRatio:(CGFloat)tooWidthWidthHeightRatio
              tooHeightTrimmedHeightKeepWithWithRatio:(CGFloat)tooHeightWidthHeightRatio
{
    if (image == nil) { // 容错
        return nil;
    }
    
    CGFloat oldImageWidth = image.size.width;
    CGFloat oldImageHeight = image.size.height;
    NSAssert(oldImageWidth != 0 || oldImageHeight != 0, @"图片宽高不可能为0，请检查");
    CGFloat imageRatio = oldImageWidth/oldImageHeight;
    
    
    CGFloat newWidth;
    CGFloat newHeight;
    
    CGFloat viewWidthHeightRatio;
    CQTrimmedEdge trimmedEdge = CQTrimmedEdgeNone;  /**< 要裁剪的边 */
    if (imageRatio > tooWidthWidthHeightRatio) {           // 宽太宽，超出4:3，保持高，裁剪宽
        viewWidthHeightRatio = tooWidthWidthHeightRatio;
        trimmedEdge = CQTrimmedEdgeWidth;
        newHeight = oldImageHeight;
        newWidth = newHeight*viewWidthHeightRatio;
    } else {
        if (imageRatio < tooHeightWidthHeightRatio) {
            viewWidthHeightRatio = tooHeightWidthHeightRatio;
            trimmedEdge = CQTrimmedEdgeHeight;
            newWidth = oldImageWidth;
            newHeight = newWidth/viewWidthHeightRatio;
        } else {
            viewWidthHeightRatio = imageRatio;
            trimmedEdge = CQTrimmedEdgeNone;
            newWidth = oldImageWidth;
            newHeight = oldImageHeight;
        }
    }
    
    CQImageRatioModel *ratioModel = [[CQImageRatioModel alloc] init];
    ratioModel.hopeNewRatio = viewWidthHeightRatio;
    ratioModel.trimmedEdge = trimmedEdge;
    ratioModel.newWidth = newWidth;
    ratioModel.newHeight = newHeight;
    
    return ratioModel;
}

/*
 *  裁剪pixelRect像素区域中的图片
 *
 *  @param img img
 *  @param pixelRect 要裁剪的像素区域
 *
 *  @return 裁剪后的新图
 */
+ (UIImage *)cutImage:(UIImage *)img inPixelRect:(CGRect)pixelRect {
//    rect = CGRectMake(0, 0, 100, 100);
//    UIImage *newImage = [self ct_imageFromImage:img inRect:rect];
//    return newImage;
    
    CGImageRef imageRef = img.CGImage;
    //截取中间区域矩形图片
    CGImageRef imageRefRect =CGImageCreateWithImageInRect(imageRef, pixelRect);
    
    UIImage *tmp = [[UIImage alloc] initWithCGImage:imageRefRect];
    CGImageRelease(imageRefRect);
    
    UIGraphicsBeginImageContext(pixelRect.size);
    CGRect rectDraw =CGRectMake(0, 0, pixelRect.size.width, pixelRect.size.height);
    [tmp drawInRect:rectDraw];
    // 从当前context中创建一个改变大小后的图片
    tmp = UIGraphicsGetImageFromCurrentImageContext();
    
    // 使当前的context出堆栈
    UIGraphicsEndImageContext();
    NSLog(@"tmp sizewidth is %f sizeHeight is %f",tmp.size.width,tmp.size.height);
    return tmp;
}


/* 完整的描述请参见文件头部 */
- (UIImage *)cj_resizableImageWithCapInsets:(UIEdgeInsets)insets {
    return  [self resizableImageWithCapInsets:insets resizingMode:UIImageResizingModeStretch];
}


#pragma mark - compress(图片压缩)
/// 压缩图片(先压缩图片质量，再压缩图片尺寸)
- (NSData *)cj_compressWithMaxDataLength:(NSInteger)maxDataLength {
    // Compress by quality
    NSData *data = [self cj_compressQualityWithMaxDataLength:maxDataLength];
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    
    data = [self cj_compressSizeWithMaxDataLength:maxDataLength];
    //NSLog(@"After compressing size loop, image size = %ld KB", data.length / 1024);
    
    return data;
}

/**
 *  压缩图片尺寸,直到图片稍小于指定的最大大小(maxDataLength)
 *  @brief 压缩图片尺寸可以使图片小于指定大小，但会使图片明显模糊(比压缩图片质量模糊)
 *
 *  @param maxDataLength 指定的最大大小
 *
 *  @return 图片数据imageData
 */
- (NSData *)cj_compressSizeWithMaxDataLength:(NSInteger)maxDataLength {
    UIImage *resultImage = self;
    NSData *data = UIImageJPEGRepresentation(resultImage, 1);
    NSUInteger lastDataLength = 0;
    while (data.length > maxDataLength && data.length != lastDataLength) {
        lastDataLength = data.length;
        CGFloat ratio = (CGFloat)maxDataLength / data.length;
        //每次绘制的尺寸 size，要把宽 width 和 高 height 转换为整数，防止绘制出的图片有白边。
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio)));
        resultImage = [resultImage cj_transformImageToSize:size];

        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    return data;
}

/**
 *  压缩图片质量,直到图片稍小于指定的最大大小(maxDataLength)
 *  @brief 压缩图片质量的优点在于，尽可能保留图片清晰度，图片不会明显模糊；
 缺点在于，不能保证图片压缩后小于指定大小。
 *
 *  @param maxDataLength 指定的最大大小
 *
 *  @return 图片数据imageData
 */
- (NSData *)cj_compressQualityWithMaxDataLength:(NSInteger)maxDataLength {
    /*
    // 方法①:遍历法
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    while (data.length > maxDataLength && compression > 0) {
        compression -= 0.02;
        data = UIImageJPEGRepresentation(self, compression); // When compression less than a value, this code dose not work
    }
    */
    
    // 方法②:二分法
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(self, compression);
    if (data.length < maxDataLength) return data;
    CGFloat max = 1;
    CGFloat min = 0;
    for (int i = 0; i < 6; ++i) {
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(self, compression);
        if (data.length < maxDataLength * 0.9) {
            min = compression;
        } else if (data.length > maxDataLength) {
            max = compression;
        } else {
            // 当图片大小小于 maxLength，大于 maxLength * 0.9 时，不再继续压缩。
            break;
        }
    }
    
    return data;
}

@end
