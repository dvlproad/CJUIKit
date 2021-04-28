//
//  CJUIKitBaseTextViewController.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  Cell视图【单行排列】的文本列表控制器

#import "CJUIKitBaseViewController.h"
#import "CQDMSectionDataModel.h"
#import "CQDMSectionDataModel+CJDealTextModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJUIKitBaseTextViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CQDMSectionDataModel *> *sectionDataModels;

@property (nonatomic, assign) CGFloat fixCellResultLableWidth;  /**< 固定result的视图宽度（该值大于20才生效），默认为0<20，表示自适应宽度 */

@end

NS_ASSUME_NONNULL_END
