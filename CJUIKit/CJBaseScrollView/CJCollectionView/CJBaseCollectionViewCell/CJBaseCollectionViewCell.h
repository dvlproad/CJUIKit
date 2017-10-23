//
//  CJBaseCollectionViewCell.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CJTextLabelPosition) {
    CJTextLabelPositionCenter,
    CJTextLabelPositionTop,
    CJTextLabelPositionBottom,
};

@interface CJBaseCollectionViewCell : UICollectionViewCell {
    
}
@property (nonatomic, copy) void(^deleteHandle)(CJBaseCollectionViewCell * cell);

@property (nonatomic, strong) UILabel *cjTextLabel;
@property (nonatomic, assign) NSLayoutConstraint *cjTextLabelHeightConstraint;

@property (nonatomic, strong) UIImageView *cjImageView;
@property (nonatomic, strong) UIButton *cjDeleteButton;

/**
 *  在子类中对init做具体实现
 *
 */
- (void)cjBaseCollectionViewCell_commonInit;

//提供给init的方法
/**
 *  添加cjTextLabel和cjImageView（一个图片占满，文字在中的collectionViewCell）
 *
 *  @param imageViewEdgeInsets  cjImageView的edgeInsets
 */
- (void)addCenterTextLabelAndFullImageViewWithEdgeInsets:(UIEdgeInsets)imageViewEdgeInsets;

/**
 *  添加cjTextLabel和cjImageView（一个文字在上，图片占满的collectionViewCell）
 *
 *  @param imageViewEdgeInsets  cjImageView的edgeInsets
 */
- (void)addTopTextLabelAndFullImageViewWithEdgeInsets:(UIEdgeInsets)imageViewEdgeInsets;

/**
 *  添加cjTextLabel和cjImageView（一个文字在上，图片在下的collectionViewCell）
 *
 *  @param space                cjTextLabel和cjImageView之间的间隔
 */
- (void)addTopTextLabelAndBottomImageViewWithSpace:(CGFloat)space;

/**
 *  添加cjTextLabel和cjImageView（一个文字在下，图片占满的collectionViewCell）
 *
 *  @param imageViewEdgeInsets  cjImageView的edgeInsets
 */
- (void)addBottomTextLabelAndFullImageViewWithEdgeInsets:(UIEdgeInsets)imageViewEdgeInsets;

/**
 *  添加cjTextLabel和cjImageView（一个文字在下，图片在上的collectionViewCell）
 *
 *  @param space                cjTextLabel和cjImageView之间的间隔
 */
- (void)addBottomTextLabelAndTopImageViewWithSpace:(CGFloat)space;

/**
 *  添加cjTextLabel和cjImageView（图片在中，一个文字在指定位置的collectionViewCell）
 *
 *  @param textLabelPosition    cjTextLabel的textLabelPosition
 *  @param space                cjTextLabel和cjImageView之间的间隔
 */
- (void)addCenterImageViewWithImageViewSize:(CGSize)imageViewSize
                      textLabelWithPosition:(CJTextLabelPosition)textLabelPosition
                                      space:(CGFloat)space;




#pragma mark - 添加单个的方法
/**
 *  添加cjTextLabel
 *
 *  @param textLabelPosition    cjTextLabel的textLabelPosition
 */
- (void)addCJTextLabelWithPosition:(CJTextLabelPosition)textLabelPosition;

/**
 *  添加cjImageView
 *
 *  @param edgeInsets    cjImageView的edgeInsets
 */
- (void)addCJImageViewWithEdgeInsets:(UIEdgeInsets)edgeInsets;

/**
 *  添加cjImageView
 *
 *  @param imageViewSize    cjImageView和size
 */
- (void)addCenterImageViewWithSize:(CGSize)imageViewSize;


- (void)addCJDeleteButton;

@end
