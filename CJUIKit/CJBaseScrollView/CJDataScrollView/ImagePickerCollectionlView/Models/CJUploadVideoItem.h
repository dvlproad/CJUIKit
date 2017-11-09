//
//  CJUploadVideoItem.h
//  CommonAFNUtilDemo
//
//  Created by dvlproad on 2017/2/23.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJBaseUploadItem.h"

@interface CJUploadVideoItem : CJBaseUploadItem

@property (nonatomic, strong) UIImage *image;   /**< 预览图 */
@property (nonatomic, copy) NSString *imageLocalRelativePath; /**< 预览图的本地相对路径 */
@property (nonatomic, copy) NSString *videoLocalRelativePath; /**< 视频的本地相对路径 */

/**
 *  初始化
 *
 *  @param showImage                显示的图片
 *  @param imageLocalRelativePath   预览图的本地相对路径
 *  @param videoLocalRelativePath   视频的本地相对路径
 *  @param uploadItems              该item需要执行的上传
 *
 *  return CJUploadVideoItem
 */
- (instancetype)initWithShowImage:(UIImage *)showImage
           imageLocalRelativePath:(NSString *)imageLocalRelativePath
           videoLocalRelativePath:(NSString *)videoLocalRelativePath
                      uploadItems:(NSArray<CJUploadItemModel *> *)uploadItems;

@end
