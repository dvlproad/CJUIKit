//
//  CQTSRipeTableView.m
//  CQDemoKit
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CQTSRipeTableView.h"

@interface CQTSRipeTableView () <UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) NSArray<NSNumber *> *sectionRowCounts;    /**< 每个section的rowCount个数 */

//// section 的 header 和 footer 的定制
//@property (nonatomic, assign, readonly) CGFloat sectionHeaderHeight;
//@property (nullable, nonatomic, copy) void(^sectionHeaderConfigBlock)(UILabel *bSectionHeaderView); /**< section的header定制（有时候背景色为透明） */
//@property (nonatomic, assign, readonly) CGFloat sectionFooterHeight;
//@property (nullable, nonatomic, copy) void(^sectionFooterConfigBlock)(UILabel *bSectionFooterView); /**< section的footer定制（有时候背景色为透明） */

@end

@implementation CQTSRipeTableView

#pragma mark - Init
/*
 *  初始化 TableView
 *
 *  @param sectionRowCounts     每个section的rowCount个数(数组有多少个就多少个section，数组里的元素值为该section的row行数)
 *
 *  @return TableView
 */
- (instancetype)initWithSectionRowCounts:(NSArray<NSNumber *> *)sectionRowCounts {
    self = [super initWithFrame:CGRectZero style:UITableViewStyleGrouped];
    if (self) {
        //[self registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
        self.dataSource = self;
        self.delegate = self;
        
        self.sectionRowCounts = sectionRowCounts;
    }
    return self;
}

/*
#pragma mark - Config Section 的 header 和 footer
- (void)configSectionHeaderHeight:(CGFloat)sectionHeaderHeight
         sectionHeaderConfigBlock:(void(^)(UILabel *bSectionHeaderView))sectionHeaderConfigBlock
              sectionFooterHeight:(CGFloat)sectionFooterHeight
         sectionFooterConfigBlock:(void(^)(UILabel *bSectionFooterView))sectionFooterConfigBlock
{
    _sectionHeaderHeight = sectionHeaderHeight;
    _sectionHeaderConfigBlock = sectionHeaderConfigBlock;
    
    _sectionFooterHeight = sectionFooterHeight;
    _sectionFooterConfigBlock = sectionFooterConfigBlock;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSString *indexTitle = [NSString stringWithFormat:@"section:%zd", section];
    
    UILabel *indexTitleLabel = [[UILabel alloc] init];
    //indexTitleLabel.backgroundColor = UIColor.whiteColor;
    indexTitleLabel.text = indexTitle;
    return indexTitleLabel;
}

// 同时实现以下两个方法，缺一不可，使得每个section的footer高度为0
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView *view = [UIView new];
    view.backgroundColor = [UIColor greenColor];
    return view;
}
*/

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionRowCounts.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSNumber *nRowCount = [self.sectionRowCounts objectAtIndex:section];
    NSInteger iRowCount = [nRowCount integerValue];
    
    return iRowCount;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSString *indexTitle = [NSString stringWithFormat:@"section:%zd", section];
    return indexTitle;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    
    NSString *title = [NSString stringWithFormat:@"%zd", indexPath.row];
    cell.textLabel.text = title;
    
    !self.cellConfigBlock ?: self.cellConfigBlock(cell);
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    NSLog(@"点击了%zd-%zd", indexPath.section, indexPath.row);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
