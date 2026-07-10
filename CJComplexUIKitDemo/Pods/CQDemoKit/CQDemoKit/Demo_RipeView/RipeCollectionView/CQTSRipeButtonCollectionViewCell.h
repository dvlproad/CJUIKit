//
//  CQTSRipeButtonCollectionViewCell.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CQTSRipeButtonCollectionViewCell : UICollectionViewCell {
    
}
@property (nonatomic, copy) NSString *text;

#pragma mark - Other Method
/*
 *  计算cell的宽度
 *
 *  @param tagString    cell上的文本
 *  @param cellHeight   cell的高度
 *  @param showEdit     计算时候是否要加上编辑按钮
 *
 *  @return cell的宽度
 */
+ (CGFloat)cellWidthText:(NSString *)tagString cellHeight:(CGFloat)cellHeight;

@end
