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
@property (nonatomic, strong) NSArray *sectionDataModels;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) void (^cellConfigureBlock)(id cell, id dataModel);

@end



@implementation CJSingleTableViewCellDataSource2

/** 完整的描述请参见文件头部 */
- (id)initWithSectionDataModels:(NSArray<NSArray *> *)sectionDataModels
                 cellIdentifier:(NSString *)cellIdentifier
             cellConfigureBlock:(void (^)(id cell, id dataModel))cellConfigureCellBlock
{
    self = [super init];
    if (self) {
        self.sectionDataModels = sectionDataModels;
        self.cellIdentifier = cellIdentifier;
        self.cellConfigureBlock = [cellConfigureCellBlock copy]; //block 要copy
    }
    return self;
}

- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    id dataModel = [sectionDataModel.values objectAtIndex:indexPath.row];
    
    return dataModel;
}

#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    CQDMSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    return sectionDataModel.values.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id dataModel = [self dataModelAtIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    self.cellConfigureBlock(cell, dataModel);
    
    return cell;
}

@end
