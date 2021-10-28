//
//  CJBaseTableViewCell.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/06/18.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef TEST_CJBASEUIKIT_POD
#import "CJBadgeButton.h"
#else
#import <CJBaseUIKit/CJBadgeButton.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@class CJBaseTableViewCell;

//建议：Configure类的设置强烈建议优先用block，而事件类的可以优先使用delegate
//cell的block
//typedef void (^CJBaseTableViewCellConfigureBlock)(CJBaseTableViewCell *cell, id item);

@protocol CJBaseTableViewCellDelegate <NSObject>

- (void)cjBaseTableViewCell:(CJBaseTableViewCell *)baseTableViewCell
                  longPress:(UILongPressGestureRecognizer *)longPressGR
                atIndexPath:(NSIndexPath *)indexPath;

@end



@interface CJBaseTableViewCell : UITableViewCell {
    
}
@property (nonatomic, weak) id<CJBaseTableViewCellDelegate> delegate;
//@property (nonatomic, strong) id model;
@property (nonatomic, strong) NSIndexPath *indexPath;

@property (nonatomic, strong) CJBadgeButton *cjBadgeButton;
@property (nonatomic, strong) UILabel *cjTextLabel;
@property (nonatomic, strong) UILabel *cjDetailTextLabel;

//cjTextLabel
@property (nonatomic, strong) NSLayoutConstraint *cjTextLabelWidthConstraint;
@property (nonatomic, assign) CGFloat cjTextLabelWidth;
@property (nonatomic, assign) CGFloat cjDetailTextLabelWidth;

@property (nonatomic, assign) BOOL showCJImageView;  //default is "YES"
@property (nonatomic) CGSize cjImageViewSize;
@property (nonatomic) CGFloat cjImageViewCornerRadius UI_APPEARANCE_SELECTOR;

/**
 *  初始化(子类必须调用[super cjBaseTableViewCell_commonInit])
 *
 */
- (void)cjBaseTableViewCell_commonInit;

/**
 *  添加cjBadgeButton
 *
 */
- (void)addCJImageView;

/**
 *  添加cjTextLabel
 *
 *  @param tableViewCellStyle   cell类型
 */
- (void)addCJTextLabelWithType:(UITableViewCellStyle)tableViewCellStyle;

/**
 *  添加cjDetailTextLabel
 *
 *  @param tableViewCellStyle   cell类型
 */
- (void)addCJDetailTextLabelWithType:(UITableViewCellStyle)tableViewCellStyle;

/**
 *  添加separateLineView
 *
 */
- (void)addCJSeparateLineView;

@end

NS_ASSUME_NONNULL_END
