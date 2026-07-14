//
//  CQActionImageCollectionViewCell.h
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CQImageKit/CQImageEnum.h>
#import "CQActionImageCellContentContainerView.h"   // 要引入 CQActionImageFlagType

@interface CQActionImageCollectionViewCell : UICollectionViewCell {
    
}
@property (nonatomic, assign) BOOL isAdd;

//@property (nonatomic, strong) UIButton *cjDeleteButton;
@property (nonatomic, copy) void(^deleteHandle)(CQActionImageCollectionViewCell *bCell);

/// 只调用一次暂时不放在初始化方法里
- (void)configUIWithBannedSize:(CQBannedSize)bannedSize;

- (UIImageView *)cjImageView;

- (instancetype)updateImage:(UIImage *)image;
- (instancetype)makeImageContentMode:(UIViewContentMode)contentMode;

- (void)setFlagType:(int)flagType;

@end
