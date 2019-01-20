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
@property (nonatomic, strong) NSArray *datas;
@property (nonatomic, copy) NSString *cellIdentifier;
@property (nonatomic, copy) TableViewCellConfigureBlock cellConfigureBlock;

@end



@implementation CJSingleTableViewCellDataSource

- (id)init {
    return nil; //没有使用data初始化的时候，dataSoure类设为空，防止该类会执行一些不知道的方法
}

/** 完整的描述请参见文件头部 */
- (id)initWithDatas:(NSArray<NSArray *> *)datas
     cellIdentifier:(NSString *)cellIdentifier
cellConfigureBlock:(TableViewCellConfigureBlock )cellConfigureCellBlock
{
    self = [super init];
    if (self) {
        self.datas = datas;
        self.cellIdentifier = cellIdentifier;
        self.cellConfigureBlock = [cellConfigureCellBlock copy]; //block 要copy
    }
    return self;
}

/** 完整的描述请参见文件头部 */
- (id)dataModelAtIndexPath:(NSIndexPath *)indexPath {
    NSArray *array = [self.datas objectAtIndex:indexPath.section];
    return [array objectAtIndex:indexPath.row];
}


#pragma mark UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.datas.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    id dataModel = [self dataModelAtIndexPath:indexPath];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:self.cellIdentifier forIndexPath:indexPath];
    self.cellConfigureBlock(cell, dataModel);
    
    return cell;
}

#pragma mark UITableViewDelegate


@end
