//
//  CJBasePopupInfo.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

///  BlankView属于哪个视图(用哪个视图的属性来保存)
typedef NS_ENUM(NSUInteger, CJBlankViewBelong) {
    CJBlankViewBelongPopupView = 0, /**< BlankView属于每个弹出框 */
    CJBlankViewBelongSuper,         /**< BlankView属于其显示在的视图 */
    CJBlankViewBelongWindow,        /**< BlankView属于Window */
};

@interface CJBasePopupInfo : NSObject {
    
}
@property (nonatomic, strong) UIView *blankView;        /**< 弹出的视图所在的父视图/空白区域视图 */
@property (nonatomic, strong) UIView *popupView;        /**< 弹出的视图 */
@property (nonatomic, strong) UIView *popupSuperview;   /**< 弹出视图的父视图 */

@end

NS_ASSUME_NONNULL_END
