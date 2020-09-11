//
//  CJDemoImageChooseView1.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2018/7/2.
//  Copyright © 2018年 dvlproad. All rights reserved.
//
//  有"重新选择"的图片选择视图(重新选择，只需要重新添加即可)

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import <CJBaseUIKit/UIColor+CJHex.h>
#import "CJDemoImageResultModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJDemoImageChooseView1 : UIView {
    
}
@property (nonatomic, strong) UILabel *titleLabel;
@property (nullable, nonatomic, strong) UIImage *image; /**< 当前视图上选择的图片 */

@property (nonatomic, copy) void(^imageChooseHandle)(void);

- (instancetype)initWithDefaultPhotoImage:(UIImage *)defaultPhotoImage NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;

/// 使用本地照片更新并显示识别结果
- (void)updatePhotoWithLocalImage:(UIImage *)photoImage
             recognizeResultModel:(nullable CJDemoImageResultModel *)recognizeResultModel;

/// 使用网络照片更新并显示识别结果
- (void)updatePhotoWithNetworkImageUrl:(NSString *)photoImageUrl
                  recognizeResultModel:(nullable CJDemoImageResultModel *)recognizeResultModel
                             completed:(void(^ _Nullable)(UIImage *image))completedBlock;

#pragma mark - Class Method
+ (CGFloat)cellHeightWithContainTitle:(BOOL)containTitle;

@end

NS_ASSUME_NONNULL_END
