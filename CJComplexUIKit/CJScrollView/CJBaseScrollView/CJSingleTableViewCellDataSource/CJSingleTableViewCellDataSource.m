//
//  CJSingleTableViewCellDataSource.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJSingleTableViewCellDataSource.h"

@interface CJSingleTableViewCellDataSource () {
    
}
@property (nonatomic, strong) NSArray *dataModels;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) void (^cellConfigureBlock)(id cell, id dataModel);

@end



@implementation CJSingleTableViewCellDataSource

- (id)init {
    return nil; //没有使用data初始化的时候，dataSoure类设为空，防止该类会执行一些不知道的方法
}

/** 完整的描述请参见文件头部 */
- (id)initWithDataModels:(NSArray<NSArray *> *)dataModels
          cellIdentifier:(NSString *)cellIdentifier
      cellConfigureBlock:(void (^)(id cell, id dataModel))cellConfigureCellBlock
{
    self = [super init];
    if (self) {
        self.dataModels = dataModels;
        self.cellIdentifier = cellIdentifier;
        self.cellConfigureBlock = [cellConfigureCellBlock copy]; //block 要copy
    }
    return self;
}

/** 完整的描述请参见文件头部 */
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath {
    id dataModel = [self.dataModels objectAtIndex:indexPath.section];
    return dataModel;
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataModels.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id dataModel = [self dataModelAtIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    self.cellConfigureBlock(cell, dataModel);
    
    return cell;
}

@end
