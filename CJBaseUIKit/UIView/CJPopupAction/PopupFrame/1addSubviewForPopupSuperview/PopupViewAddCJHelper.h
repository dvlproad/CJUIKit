//
//  PopupViewAddCJHelper.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 15/11/12.
//  Copyright (c) 2015年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJBasePopupInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface PopupViewAddCJHelper : NSObject {
    
}

/*
 *  在popupSuperview上添加BlankView和popupView
 *
 *  @param popupSuperview           被添加到的地方
 *  @param blankViewBelong          blankView用哪个视图的属性来标记
 *  @param popupView                要被添加的视图
 *  @param tapBlankHandle           点击blankView后，要执行的方法
 *
 *  @return 添加的blankView和popupView
 */
+ (CJBasePopupInfo *)addSubviewForPopupSuperview:(nullable UIView *)popupSuperview
                             withBlankViewBelong:(CJBlankViewBelong)blankViewBelong
                                       popupView:(UIView *)popupView
                                  tapBlankHandle:(void(^ _Nullable)(void))tapBlankHandle;

@end

NS_ASSUME_NONNULL_END
