//
//  CQTSAssetModelGetter.h
//  CQDemoResource
//
//  Created by ciyouzen on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CQDemoKit/CQTSLocImageDataModel.h> // 在 subspec:Demo_Resource 下
#import <CQDemoKit/CQTSNetImageDataModel.h> // 在 subspec:Demo_Resource 下
#import <CQDemoKit/CQTSIconDataModel.h>     // 在 subspec:Demo_Resource 下

#import "UIImage+CQDemoResource.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTSAssetModelGetter : NSObject

#pragma mark - 本地资源文件
/// 获取测试用的本地数据
/// （为本地图片名时候，UIImage *image = [UIImage cqresource_imageNamed:imageName]; ）
///
/// @param count                                                        文件个数
/// @param randomOrder                                          顺序是否随机
/// @param folderNames                                          要获取哪些文件夹下的文件
/// @param changeImageNameToNetworkUrl      是否将本地图片名转为其所在的网络地址
///
/// @return 返回图片数据
+ (nullable NSMutableArray<CQTSLocImageDataModel *> *)localFileModelsWithCount:(NSInteger)count
                                                          randomOrder:(BOOL)randomOrder
                                                          folderNames:(NSArray<NSString *> *)folderNames;


#pragma mark - 网络资源文件
/// 获取测试用的网络数据
///
/// @param count                                                        文件个数
/// @param randomOrder                                          顺序是否随机
/// @param folderNames                                          要获取哪些文件夹下的文件
///
/// @return 返回图片数据
+ (nullable NSMutableArray<CQTSNetImageDataModel *> *)networkFileModelsWithCount:(NSInteger)count
                                                            randomOrder:(BOOL)randomOrder
                                                            folderNames:(NSArray<NSString *> *)folderNames;


#pragma mark - Icon资源文件
#pragma mark - Icon资源文件
/// 获取测试用的Icon数据
///
/// @param count                                                        文件个数
/// @param randomOrder                                          顺序是否随机
///
/// @return 返回Icon数据
+ (nullable NSMutableArray<CQTSIconDataModel *> *)iconFileModelsWithCount:(NSInteger)count
                                                     randomOrder:(BOOL)randomOrder;

@end

NS_ASSUME_NONNULL_END
