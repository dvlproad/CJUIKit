//
//  TSActionSheetUtil.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CJBaseOverlayKit/CJActionSheetModel.h>

NS_ASSUME_NONNULL_BEGIN

@interface TSActionSheetUtil : NSObject 

#pragma mark - 完整的基本接口
/**
 *  弹出事项选择
 *
 *  @param sheetModels          数据数组(取消按钮上方section0中的那些数组)
 *  @param itemClickBlock   点击事件
 */
+ (void)showWithSheetModels:(NSArray<CJActionSheetModel *> *)sheetModels
             itemClickBlock:(void(^)(NSInteger selectIndex))itemClickBlock;


@end

NS_ASSUME_NONNULL_END
