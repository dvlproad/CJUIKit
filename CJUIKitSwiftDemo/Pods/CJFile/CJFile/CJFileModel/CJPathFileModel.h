//
//  CJPathFileModel.h
//  CommonFMDBUtilDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, CJFileLocalSourceType) {
    CJFileSourceTypeLocalSandbox = 1,   /**< 本地沙盒文件 */
    CJFileSourceTypeLocalBundle,    /**< 本地Bundle文件 */
};

///路径数据模型(在CJNetwork库中有一个CJUploadFileModel,这两个不一样)
@interface CJPathFileModel : NSObject {
    
}
//readonly
@property (nonatomic, assign, readonly) CJFileLocalSourceType localSourceType;
@property (nonatomic, copy, readonly) NSString *localRelativePath;/**< 本地相对路径(因为沙盒路径会变) */
//@property (nonatomic, copy, readonly) NSString *localAbsolutePath;/**< 本地绝对路径 */

@property (nonatomic, copy, readonly) NSString *networkAbsoluteUrl;/**< 网络绝对路径(有时服务器给的会是省略前缀后的) */

@property (nonatomic, copy, readonly) NSURL *absoluteURL;   /**< 不管是本地文件还是网络文件 */

#pragma mark - 文件的网络路径更新方法
- (void)updateNetworkAbsoluteUrl:(NSString *)networkAbsoluteUrl;

#pragma mark - 文件的本地路径更新方法(两种)
- (void)updateLocalRelativePath:(NSString *)localRelativePath
                localSourceType:(CJFileLocalSourceType)localSourceType;

- (void)updateLocalRelativePathWithLocalAbsolutePath:(NSString *)localAbsolutePath
                                     localSourceType:(CJFileLocalSourceType)localSourceType;

/**
 *  从CJPathFileModel的absoluteURL路径中获取文件(包含图片)的数据，并回调
 *
 *  @param completeBlock 获取到文件数据后的回调方法
 */
- (void)getFileDataWithCompleteBlock:(void(^)(NSData *fileData))completeBlock;

@end
