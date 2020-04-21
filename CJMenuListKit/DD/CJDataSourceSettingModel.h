//
//  CJDataSourceSettingModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//
//  本类用于设置 collectionView 的 DataSource部分

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

/**
 *  额外 item 的类型（常见为上传图片时候尾部/头部有一个添加按钮）
 */
typedef NS_ENUM(NSUInteger, CJExtralItemSetting) {
    CJExtralItemSettingNone,       /**< 不添加额外item */
    CJExtralItemSettingLeading,    /**< 在头部增加一个(比如在头部增加一个“全部”或者“拍照”按钮) */
    CJExtralItemSettingTailing,    /**< 在尾部增加一个(比如在尾部增加一个“添加”按钮) */
};


/**
 *  我的集合视图的设置，包含Layout和DataSource部分
 */
@interface CJDataSourceSettingModel : NSObject {
    
}
//其他附加的可选设置的值，若不设置的话，以下值将采用默认值
@property (nonatomic, assign) CJExtralItemSetting extralItemSetting;/**< 额外cell的样式，(默认不添加） */
@property (nonatomic, assign) NSUInteger maxDataModelShowCount; /**< 集合视图最大显示的dataModel数目(默认NSIntegerMax即无限制) */


@end
