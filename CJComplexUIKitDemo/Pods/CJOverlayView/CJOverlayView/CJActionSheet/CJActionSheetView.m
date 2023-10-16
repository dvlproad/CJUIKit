//
//  CJActionSheetView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJActionSheetView.h"
#import <Masonry/Masonry.h>
#import "CJActionSheetTableViewCell.h"
#import "CJScreenBottomTableViewCell.h"
#import "CJBaseOverlayThemeManager.h"

@interface CJActionSheetView () <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<CJActionSheetModel *> *sheetModels;   /**< 数据数组(取消按钮上方section0中的那些数组) */
//@property (nonatomic, copy) NSString *cancelTitle;
@property (nonatomic, copy) void(^clickHandle)(CJActionSheetModel *sheetModel, NSInteger selectIndex);

@property (nonatomic, assign, readonly) BOOL showCancelSection;     /**< 是否显示取消section（有时候不需要显示） */

@end

@implementation CJActionSheetView

#pragma mark - Factory
/*
 *  弹出常用的事项选择弹窗(可以下滑)
 *
 *  @param title                标题
 *  @param itemTitles           可点击的事项标题数组(取消按钮上方section0中的那些数组，取消按钮位于section1)
 *  @param showCancelSection    是否显示取消section（有时候不需要显示，文字已固定为"取消"，若要改为"我再想想"请另取方法）
 *  @param itemClickBlock       点击事件
 */
+ (CJActionSheetView *)normalSheetWithTitle:(NSString *)sheetTitle
                                 itemTitles:(NSArray<NSString *> *)itemTitles
                                 showCancel:(BOOL)showCancelSection
                             itemClickBlock:(void(^)(NSInteger selectIndex))itemClickBlock
{
    NSMutableArray *sheetModels = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < itemTitles.count; i++) {
        CJActionSheetModel *sheetModel = [[CJActionSheetModel alloc] init];
        sheetModel.title = itemTitles[i];
        [sheetModels addObject:sheetModel];
    }
    
    CJActionSheetView *actionSheet = [[CJActionSheetView alloc] initWithTitle:sheetTitle sheetModels:sheetModels showCancel:showCancelSection clickHandle:^(CJActionSheetModel *sheetModel, NSInteger selectIndex) {
        if (itemClickBlock) {
            itemClickBlock(selectIndex);
        }
    }];
    actionSheet.cancelText = @"取消"; // 标题常为"取消"或"我再想想"
    
    return actionSheet;
}

/*
 *  某个动作的【二次确认】弹窗视图
 *
 *  @param promptTitle          该操作的提醒标题
 *  @param cancelEventText      取消的文本(常为"取消",或"我再想想")
 *  @param operateEventText     该操作事项的文字
 *  @param operateEventBlock    该操作事项的点击回调
 */
+ (CJActionSheetView *)confirmSheetWithTitle:(nullable NSString *)promptTitle
                             cancelEventText:(NSString *)cancelEventText
                            operateEventText:(NSString *)operateEventText
                           operateEventBlock:(void(^)(void))operateEventBlock
{
    NSMutableArray *sheetModels = [[NSMutableArray alloc] init];
    {
        CJActionSheetModel *sheetModel = [[CJActionSheetModel alloc] init];
        sheetModel.title = operateEventText;
        [sheetModels addObject:sheetModel];
    }
    
    CJActionSheetView *actionSheet = [[CJActionSheetView alloc] initWithTitle:promptTitle sheetModels:sheetModels showCancel:YES clickHandle:^(CJActionSheetModel *sheetModel, NSInteger selectIndex) {
        !operateEventBlock ?: operateEventBlock();
    }];
    actionSheet.cancelText = cancelEventText; // 标题常为"取消"或"我再想想"
    
    return actionSheet;
}

#pragma mark - Init
/*
 *  初始化ActionSheet弹窗
 *
 *  @param title                标题(可以为nil)
 *  @param sheetModels          数据数组(取消按钮上方section0中的那些数组，取消按钮位于section1)
 *  @param showCancelSection    是否显示取消section（有时候不需要显示）
 *  @param clickHandle          点击选择后的回调
 *
 *  @return 弹窗
 */
- (instancetype)initWithTitle:(nullable NSString *)title
                  sheetModels:(NSArray<CJActionSheetModel *> *)sheetModels
                   showCancel:(BOOL)showCancelSection
                  clickHandle:(void(^)(CJActionSheetModel *sheetModel, NSInteger selectIndex))clickHandle
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupViews];
        _clickHandle = clickHandle;
        _cancelText = @"取消";
        _showCancelSection = showCancelSection;
        
        [self __updateTitle:title sheetModels:sheetModels];
    }
    return self;
}

#pragma mark - Private Method
- (void)__updateTitle:(nullable NSString *)title sheetModels:(NSArray<CJActionSheetModel *> *)sheetModels {
    _sheetModels = sheetModels;
    
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat actionSheetTop = 120;
    CGFloat actionSheetMaxHeight = screenHeight - actionSheetTop;   //整个完整的actionSheet的最大允许高度

    // update frame
    CGFloat section0Height = self.sheetModels.count * [self cellRowHeight];
    CGFloat section1Height = [self screenBottomCellRowHeiht];
    CGFloat section01Gap = [CJBaseOverlayThemeManager sheetThemeModel].section0FooterHeight;
    CGFloat tableViewHeight = section0Height + section01Gap + section1Height;
    CGFloat tableViewMaxHeight = actionSheetMaxHeight-100;
    BOOL scrollEnabled = NO;
    if (tableViewHeight > tableViewMaxHeight) {
        tableViewHeight = tableViewMaxHeight;
        scrollEnabled = YES;
    }
    
    self.tableView.scrollEnabled = scrollEnabled;
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tableViewHeight); //默认按2*50+10+50显示
    }];
    
    CGFloat screenWidth = [UIScreen mainScreen].bounds.size.width;
    CGFloat headerWidth = screenWidth;
    //CGFloat headerWidth = CGRectGetWidth(self.frame);
    CGFloat topTitleViewHeight = [self.headerView updateTitle:title
                                                withViewWidth:headerWidth];
    [self.headerView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(topTitleViewHeight);
    }];
    
    _totalHeight = tableViewHeight + topTitleViewHeight;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.showCancelSection) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return self.sheetModels.count;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return [self screenBottomCellRowHeiht];
    } else {
        return [self cellRowHeight];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CJActionSheetTableViewCell *cell = (CJActionSheetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CJActionSheetTableViewCell" forIndexPath:indexPath];

        CJActionSheetModel *sheetModel = self.sheetModels[indexPath.row];
        cell.isDangerCell = sheetModel.isDangerOperation;
        [cell updateTitleImage:sheetModel.image];
        cell.mainTitleLabel.text = sheetModel.title;
        cell.subTitleLabel.text = sheetModel.subTitle;
        
        return cell;
        
    } else {
        CJScreenBottomTableViewCell *cell = (CJScreenBottomTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CJScreenBottomTableViewCell" forIndexPath:indexPath];

        cell.mainTitleLabel.text = self.cancelText;
        cell.subTitleLabel.text = @"";
        cell.showBottomLine = NO;
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 0) {
        CGFloat footerHeight = [CJBaseOverlayThemeManager sheetThemeModel].section0FooterHeight;
        return footerHeight;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (section == 0) {
        UIView *footer = [UIView new];
        return footer;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSAssert(self.commonClickAction != nil, @"请设置每次点击都会触发的事件");
    self.commonClickAction(self);   //[self cq_hidePopupView];
    
    if (indexPath.section == 0) {
        CJActionSheetModel *sheetModel = self.sheetModels[indexPath.row];
        !self.clickHandle ?: self.clickHandle(sheetModel, indexPath.row);
    }
}


#pragma mark - SetupViews & Lazy
- (void)setupViews {
    self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]; // @"f5f5f5"; 也是section0和section1之间的颜色
    if ([CJBaseOverlayThemeManager sheetThemeModel].sheetConfigBlock != nil) {
        [CJBaseOverlayThemeManager sheetThemeModel].sheetConfigBlock(self);
    }
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(160); //默认按2*50+10+50显示
    }];
    
    [self addSubview:self.headerView];
    [self.headerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.centerX.mas_equalTo(self);
        make.bottom.mas_equalTo(self.tableView.mas_top);
        make.height.mas_equalTo(0);
    }];
}

- (CJActionSheetHeader *)headerView {
    if (_headerView == nil) {
        _headerView = [[CJActionSheetHeader alloc] initWithFrame:CGRectZero];
        _headerView.backgroundColor = [UIColor whiteColor];
    }
    return _headerView;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.rowHeight = [self cellRowHeight];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.alwaysBounceVertical = NO;
        [_tableView registerClass:[CJActionSheetTableViewCell class] forCellReuseIdentifier:@"CJActionSheetTableViewCell"];
        [_tableView registerClass:[CJScreenBottomTableViewCell class] forCellReuseIdentifier:@"CJScreenBottomTableViewCell"];
    }
    return _tableView;
}

#pragma mark - Get Method
- (CGFloat)cellRowHeight {
    CGFloat cellRowHeight = [CJBaseOverlayThemeManager sheetThemeModel].cellRowHeight;
    if (cellRowHeight == 0) {
        cellRowHeight = 50;
    }
    return cellRowHeight;
}

/*
 *  获取与屏幕底部(即边缘)相接触的cell的高度
 *
 *  @return 与屏幕底部(即边缘)想接触的cell的高度
 */
- (CGFloat)screenBottomCellRowHeiht {
    CGFloat cancelSectionAndBottomHeight = 0;
    
    if (self.showCancelSection) {
        CGFloat cancelCellHeight = [self cellRowHeight];
        cancelSectionAndBottomHeight += cancelCellHeight;
    }
    
    cancelSectionAndBottomHeight += [self __screenBottomHeight];
    
    return cancelSectionAndBottomHeight;
}

/// 获取在各个设备上的屏幕底部不可用的高度
- (CGFloat)__screenBottomHeight {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    BOOL isScreenFull = screenHeight >= 812 && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;  // 是否是全面屏
    CGFloat screenBottomHeight = isScreenFull ?  34.0 : 0.0;    // 屏幕底部
    return screenBottomHeight;
}



#pragma mark - Get Method: ViewHeight
/// 获取视图的高度（已自适应promptTitle多行的情况）
- (CGFloat)viewHeightWithViewWidth:(CGFloat)viewWidth {
    CGFloat viewHeight = self.totalHeight;
    
    return viewHeight;
}

@end
