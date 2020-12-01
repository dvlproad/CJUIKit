//
//  CQTSBorderStateButton.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  此类只是为了增加对boderColor的控制而已

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQTSBorderStateButton : UIButton {
    
}

@property (nonatomic, assign) CGFloat cjNormalBorderWidth;      /**< 设置按钮默认时候的边框宽度 */
@property (nonatomic, assign) CGFloat cjSelectedBorderWidth;    /**< 设置按钮选中时候的边框宽度 */

@property (nonatomic, strong) UIColor *cjNormalBorderColor;     /**< 设置按钮默认时候的边框颜色 */
@property (nonatomic, strong) UIColor *cjHighlightedBorderColor;/**< 设置按钮高亮时候的边框颜色 */
@property (nonatomic, strong) UIColor *cjDisabledBorderColor;   /**< 设置按钮失效时候的边框颜色 */

@property (nonatomic, strong) UIColor *cjSelectedBorderColor;   /**< 设置按钮选中时候的边框颜色 */
@property (nonatomic, strong) UIColor *cjSelectedDisabledBorderColor;   /**< 设置按钮选中且失效时候的边框颜色 */

@property (nonatomic, copy) void(^selectedChangeCompleteBlock)(CQTSBorderStateButton *button); /**< 单选按钮(选中)状态改变后的block(可用来做一些图片的transform旋转等) */

@end

NS_ASSUME_NONNULL_END
