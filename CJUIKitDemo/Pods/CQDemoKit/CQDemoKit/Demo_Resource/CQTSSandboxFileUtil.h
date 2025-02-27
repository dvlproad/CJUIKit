//
//  CQTSSandboxFileUtil.h
//  CQDemoKit
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSSandboxFileUtil : NSObject

#pragma mark - Copy Bundle File
/// 拷贝主工程中的文件到沙盒中
///
/// @param fileNameWithExtension        要拷贝的文件
/// @param inBundle                                     从项目中的哪个bundle中拷贝（nil时候为 [NSBundle mainBundle] ）
/// @param sandboxURL                                要放到的沙盒位置
/// @param subDirectory                             要放到的沙盒的子目录
///
/// @return 返回存放后的文件路径信息（存放失败，返回nil）
+ (nullable NSDictionary *)copyFile:(NSString *)fileNameWithExtension
                           inBundle:(nullable NSBundle *)bundle
                       toSandboxURL:(nonnull NSURL *)sandboxURL
                       subDirectory:(nullable NSString *)subDirectory;

/// 从后台下载文件到沙盒中
///
/// @param fileUrl                                        要下载的文件的地址
/// @param sandboxURL                                   要放到的沙盒位置
/// @param subDirectory                             要放到的沙盒的子目录
/// @param fileNameWithExtension        文件保存的名字(为nil的时候使用下载的文件名)
/// @param success                                        下载成功
/// @param failure                                        下载失败
///
/// @return 返回存放后的文件路径信息（存放失败，返回nil）
+ (void)downloadFileWithUrl:(NSString *)fileUrl
               toSandboxURL:(NSURL *)sandboxURL
               subDirectory:(nullable NSString *)subDirectory
                   fileName:(nullable NSString *)fileNameWithExtension
                    success:(void (^)(NSDictionary *fileDictionary))success
                    failure:(void (^)(NSString *errorMessage))failure;

@end

NS_ASSUME_NONNULL_END
