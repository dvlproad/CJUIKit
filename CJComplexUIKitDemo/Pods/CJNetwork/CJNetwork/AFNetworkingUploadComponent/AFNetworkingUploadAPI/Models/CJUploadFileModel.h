//
//  CJUploadFileModel.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CJUploadItemType) {
    CJUploadItemTypeImage,  /**< 图片 */
    CJUploadItemTypeSound,  /**< 语音 */
    CJUploadItemTypeAttach, /**< 附件 */
};

/**
 *  上传的每个数据的模型(在CJFile库中海油一个CJFileModel是针对路径的)
 *
 */
@interface CJUploadFileModel : NSObject

@property (nonatomic, assign) CJUploadItemType uploadItemType;
@property (nonatomic, strong) NSData *uploadItemData;  /**< 文件数据 */
@property (nonatomic, copy) NSString *uploadItemName;  /**< 文件名字 */

@end
