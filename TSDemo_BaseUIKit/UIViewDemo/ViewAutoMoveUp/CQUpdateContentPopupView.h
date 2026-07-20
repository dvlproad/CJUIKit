//
//  CQUpdateContentPopupView.h
//  CJUIKitDemo
//
//  Created by qian on 2020/11/24.
//  Copyright © 2020 dvlproad. All rights reserved.
//
//  默认高度180

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQUpdateContentPopupView : UIView {
    
}

/**
 *  设置标题、提示和击完成按钮的事件
 *
 *  @param title                标题
 *  @param placeholder  输入内容的提示文案
 *  @param okHandle         点击完成按钮的事件
 */
- (void)setupTitle:(NSString *)title
       placeholder:(NSString *)placeholder
updateCompleteBlock:(void(^)(NSString *bText))okHandle;

@end

NS_ASSUME_NONNULL_END
