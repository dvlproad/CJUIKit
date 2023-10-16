//
//  CQEffectEnum.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#ifndef CQEffectEnum_h
#define CQEffectEnum_h

/// 模糊效果样式
typedef NS_ENUM(NSUInteger, CQEffectStyle) {
    CQEffectStyleNone = 0,          /**< 没有效果即透明效果 */
    CQEffectStyleBGColor,           /**< 添加背景色 */
    CQEffectStyleBlurLight,         /**< 添加毛玻璃效果：Light */
    CQEffectStyleBlurDark,          /**< 添加毛玻璃效果：Dark */
};



#endif /* CQEffectEnum_h */
