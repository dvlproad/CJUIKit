//
//  CJImageUploadItem.h
//  FileChooseViewDemo
//
//  Created by dvlproad on 2017/1/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJBaseUploadItem.h"

@interface CJImageUploadItem : CJBaseUploadItem

@property (nonatomic, strong) NSIndexPath *indexPath;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *localRelativePath; /**< 图片的本地相对路径 */

/**
 *  初始化
 *
 *  @param showImage                显示的图片
 *  @param imageLocalRelativePath   图片的本地相对路径
 *  @param uploadItems              该item需要执行的上传
 *
 *  return CJImageUploadItem
 */
- (instancetype)initWithShowImage:(UIImage *)showImage
           imageLocalRelativePath:(NSString *)imageLocalRelativePath
                      uploadItems:(NSArray<CJUploadItemModel *> *)uploadItems;

@end
