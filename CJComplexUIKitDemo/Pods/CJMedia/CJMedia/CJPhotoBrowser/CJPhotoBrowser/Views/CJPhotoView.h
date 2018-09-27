//
//  CJPhotoView.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@class CJPhotoBrowser, CJPhotoModel, CJPhotoView;

@protocol MJPhotoViewDelegate <NSObject>
- (void)photoViewImageFinishLoad:(CJPhotoView *)photoView;
- (void)photoViewSingleTap:(CJPhotoView *)photoView;
- (void)photoViewDidEndZoom:(CJPhotoView *)photoView;
@end

@interface CJPhotoView : UIScrollView <UIScrollViewDelegate>
// 图片
@property (nonatomic, strong) CJPhotoModel *photo;
// 代理
@property (nonatomic, weak) id<MJPhotoViewDelegate> photoViewDelegate;
@end
