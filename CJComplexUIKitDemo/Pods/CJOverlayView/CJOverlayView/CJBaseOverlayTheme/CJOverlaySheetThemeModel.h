//
//  CJOverlaySheetThemeModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJOverlaySheetThemeModel : NSObject {
    
}
@property (nullable, nonatomic, copy) void(^sheetConfigBlock)(UIView *bSheetView);     /**< sheet的UI设置（圆角、背景色等） */

#pragma mark - sheet顶部title所在视图的UI
/**< sheet顶部的标题非空时，其离边距的竖直距离（默认0，用来给多行的时候提供间距） */
@property (nonatomic, assign) CGFloat topTitleBottomMargin_ifExsitTitle;

/**< sheet顶部的标题非空时，其离边距的水平距离（默认0，因为可能有多行，需要计算高度） */
@property (nonatomic, assign) CGFloat topTitleLeftMargin_ifExsitTitle;

/**< sheet顶部的标题非空时，其顶部视图所占用的最小高度值（默认最小44，因为可能有多行） */
@property (nonatomic, assign) CGFloat topViewMinHeight_ifExsitTitle;




#pragma mark - 数据cell上子视图的UI

@property (nonatomic, assign) CGFloat iconHeight;               /**< icon的宽和高(1:1)（默认0，没有图片位置） */
@property (nonatomic, assign) CGFloat iconTitleSpacing;         /**< icon与右视图的间距（默认0） */

// view 生成的时候调用的block
@property (nullable, nonatomic, copy) void(^topTitleLabelConfigBlock)(UILabel *bTopTitleLable);     /**< sheet顶部标题的UI设置（文字大小、颜色等） */
@property (nullable, nonatomic, copy) void(^mainTitleLabelConfigBlock)(UILabel *bMainTitleLable, BOOL isCancelItem);    /**< 主标题的UI设置（文字大小、颜色等） */
@property (nullable, nonatomic, copy) void(^subTitleLabelConfigBlock)(UILabel *bSubTitleLable);     /**< 副标题的UI设置（文字大小、颜色等） */
// view 根据数据更新的时候调用的block
@property (nullable, nonatomic, copy) void(^dangerCellConfigBlock)(UITableViewCell *bSheetCell, BOOL bIsDangerCell);     /**< cell为危险操作时候的UI设置（其上各视图的文字大小、颜色等） */

@property (nonatomic, assign) CGFloat bottomLineHeight;   /**< cell底部横线的高度（） */
@property (nonatomic, strong) UIColor *bottomLineColor; /**< cell底部横线的颜色（当且仅当bottomLineHeight不为0的时候才有效） */




#pragma mark - 数据section与取消section之间的UI

// 数据section与取消section之间的UI
@property (nonatomic, assign) CGFloat cellRowHeight;    /**< cell的行高（默认50） */
@property (nonatomic, assign) CGFloat section0FooterHeight;    /**< 数据section与取消section之间的间距(默认0，一般会设置10) */ // 即 section12Gap


//@property (nullable, nonatomic, readonly) Class sheetCellClassEntry;              /**< sheetCell的类 */
//@property (nullable, nonatomic, copy, readonly) void(^sheetCellConfigBlock)(UITableViewCell *bSheetCell, CJActionSheetModel *bSheetModel);
//
//- (instancetype)initWithSheetCellClassEntry:(nonnull Class)sheetCellClassEntry
//                       sheetCellConfigBlock:(void(^ _Nonnull)(UITableViewCell *bSheetCell, CJActionSheetModel *bSheetModel))sheetCellConfigBlock;


@end

NS_ASSUME_NONNULL_END
