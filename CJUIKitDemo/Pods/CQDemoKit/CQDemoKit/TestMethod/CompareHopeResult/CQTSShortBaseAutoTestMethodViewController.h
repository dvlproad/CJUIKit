//
//  CQTSShortBaseAutoTestMethodViewController.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  输入内容是单行的时候的【测试方法的列表视图】

#import "CJUIKitBaseViewController.h"
#import "CQDMSectionDataModel.h"
#import "CQTSAutoTestMethodModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CQTSShortBaseAutoTestMethodViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CQDMSectionDataModel *> *sectionDataModels;

@property (nonatomic, assign) CGFloat fixCellResultLableWidth;  /**< 固定result的视图宽度（该值大于20才生效），默认为0<20，表示自适应宽度 */

@end

NS_ASSUME_NONNULL_END
