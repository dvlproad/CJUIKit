//
//  MyEqualCellSizeSetting.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  本类参考自UICollectionViewFlowLayout

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


typedef NS_ENUM(NSUInteger, CJExtralItemSetting) {
    CJExtralItemSettingNone,       /**< 不添加额外item */
    CJExtralItemSettingLeading,    /**< 在头部增加一个(比如在头部增加一个“全部”或者“拍照”按钮) */
    CJExtralItemSettingTailing,    /**< 在尾部增加一个(比如在尾部增加一个“添加”按钮) */
};


/**
 *  我的集合视图的设置，包含Layout和DataSource部分
 */
@interface MyEqualCellSizeSetting : NSObject {
    
}
#pragma mark - Layout部分
@property (nonatomic) CGFloat minimumLineSpacing;
@property (nonatomic) CGFloat minimumInteritemSpacing;
@property (nonatomic) UIEdgeInsets sectionInset;

//以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
@property (nonatomic, assign) CGFloat cellWidthFromFixedWidth;   /**< 通过cell的固定宽度来设置每个cell的宽度 */
@property (nonatomic, assign) NSUInteger cellWidthFromPerRowMaxShowCount; /**< 通过每行可显示的最多个数来设置每个cell的宽度*/

//以下值可选设置，（默认cellHeightFromFixedHeight设置后，另外一个自动失效，如果两个都没设置，则高等于宽）
@property (nonatomic, assign) CGFloat cellHeightFromFixedHeight; /**< cell高,没设置的话等于其宽 */
@property (nonatomic, assign) NSUInteger cellHeightFromPerColumnMaxShowCount; /**< 通过每列可显示的最多个数来设置每个cell的高度(循环的时候可设这个值为1即可) */



#pragma mark - DataSource部分
//其他附加的可选设置的值，若不设置的话，以下值将采用默认值
@property (nonatomic, assign) CJExtralItemSetting extralItemSetting;/**< 额外cell的样式，(默认不添加） */
@property (nonatomic, assign) NSUInteger maxDataModelShowCount; /**< 集合视图最大显示的dataModel数目(默认NSIntegerMax即无限制) */


- (BOOL)isExtraItemIndexPath:(NSIndexPath *)indexPath dataModels:(NSMutableArray *)dataModels;

/**
 *  获取在数据是dataModels的时候，整个cellCount的个数(因为有可能有extralItem)
 *
 *  @param dataModels   dataModels
 *
 *  @return 整个cellCount的个数
 */
- (NSInteger)getCellCountByDataModels:(NSArray *)dataModels;

/**
 *  获取indexPath位置的dataModel(从数据源中获取每个indexPath要用什么dataModel来赋值)
 *
 *  @param indexPath    indexPath
 *  @param dataModels   dataModels
 *
 *  @return indexPath位置的dataModel
 */
- (id)getDataModelAtIndexPath:(NSIndexPath *)indexPath dataModels:(NSMutableArray *)dataModels;


@end
