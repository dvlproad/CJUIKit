//
//  CQImageSheetView.h
//  CQOverlayKit
//
//  Created by qian on 2020/12/7.
//  Copyright © 2020年 dvlproad. All rights reserved.
//
//  以演示图片SampleImage和操作按钮title组成的操作选单视图

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CQImageSheetView : UIView {
    
}
@property (nonatomic, assign, readonly) CGFloat totalHeight;/**< 整个视图的总高度 */

/*
 *  图片选择示例样图
 *
 *  @param title                    标题
 *  @param image                    图片
 *  @param imageWithHeightRatio     图片的宽高比
 *  @param pickImageHandle          选择"从手机相册选择"的回调
 */
- (instancetype)initWithTitle:(NSString *)title
                        image:(UIImage *)image
         imageWithHeightRatio:(CGFloat)imageWithHeightRatio
                  clickHandle:(void(^)(CQImageSheetView *bSheetView))clickHandle NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;;

@end

NS_ASSUME_NONNULL_END
