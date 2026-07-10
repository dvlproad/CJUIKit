//
//  CQTSRipeImageCollectionViewCell.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//
//  等同于 CQMenuCollectionViewCell
//  titleNameLabel靠底，剩下的几乎全是iconImageView的大小

#import <UIKit/UIKit.h>

FOUNDATION_EXTERN const CGFloat badgeLabelMargin;   // badge与cell的距离


NS_ASSUME_NONNULL_BEGIN

@interface CQTSRipeImageCollectionViewCell : UICollectionViewCell {
    
}
@property (nonatomic, strong) UILabel *titleNameLabel;
@property (nonatomic, strong) UIImageView *iconImageView;
@property (nonatomic, assign, readonly) NSInteger badgeCount;

#pragma mark - Set
/// 设置text
- (void)setupText:(NSString *)text;

/// 使用本地图片设置image
- (void)setupImageWithImage:(UIImage *)image;
/// 使用网络图片设置image
- (void)setupImageWithImageUrl:(NSString *)imageUrl;

/// 设置badge
- (void)setupBadgeCount:(NSInteger)badgeCount withMaxNumber:(NSInteger)maxCount;

@end

NS_ASSUME_NONNULL_END
