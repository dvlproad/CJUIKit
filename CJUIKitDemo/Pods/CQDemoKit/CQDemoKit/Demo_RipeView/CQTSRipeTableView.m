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
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray<NSNumber *> *sectionRowCounts;    /**< 每个section的rowCount个数 */

@end

@implementation CQTSRipeTableView


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
