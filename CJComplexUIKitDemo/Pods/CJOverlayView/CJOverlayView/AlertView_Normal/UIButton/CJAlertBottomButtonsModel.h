//
//  CJAlertBottomButtonsModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2020/1/31.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJAlertBottomButtonsModel : NSObject {
    
}
@property (nonatomic, strong) UIView *bottomButtonView;
@property (nonatomic, assign) CGFloat bottomPartHeight;  /**< 底部区域高度(包含底部按钮及可能的按钮上部的分隔线及按钮下部与边缘的距离) */
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *okButton;

@end


NS_ASSUME_NONNULL_END
