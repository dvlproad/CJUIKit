//
//  CQBottomBlankAndPanlinePopupEnum.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/8/13.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#ifndef CQBottomBlankAndPanlinePopupEnum_h
#define CQBottomBlankAndPanlinePopupEnum_h


/// 要执行操作的是视图的哪个部分
typedef NS_ENUM(NSUInteger, CQBottomBlankAndPanlinePopupPart) {
    CQBottomBlankAndPanlinePopupPartNone,                   /**< 无 */
    CQBottomBlankAndPanlinePopupPartBlankView,              /**< 空白区域BlankView */
    CQBottomBlankAndPanlinePopupPartPopupView,              /**< 弹出视图popupView */
    CQBottomBlankAndPanlinePopupPartPopupViewWithoutPanLine,/**< 弹出视图popupView中扣去顶部下拉线后的视图 */
};

#endif /* CQBottomBlankAndPanlinePopupEnum_h */
