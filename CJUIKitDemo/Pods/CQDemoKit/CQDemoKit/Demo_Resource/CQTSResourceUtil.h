//
//  CQTSResourceUtil.h
//  CQDemoKit
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSResourceUtil : NSObject

#pragma mark - Extract FileName And Extension
/// 从完整文件名中提取文件名和扩展名
///
/// @param fileName 完整的文件名
/// 
/// @return 包含文件名和扩展名的元组（NSDictionary模拟）
+ (NSDictionary<NSString *, id> *)extractFileNameAndExtensionFromFileName:(NSString *)fileName;


@end

NS_ASSUME_NONNULL_END
