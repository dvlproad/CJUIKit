//
//  UIImageCJCompressHelper.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 16/4/20.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "UIImageCJCompressHelper.h"
#import "UIImage+CJTransformSize.h"

typedef NS_ENUM(NSUInteger, CJCompareResult) {
    CJCompareResultUnnkonw = 0, /**< 还没开始比较 */
    CJCompareResultOK = 1,      /**< 刚好，即本身刚好或者加上一个字后刚好 */
    CJCompareResultTooSmall,    /**< 太小，需要去找更大的 */
    CJCompareResultTooBig,      /**< 太大，需要去找更小的 */
    CJCompareResultBeyondMax,   /**< 已经超过字符串本身最大长度，取自己全身 */
};

@implementation UIImageCJCompressHelper

#pragma mark - compress(图片压缩)
/// 其他参考：[iOS 图片压缩总结](https://www.jianshu.com/p/66164b9a7692)
/*
 *  压缩图片(先压缩图片质量，再压缩图片尺寸)
 *
 *  @param image                要压缩的图片
 *  @param lastPossibleSize     最后可能的大小(此过程保持图片比例)
 *  @param maxDataLength        指定的最大大小
 */
+ (NSData *)compressImage:(UIImage *)image withLastPossibleSize:(CGSize)lastPossibleSize maxDataLength:(NSInteger)maxDataLength {
    image = [self cutImage:image withLastPossibleSize:lastPossibleSize scaleType:CJScaleTypeNone]; // 保持图片比例，最大宽或最大高只能为1080
    
    // Compress by quality
    NSData *data = [self compressQualityForImage:image withMaxDataLength:maxDataLength];
    //NSLog(@"After compressing quality, image size = %ld KB", data.length / 1024);
    
    if (data.length > maxDataLength) {
        /*
        NSLog(@"前面图片压缩后，图片数据只压缩到了%.1fKB还是太大，超过指定的%.0fKB，所以为了压缩到指定大小内，我们现在进行尺寸/分辨率裁剪", data.length/1024.0f, maxDataLength/1024.0f);
        NSLog(@"-----------图片裁剪开始-----------");
        NSLog(@"先使用压缩后的数据生成新图，再基于新图进行裁剪。附用于合成的新图片的数据大小为上次压缩的大小结果%.4fKB", data.length/1024.0f);
        UIImage *compressImage = [UIImage imageWithData:data];
        NSData *compressImageData = UIImageJPEGRepresentation(compressImage, 1);
        NSLog(@"题外话至今没懂的：合成图片后，图片的数据大小变大了，变为了%.4fKB", compressImageData.length/1024.0f);
        
        NSLog(@"合成的新图片在裁剪像素前数据大小约%.4fKB，尺寸大小为%@", compressImageData.length/1024.0f, NSStringFromCGSize(compressImage.size));
        CGSize originImageSize = image.size;
        CGSize lastPossibleImageSize = CGSizeMake(originImageSize.width*0.6,
                                                  originImageSize.height*0.6);
        //CGSize lastImageSize = [UIImage cj_correctionSize:originImageSize toLastPossibleSize:lastPossibleImageSize withScaleType:CJScaleTypeNone];
        UIImage *newImage = [compressImage cj_transformImageToSize:lastPossibleImageSize];
        NSData *newImageData = UIImageJPEGRepresentation(newImage, 1);
        NSLog(@"合成的新图片在裁剪像素后数据大小约%.4fKB，尺寸大小为%@", newImageData.length/1024.0f, NSStringFromCGSize(newImage.size));
        NSLog(@"-----------图片裁剪结束-----------");
        //*/
    }
    
    return data;
}

/*
 *  根据指定方式，裁剪最大只能为maxSize的图片，得到新图
 *  @brief 假设原始(100,100),给定size(50,60),那么最终裁剪成的大小有可能有不进行缩放(50,60)、缩放后尽量小(50,50)、缩放后尽量大(60,60)
 *
 *  @param image            要裁剪的图片
 *  @param lastPossibleSize 最后可能的大小
 *  @param scaleType        图片指定的缩放模式(不进行缩放、缩放后尽量小、缩放后尽量大)
 *
 *  @return 修正后的大小
 */
+ (UIImage *)cutImage:(UIImage *)image withLastPossibleSize:(CGSize)lastPossibleSize scaleType:(CJScaleType)scaleType {
    NSLog(@"-----------图片裁剪开始-----------");
    NSData *originImageData = UIImageJPEGRepresentation(image, 1);
    CGSize originImageSize = image.size;
    NSLog(@"图片在裁剪像素前数据大小约%.4fKB，尺寸大小为%@", originImageData.length/1024.0f, NSStringFromCGSize(image.size));
    CGSize lastImageSize = [UIImage cj_correctionSize:originImageSize toLastPossibleSize:lastPossibleSize withScaleType:scaleType];
    UIImage *newImage = [image cj_transformImageToSize:lastImageSize];
    NSData *newImageData = UIImageJPEGRepresentation(newImage, 1);
    NSLog(@"图片在裁剪像素后数据大小约%.4fKB，尺寸大小为%@", newImageData.length/1024.0f, NSStringFromCGSize(newImage.size));
    NSLog(@"-----------图片裁剪结束-----------");
    
    return newImage;
}


/*
 *  压缩图片质量,直到图片稍小于指定的最大大小(maxDataLength)
 *  @brief 压缩图片质量的优点在于，尽可能保留图片清晰度，图片不会明显模糊；
            缺点在于，不能保证图片压缩后小于指定大小。（因为图片的大小是由图片的宽高和像素决定的，而压质量其实只能决定部分图片大小。当图片的宽高过大时，是不能通过压质量来决定最优的图片大小）
 *
 *  @param image            图片
 *  @param maxDataLength    指定的最大大小
 *
 *  @return 图片数据imageData
 */
+ (NSData *)compressQualityForImage:(UIImage *)image
                  withMaxDataLength:(NSInteger)maxDataLength
{
    NSLog(@"-----------图片压缩开始-----------");
    CGFloat compression = 1;
    NSData *data = UIImageJPEGRepresentation(image, compression);
    NSLog(@"开始压缩前数据大小:%.4f KB", (double)data.length/1024.0f);
    if (data.length < maxDataLength) {
        NSLog(@"恭喜本图片大于没超过限制，不需要压缩");
        return data;
    }
    
    /*
    // 方法①:遍历法
    while (data.length > maxDataLength && compression > 0) {
        compression -= 0.02;
        data = UIImageJPEGRepresentation(image, compression); // When compression less than a value, this code dose not work
     NSLog(@"当前压缩比%.4f,压缩得到的数据大小:%.4f KB", compression, (double)data.length/1024.0f);
    }
    */
    
    // 方法②:二分法
    CGFloat max = 1;
    CGFloat min = 0;
    NSInteger lastCompressDataLength = data.length;
    for (int i = 0; i < 8; ++i) { // 最多压缩8次，超过即使没到也退出。但正常8次后，应该到了。
        //比如100%->①50%->②25%->③12.5%->④6.25%->⑤3.125%->
        //⑥1.5625%(1/64)->⑦0.78125%(1/128)->⑧0.390625%(1/256)。
        //附：30M*1024*1/256=30*4=120k
        compression = (max + min) / 2;
        data = UIImageJPEGRepresentation(image, compression);
        if (data.length == lastCompressDataLength) {
            NSLog(@"温馨提示：本次压缩后数据大小没变，即表示已到达本图的最大质量压缩比，无法继续压缩了");
            break;
        }
        
        if (data.length < maxDataLength * 0.9) { // 防止找到太小的了就退出
            min = compression;
        } else if (data.length > maxDataLength) {
            max = compression;
        } else {
            // 当图片大小小于 maxLength，大于 maxLength * 0.9 时，不再继续压缩。
            break;
        }
        lastCompressDataLength = data.length;
        NSLog(@"当前压缩比%.4f,压缩得到的数据大小:%.4f KB", compression, (double)data.length/1024.0f);
    }
    NSLog(@"最终压缩后数据大小:%.4f KB", (double)data.length/1024.0f);
    
    
    if (data.length > maxDataLength) {
        NSLog(@"警告⚠️⚠️⚠️：最后图片数据只压缩到了%.1fKB还是太大，超过指定的%.0fKB，但已经无法继续进行质量压缩，所以如要压缩到指定大小内，接下来请进行尺寸/分辨率裁剪!", data.length/1024.0f, maxDataLength/1024.0f);
    }
    NSLog(@"-----------图片压缩结束-----------");
    
    return data;
}



@end
