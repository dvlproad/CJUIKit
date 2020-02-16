//
//  CJActionSheetView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJActionSheetModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJActionSheetView : UIView {
    
}
@property (nonatomic, assign, readonly) CGFloat totalHeight;/**< 整个视图的总高度 */
@property (nonatomic, copy) void(^commonClickAction)(CJActionSheetView *actionSheetView);/**< 每个点击共同的事件(包括选项和取消) */

/**
 *  初始化ActionSheet弹窗
 *
 *  @param sheetModels  数据数组(取消按钮上方section0中的那些数组)
 *  @param clickHandle  点击选择后的回调
 *
 *  @return 弹窗
 */
- (instancetype)initWithSheetModels:(NSArray<CJActionSheetModel *> *)sheetModels
                        clickHandle:(void(^)(CJActionSheetModel *sheetModel, NSInteger selectIndex))clickHandle NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;;

///// 显示sheet
//- (void)show;

@end

NS_ASSUME_NONNULL_END
