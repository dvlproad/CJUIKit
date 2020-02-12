//
//  UIButton+CJMoreProperty.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIButton (CJMoreProperty)

@property (nonatomic, strong) UIColor *cjNormalBGColor;     /**< 设置按钮默认时候的背景颜色 */
@property (nonatomic, strong) UIColor *cjHighlightedBGColor;/**< 设置按钮高亮时候的背景颜色 */
@property (nonatomic, strong) UIColor *cjDisabledBGColor;   /**< 设置按钮失效时候的背景颜色 */

@property (nonatomic, strong) UIColor *cjSelectedBGColor;               /**< 设置按钮选中且点击有效时候的背景颜色 */
@property (nonatomic, strong) UIColor *cjSelectedDisabledBGColor;       /**< 设置按钮选中且点击失效时候的背景颜色 */


@property (nonatomic, strong) id cjDataModel;               /**< 设置按钮持有的数据对象 */

@property (nonatomic, copy) void (^cjTouchUpInsideBlock)(UIButton *button);   /**< 设置按钮操作的事件 */

//@property (nonatomic, copy) void (^cjSelectedChangeBlock)(UIButton *button);    /**< 设置按钮selected改变的事件 */


@end
