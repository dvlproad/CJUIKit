//
//  ProcessLineView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2014/8/14.
//  Copyright © 2014年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, ProcessLineViewType) {
    ProcessLineViewTypeDone,    /**< 已完成的 */
    ProcessLineViewTypeDoing,   /**< 正进行的 */
    ProcessLineViewTypeToDo,    /**< 还未进行的 */
};

typedef NS_ENUM(NSUInteger, ProcessLineViewIndexType) {
    ProcessLineViewIndexTypeOther,  /**< 其他 */
    ProcessLineViewIndexTypeStart,  /**< 头(只绘制圆圈的下部分) */
    ProcessLineViewIndexTypeLast,   /**< 尾(只绘制圆圈的上部分) */
};

@interface ProcessLineView : UIView

@property (nonatomic, assign) ProcessLineViewType processLineViewType;
@property (nonatomic, assign) ProcessLineViewIndexType processLineViewIndexType;


@end
