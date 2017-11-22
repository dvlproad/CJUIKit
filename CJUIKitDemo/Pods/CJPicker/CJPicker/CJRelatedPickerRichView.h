//
//  CJRelatedPickerRichView.h
//  CJRelatedPickerRichViewDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJComponentDataModelUtil.h"

@class CJRelatedPickerRichView;
@protocol CJRelatedPickerRichViewDelegate <NSObject>

- (void)cj_RelatedPickerRichView:(CJRelatedPickerRichView *)relatedPickerRichView didSelectText:(NSString *)text;

@end


/**
 *  用于例如地区"福建-厦门-思明"各部分的关联选择
 *
 */
@interface CJRelatedPickerRichView : UIView<UITableViewDataSource, UITableViewDelegate>{
    NSInteger componentCount;
}
@property (nonatomic, strong) NSMutableArray<CJComponentDataModel *> *componentDataModels;
@property (nonatomic, strong) id<CJRelatedPickerRichViewDelegate> delegate;
@property (nonatomic, strong) UIView *pickActionView;   /**< 执行弹出pickView的视图是哪个 */

/**
 *  更新第component个列表的颜色
 *
 *  @param color     要更新成的颜色
 *  @param component 第component个列表
 */
- (void)updateTableViewBackgroundColor:(UIColor *)color inComponent:(NSInteger)component;

@end
