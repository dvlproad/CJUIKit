//
//  CQLoadingImageView.h
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  下载图片的视图

#import <UIKit/UIKit.h>
#import <CJOverlayView/CJIndicatorProgressHUDView.h>

#import "CQImageEnum.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQLoadingImageView : UIView {
    
}
@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) CJIndicatorProgressHUDView *hudView;

- (void)setImageWithUrl:(NSString *)imageUrl;
- (void)setImageWithUrl:(NSString *)imageUrl imageStatus:(CQImageStatus)imageStatus;

@end

NS_ASSUME_NONNULL_END
