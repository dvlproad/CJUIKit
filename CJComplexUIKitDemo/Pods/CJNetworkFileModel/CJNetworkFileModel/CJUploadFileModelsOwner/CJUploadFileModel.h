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

NS_ASSUME_NONNULL_BEGIN

/**
 *  上传的每个数据的模型(在CJFile库中还有一个CJFilePathModel是针对路径的)
 *
 */
@interface CJUploadFileModel : NSObject

@property (nonatomic, copy, readonly) NSString *uploadItemKey;  /**< 文件上传在from表单中所对应的key */
@property (nonatomic, strong, readonly) NSData *uploadItemData; /**< 文件数据 */
@property (nonatomic, copy, readonly) NSString *uploadItemName; /**< 文件名字 */
@property (nonatomic, assign, readonly) CJUploadItemType uploadItemType;

/**
 *  初始化文件上传时候的上传模型
 *
 *  @param uploadItemType   文件的类型(这里没有从文件路径中，通过后缀得到他的类型，所以需要指定)
 *  @param fileName         文件名字
 *  @param data             文件数据
 *  @param itemKey          文件key
 */
- (instancetype)initWithItemType:(CJUploadItemType)uploadItemType
                        itemName:(NSString *)fileName
                        itemData:(NSData *)data
                         itemKey:(NSString *)itemKey NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/**
 *  初始化文件上传时候的上传模型（常用于上传已存于磁盘的资源文件）
 *  @brief 通过本地相对路径localRelativePath，获得uploadItemType类型的文件上传时候的上传模型
 *
 *  @param localRelativePath    本地相对路径
 *  @param uploadItemType       文件的类型(这里没有从文件路径中，通过后缀得到他的类型，所以需要指定)
 *
 *  @return 文件上传时候的上传模型
 */
+ (CJUploadFileModel *)localUploadFileModel:(NSString *)localRelativePath
                                   itemType:(CJUploadItemType)uploadItemType
                                    itemKey:(NSString *)itemKey;

@end

NS_ASSUME_NONNULL_END
