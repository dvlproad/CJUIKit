//
//  CJActionSheetCellContainer.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  除与屏幕底部(即边缘)相接触的cell外的其他数据cell

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJActionSheetCellContainer : UIView {
    
}
@property (nonatomic, strong) UILabel *mainTitleLabel;              /**< 主标题 */
@property (nullable, nonatomic, strong) UILabel *subTitleLabel;     /**< 副标题 */

@property (nonatomic, assign) BOOL showBottomLine;                  /**< 是否显示cell的底部横线(默认YES，默认颜色#E5E5E5) */

#pragma mark - Update
/*
 *  更新主标题前的图片
 *
 *  @param image 图片(图片为nil时候也会自动居中)
 */
- (void)updateTitleImage:(nullable UIImage *)image;

@end

NS_ASSUME_NONNULL_END
