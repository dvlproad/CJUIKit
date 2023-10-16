//
//  CJActionSheetView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJActionSheetModel.h"

#import "CJActionSheetHeader.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJActionSheetView : UIView {
    
}
@property (nonatomic, strong) CJActionSheetHeader *headerView;       /**< sheet顶部视图（有标题的时候有，有时候没有） */

@property (nullable, nonatomic, copy) NSString *cancelText; /**< sheet的取消文本(默认"取消"，或者“我再想想”) */

@property (nonatomic, assign, readonly) CGFloat totalHeight;/**< 整个视图的总高度 */
@property (nonatomic, copy) void(^commonClickAction)(CJActionSheetView *actionSheetView);/**< 每个点击共同的事件，一般用于处理与弹出事件对应的隐藏事件(包括选项和取消) */


#pragma mark - Factory
/*
 *  弹出常用的事项选择弹窗(可以下滑)
 *
 *  @param title                标题
 *  @param itemTitles           可点击的事项标题数组(取消按钮上方section0中的那些数组，取消按钮位于section1)
 *  @param showCancelSection    是否显示取消section（有时候不需要显示，文字已固定为"取消"，若要改为"我再想想"请另取方法）
 *  @param itemClickBlock       点击事件
 */
+ (CJActionSheetView *)normalSheetWithTitle:(NSString *)sheetTitle
                                 itemTitles:(NSArray<NSString *> *)itemTitles
                                 showCancel:(BOOL)showCancelSection
                             itemClickBlock:(void(^)(NSInteger selectIndex))itemClickBlock;

/*
 *  某个动作的【二次确认】弹窗视图
 *
 *  @param promptTitle          该操作的提醒标题
 *  @param cancelEventText      取消的文本(常为"取消",或"我再想想")
 *  @param operateEventText     该操作事项的文字
 *  @param operateEventBlock    该操作事项的点击回调
 */
+ (CJActionSheetView *)confirmSheetWithTitle:(nullable NSString *)promptTitle
                             cancelEventText:(NSString *)cancelEventText
                            operateEventText:(NSString *)operateEventText
                           operateEventBlock:(void(^)(void))operateEventBlock;



#pragma mark - Init
/*
 *  初始化ActionSheet弹窗
 *
 *  @param title                标题(可以为nil)
 *  @param sheetModels          数据数组(取消按钮上方section0中的那些数组，取消按钮位于section1)
 *  @param showCancelSection    是否显示取消section（有时候不需要显示）
 *  @param clickHandle          点击选择后的回调
 *
 *  @return 弹窗
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                  sheetModels:(NSArray<CJActionSheetModel *> *)sheetModels
                   showCancel:(BOOL)showCancelSection
                  clickHandle:(void(^)(CJActionSheetModel *sheetModel, NSInteger selectIndex))clickHandle NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

#pragma mark - Get Method: ViewHeight
/// 获取视图的高度（已自适应promptTitle多行的情况）
- (CGFloat)viewHeightWithViewWidth:(CGFloat)viewWidth;


@end

NS_ASSUME_NONNULL_END
