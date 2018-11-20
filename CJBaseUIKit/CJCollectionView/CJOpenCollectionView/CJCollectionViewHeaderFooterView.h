//
//  CJCollectionViewHeaderFooterView.h
//  CJCollectionViewDemo
//
//  Created by ciyouzen on 16/3/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  自定义的CollectionReusableView（Header、或者Footer）
 *  waring:要为自定义的CollectionView添加SupplementaryElement,该CollectionReusableView必须继承自此类
 */
@interface CJCollectionViewHeaderFooterView : UICollectionReusableView

@property (nonatomic, assign) NSInteger belongToSection;    /**< 当前header或footer属于哪个section下 */
@property (nonatomic, copy) void (^tapHandle)(NSInteger section);   /**< 当前视图的点击 */

@end
