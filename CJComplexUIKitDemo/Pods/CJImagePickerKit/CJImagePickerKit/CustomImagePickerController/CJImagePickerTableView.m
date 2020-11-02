//
//  CJImagePickerTableView.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJImagePickerTableView.h"
#import "CJMultiColumnPhotoTableViewCell.h"

#import <AVFoundation/AVFoundation.h>

@interface CJImagePickerTableView () <UIScrollViewDelegate, UITableViewDataSource, UITableViewDelegate> {
    
}
@property (nonatomic, strong) NSMutableArray<CJAlumbSectionDataModel *> *sectionDataModels;

@property (nonatomic, copy) void(^selectedCountChangeBlock)(NSMutableArray<CJAlumbImageModel *> *bSelectedArray);

@property (nonatomic, copy) void(^overLimitBlock)(void);
@property (nonatomic, copy) void (^clickImageBlock)(CJAlumbImageModel *imageModel); /**< 图片的点击操作 */


@end






@implementation CJImagePickerTableView

/*
 *  初始化
 *
 *  @param selectedCountChangeBlock     选中的照片发生变化的回调
 *  @param overLimitBlock               超过最大选择图片数量的限制回调
 *  @param clickImageBlock              点击图片执行的事件
 *
 *  @return 照片列表
 */
- (instancetype)initWithSelectedCountChangeBlock:(void(^)(NSMutableArray<CJAlumbImageModel *> *bSelectedArray))selectedCountChangeBlock
                                  overLimitBlock:(void(^)(void))overLimitBlock
                                 clickImageBlock:(void(^)(CJAlumbImageModel *imageModel))clickImageBlock
{
    if (self = [super init]) {
        self.canMaxChooseImageCount = 9;
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
        self.backgroundView.backgroundColor = [UIColor clearColor];
        CJMultiColumnPhotoTableViewCell *registerCell = [[CJMultiColumnPhotoTableViewCell alloc] init];
        [self registerClass:[registerCell class] forCellReuseIdentifier:@"cell"];
        
        self.delegate = self;
        self.dataSource = self;
        
        self.selectedCountChangeBlock = selectedCountChangeBlock;
        self.overLimitBlock = overLimitBlock;
        self.clickImageBlock = clickImageBlock;
        
        self.selectedArray = [[NSMutableArray alloc] init];
    }
    return self;
}


#pragma mark - Event
- (void)reloadWithData:(NSArray<CJAlumbImageModel *> *)currentGroupAssetModels {
    CJAlumbSectionDataModel *sectionDataModel = [[CJAlumbSectionDataModel alloc] init];
    sectionDataModel.values = currentGroupAssetModels;
    NSMutableArray<CJAlumbSectionDataModel *> *sectionDataModels = [[NSMutableArray alloc] init];
    [sectionDataModels addObject:sectionDataModel];
    
    self.sectionDataModels = sectionDataModels;
    [self reloadData];
}



- (CJAlumbImageModel *)__imageModelInIndexPath:(NSIndexPath *)indexPath {
    CJAlumbSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    CJAlumbImageModel *item = sectionDataModel.values[indexPath.item];
    
    return item;
}


- (void)onImageSelectedChanged:(CJPhotoGridCell *)photoGridCell
{
    NSIndexPath *indexPath = photoGridCell.indexPath;
    CJAlumbSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    CJAlumbImageModel * item = sectionDataModel.values[indexPath.item];
    item.selected = !item.selected;
    photoGridCell.selected = item.selected;
    if (item.selected) {
        if (self.selectedArray.count >= self.canMaxChooseImageCount) {
            item.selected = NO;
            
            if (self.overLimitBlock) {
                self.overLimitBlock();
            }
            
            return;
        }
        [self.selectedArray addObject:item];
    } else {
        [self.selectedArray removeObject:item];
    }
    
    if (self.selectedCountChangeBlock) {
        self.selectedCountChangeBlock(self.selectedArray);
    }
}

#pragma mark - UIScrollView Delegate
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    [_tableView hcTableViewDidScroll];
//}
//
//- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
//{
//    [_tableView hcTableViewWillBeginDragging];
//}
//
//- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    [_tableView hcTableViewDidEndDragging];
//}


#pragma mark - UITableView Datasource & Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionDataModels.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    CJAlumbSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:section];
    
    if (0 == fmod(sectionDataModel.values.count, 4)) {
        return sectionDataModel.values.count / 4;
    } else {
        return sectionDataModel.values.count / 4 + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat width = (tableView.frame.size.width - 25) / 4;
    return width + 5;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CJMultiColumnPhotoTableViewCell *cell = (CJMultiColumnPhotoTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    __weak typeof(self)weakSelf = self;
    cell.gridCellImageButtonTapBlock = ^ (CJPhotoGridCell *photoGridCell) {
        if (weakSelf.clickImageBlock) {
            CJAlumbImageModel *imageModel = [weakSelf __imageModelInIndexPath:photoGridCell.indexPath];
            weakSelf.clickImageBlock(imageModel);
        }
    };
    
    cell.gridCellCheckButtonTapBlock = ^ (CJPhotoGridCell *photoGridCell) {
        [weakSelf onImageSelectedChanged:photoGridCell];
    };
    
    
    
    NSInteger section = indexPath.section;
    CJAlumbSectionDataModel *sectionDataModel = [self.sectionDataModels objectAtIndex:indexPath.section];
    for (int i = 0; i < 4; i++) {
        NSInteger index = 4 * indexPath.row + i;
        
        CJAlumbImageModel *imageItem = nil;
        if (index < sectionDataModel.values.count) {
            imageItem = sectionDataModel.values[index];
        }
        
        CJPhotoGridCell *photoGridCell = [cell.contentView viewWithTag:1000+i];
        photoGridCell.indexPath = [NSIndexPath indexPathForItem:index inSection:section];
        photoGridCell.imageItem = imageItem;
        
        //更新gridCellWidth的约束(之前的等宽是根据frame设置的)
        CGFloat gridCellWidth = (CGRectGetWidth(tableView.frame) - 25) / 4;
        [photoGridCell mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(5);
            make.left.mas_equalTo(5 * (i+1) + gridCellWidth * i);
            make.width.height.mas_equalTo(gridCellWidth);
        }];
    }
    return cell;
}




@end
