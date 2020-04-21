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

static CGFloat cellRowHeight = 50.f;    // cell的行高
static CGFloat section12Gap = 10.f;     // section1和section2之间的间隔

@interface CJActionSheetView () <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<CJActionSheetModel *> *sheetModels;   /**< 数据数组(取消按钮上方section0中的那些数组) */
//@property (nonatomic, copy) NSString *cancelTitle;
@property (nonatomic, copy) void(^clickHandle)(CJActionSheetModel *sheetModel, NSInteger selectIndex);

@end

@implementation CJActionSheetView

/**
 *  初始化ActionSheet弹窗
 *
 *  @param sheetModels  数据数组(取消按钮上方section0中的那些数组)
 *  @param clickHandle  点击选择后的回调
 *
 *  @return 弹窗
 */
- (instancetype)initWithSheetModels:(NSArray<CJActionSheetModel *> *)sheetModels
                        clickHandle:(void(^)(CJActionSheetModel *sheetModel, NSInteger selectIndex))clickHandle
{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        [self setupViews];
        _clickHandle = clickHandle;
        _cancelText = @"取消";
        
        [self updateSheetModels:sheetModels];
    }
    return self;
}

- (void)updateSheetModels:(NSArray<CJActionSheetModel *> *)sheetModels {
    _sheetModels = sheetModels;
    
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    CGFloat actionSheetTop = 120;
    CGFloat actionSheetMaxHeight = screenHeight - actionSheetTop;   //整个完整的actionSheet的最大允许高度

    // update frame
    CGFloat section1Height = self.sheetModels.count * cellRowHeight;
    CGFloat section2Height = [self screenBottomCellRowHeiht];
    CGFloat tableViewHeight = section1Height + section12Gap + section2Height;
    CGFloat tableViewMaxHeight = actionSheetMaxHeight-100;
    BOOL scrollEnabled = NO;
    if (tableViewHeight > tableViewMaxHeight) {
        tableViewHeight = tableViewMaxHeight;
        scrollEnabled = YES;
    }
    _totalHeight = tableViewHeight;
    self.tableView.scrollEnabled = scrollEnabled;
    
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(tableViewHeight); //默认按2*50+10+50显示
    }];
}

/**
 *  获取与屏幕底部(即边缘)想接触的cell的高度
 *
 *  @return 与屏幕底部(即边缘)想接触的cell的高度
 */
- (CGFloat)screenBottomCellRowHeiht {
    return cellRowHeight + [self __screenBottomHeight];
}

/// 获取在各个设备上的屏幕底部不可用的高度
- (CGFloat)__screenBottomHeight {
    CGFloat screenHeight = [[UIScreen mainScreen] bounds].size.height;
    BOOL isScreenFull = screenHeight >= 812 && UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone;  // 是否是全面屏
    CGFloat screenBottomHeight = isScreenFull ?  34.0 : 0.0;    // 屏幕底部
    return screenBottomHeight;
}

//#pragma mark - Event
///// 显示sheet
//- (void)show {
//    [self cjdemo_popupInBottomWithHeight:self.totalHeight];
//}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
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
    }
    return cellRowHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        CJActionSheetTableViewCell *cell = (CJActionSheetTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"CJActionSheetTableViewCell" forIndexPath:indexPath];
        
        CJActionSheetModel *sheetModels = self.sheetModels[indexPath.row];
        cell.mainTitleLabel.text = sheetModels.title;
        cell.subTitleLabel.text = sheetModels.subTitle;
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
        return 10;
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
    self.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1]; //@"f5f5f5";
    
    [self addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(0);
        make.height.mas_equalTo(160); //默认按2*50+10+50显示
    }];
}


- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:self.bounds];
        _tableView.rowHeight = cellRowHeight;
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

@end
