//
//  CQBaseTwoEventSheetView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//   有两个操作事项的视图

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQBaseTwoEventSheetView : UIView {
    
}
@property (nonatomic, copy) void(^commonClickAction)(CQBaseTwoEventSheetView *actionSheetView);/**< 每个点击共同的事件，一般用于处理与弹出事件对应的隐藏事件(包括选项和取消) */

#pragma mark - Init
/*
 *  初始化
 *
 *  @param promptTitle          视图顶部的提醒标题
 *  @param item1EventText       操作事项1的文字（危险操作下常见的标题有：删除）
 *  @param item1EventBlock      操作事项1的点击回调
 *  @param item1EventIsDanger   操作事项1是否是危险操作（如果是，则文字颜色会变红）
 *  @param item2EventText       操作事项2的文字
 *  @param item2EventBlock      操作事项2的点击回调
 *
 *  @return  有两个操作事项的视图
 */
- (instancetype)initWithPromptTitle:(NSString *)promptTitle
                     item1EventText:(NSString *)item1EventText
                 item1EventIsDanger:(BOOL)item1EventIsDanger
                    item1EventBlock:(void(^)(void))item1EventBlock
                     item2EventText:(NSString *)item2EventText
                    item2EventBlock:(void(^)(void))item2EventBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;


#pragma mark - Get Method: ViewHeight
/// 获取视图的高度（已自适应promptTitle多行的情况）
- (CGFloat)viewHeightWithViewWidth:(CGFloat)viewWidth;


@end

NS_ASSUME_NONNULL_END
