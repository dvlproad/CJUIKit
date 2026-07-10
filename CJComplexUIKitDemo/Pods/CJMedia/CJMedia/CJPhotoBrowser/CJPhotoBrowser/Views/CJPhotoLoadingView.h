//
//  CJPhotoLoadingView.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kMinProgress 0.0001

@class CJPhotoBrowser;
@class CJPhotoModel;

@interface CJPhotoLoadingView : UIView
@property (nonatomic) float progress;

- (void)showLoading;
- (void)showFailure;
@end
