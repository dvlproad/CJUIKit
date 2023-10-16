//
//  CJUIKitBaseBigTextViewController.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//
//  Cell视图【多行排列】的文本列表控制器

#import "CJUIKitBaseViewController.h"
#import "CQDMSectionDataModel.h"
#import "CQDMSectionDataModel+CJDealTextModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJUIKitBaseBigTextViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray<CQDMSectionDataModel *> *sectionDataModels;

@property (nonatomic, assign) CGFloat fixTextViewHeight;  /**< 固定textView的视图高度（该值大于44才生效），默认固定为44 */

@end

NS_ASSUME_NONNULL_END
