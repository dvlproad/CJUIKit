//
//  CJLineCell.h
//  CJCollectionViewDemo
//
//  Created by ciyouzen on 16/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自定义的LineCell，其为线以及文字所在的视图
 */
@interface CJLineCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *label; // 文字
@property (nonatomic, strong) UIView *line; // 线
//@property (nonatomic, strong) UIColor *lineColor; // 线的颜色
@property (nonatomic, assign) CGFloat lineThick; // 线条的粗细


@end
