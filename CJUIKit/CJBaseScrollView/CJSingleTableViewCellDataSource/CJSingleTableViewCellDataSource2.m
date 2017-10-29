//
//  CJSingleTableViewCellDataSource2.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJSingleTableViewCellDataSource2.h"

@interface CJSingleTableViewCellDataSource2 () {
    
}
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock cellConfigureBlock;

@end



@implementation CJSingleTableViewCellDataSource2

- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath {
    CJSectionDataModel *sectionDataModel = [self.datas objectAtIndex:indexPath.section];
    id dataModel = [sectionDataModel.values objectAtIndex:indexPath.row];
    
    return dataModel;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.datas.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CJSectionDataModel *sectionDataModel = [self.datas objectAtIndex:section];
    return sectionDataModel.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id dataModel = [self dataModelAtIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    self.cellConfigureBlock(cell, dataModel);
    
    return cell;
}

@end
