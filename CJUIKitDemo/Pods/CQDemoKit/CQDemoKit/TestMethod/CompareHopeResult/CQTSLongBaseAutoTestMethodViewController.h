//
//  CQTSLongBaseAutoTestMethodViewController.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  输入内容可能多行的时候的【测试方法的列表视图】

#import "CJUIKitBaseViewController.h"
#import "CQDMSectionDataModel.h"
#import "CQTSAutoTestMethodModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTSLongBaseAutoTestMethodViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CQDMSectionDataModel *> *sectionDataModels;

@property (nonatomic, assign) CGFloat fixTextViewHeight;  /**< 固定textView的视图高度（该值大于44才生效），默认固定为44 */

@end

NS_ASSUME_NONNULL_END
