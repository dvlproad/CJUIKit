//
//  CJUploadItemModel.h
//  CommonAFNUtilDemo
//
//  Created by lichq on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CJUploadItemType) {
    CJUploadItemTypeImage,  /**< 图片 */
    CJUploadItemTypeSound,  /**< 语音 */
    CJUploadItemTypeAttach, /**< 附件 */
};

/**
 *  上传的每个数据的模型
 *
 */
@interface CJUploadItemModel : NSObject

@property (nonatomic, assign) CJUploadItemType uploadItemType;
@property (nonatomic, strong) NSData *uploadItemData;  /**< 文件数据 */
@property (nonatomic, copy) NSString *uploadItemName;  /**< 文件名字 */

@end
