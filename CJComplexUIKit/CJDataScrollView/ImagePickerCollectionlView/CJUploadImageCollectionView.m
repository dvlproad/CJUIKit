//
//  CJUploadImageCollectionView.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/1/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUploadImageCollectionView.h"
#import "CJUploadImageCollectionView+Tap.h"
#import "CJUploadCollectionViewCell.h"

static NSString * const CJUploadCollectionViewCellID = @"CJUploadCollectionViewCell";
static NSString * const CJUploadCollectionViewCellAddID = @"CJUploadCollectionViewCellAdd";

@interface CJUploadImageCollectionView () <UICollectionViewDataSource> {
    
}

@end

@implementation CJUploadImageCollectionView

- (void)commonInit {
    [super commonInit];
    
    self.dataModels = [[NSMutableArray alloc] init];
    
    /*
    {
        CJImageUploadFileModelsOwner *item = [[CJImageUploadFileModelsOwner alloc] init];
        item.image = [UIImage imageNamed:@"CJAvatar.png"];
        [self.dataModels addObject:item];
    }
    */
    MyEqualCellSizeSetting *equalCellSizeSetting = [[MyEqualCellSizeSetting alloc] init];
    //flowLayout.headerReferenceSize = CGSizeMake(110, 135);
    equalCellSizeSetting.minimumInteritemSpacing = 10;
    equalCellSizeSetting.minimumLineSpacing = 15;
    equalCellSizeSetting.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
    equalCellSizeSetting.cellWidthFromPerRowMaxShowCount = 4;
    //equalCellSizeSetting.cellWidthFromFixedWidth = 50;
    
    //以下值，可选设置
    //equalCellSizeSetting.cellHeightFromFixedHeight = 100;
    //equalCellSizeSetting.cellHeightFromPerColumnMaxShowCount = 2;
    equalCellSizeSetting.maxDataModelShowCount = 5;
    equalCellSizeSetting.extralItemSetting = CJExtralItemSettingTailing;
    
    self.equalCellSizeSetting = equalCellSizeSetting;
    
    self.allowsMultipleSelection = YES; //是否打开多选
    
    
    
    CJUploadCollectionViewCell *registerCell = [[CJUploadCollectionViewCell alloc] init];
    
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:CJUploadCollectionViewCellID];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:CJUploadCollectionViewCellAddID];
    
    /*
    CJFullBottomCollectionViewCell *registerCell = [[CJFullBottomCollectionViewCell alloc] init];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:@"cell"];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:@"addCell"];
    */
    
    __weak typeof(self)weakSelf = self;
    

    
    /* 设置DataSource */
    self.dataSource = self;
    
    /* 设置Delegate */
    self.didTapItemBlock = ^(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect) {
        MyEqualCellSizeSetting *equalCellSizeSetting = weakSelf.equalCellSizeSetting;
        BOOL isExtralItem = [equalCellSizeSetting isExtraItemIndexPath:indexPath dataModels:weakSelf.dataModels];
        if (!isExtralItem) {
            
            //NSLog(@"当前点击的Item为数据源中的第%zd个", indexPath.item);
            /*
             if (collectionView.allowsMultipleSelection == NO) {
             NSArray *oldSelectedIndexPaths = weakSelf.equalCellSizeColle ctionView.currentSelectedIndexPaths;
             if (oldSelectedIndexPaths.count > 0) {
             NSIndexPath *oldSelectedIndexPath = oldSelectedIndexPaths[0];
             
             CJFullBottomCollectionViewCell *oldCell = (CJFullBottomCollectionViewCell *)[collectionView cellForItemAtIndexPath:oldSelectedIndexPath];//是oldSelectedIndexPath不要写成indexPath了
             [self operateCell:oldCell withDataModelIndexPath:oldSelectedIndexPath isSettingOperate:NO];
             }
             }
             
             NSArray *currentSelectedIndexPaths = [self.equalCellSizeCollectionView indexPathsForSelectedItems];
             weakSelf.equalCellSizeCollectionView.currentSelectedIndexPaths = currentSelectedIndexPaths;
             NSLog(@"currentSelectedIndexPaths = %@", currentSelectedIndexPaths);
             
             CJFullBottomCollectionViewCell *cell = (CJFullBottomCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
             [self operateCell:cell withDataModelIndexPath:indexPath isSettingOperate:NO];
             */
            
            CJUploadFileModelsOwner *baseUploadItem = [weakSelf.dataModels objectAtIndex:indexPath.row];
            
            CJUploadMomentInfo *momentInfo = baseUploadItem.momentInfo;
            if (momentInfo.uploadState == CJUploadMomentStateFailure) {
                return;
            }
            
            [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
            
            [weakSelf didSelectMediaUploadItemAtIndexPath:indexPath];
        } else {
            //NSLog(@"点击额外的item");
            
            [weakSelf didTapToAddMediaUploadItemAction];
        }
    };
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    NSInteger cellCount = [self.equalCellSizeSetting getCellCountByDataModels:self.dataModels];
    return cellCount;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyEqualCellSizeSetting *equalCellSizeSetting = self.equalCellSizeSetting;
    BOOL isExtralItem = [equalCellSizeSetting isExtraItemIndexPath:indexPath dataModels:self.dataModels];
    
    if (!isExtralItem) {
        /*
        CJFullBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
        */
        CJUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CJUploadCollectionViewCellID forIndexPath:indexPath];
        [self operateCell:cell withDataModelIndexPath:indexPath isSettingOperate:YES];
        
        [self uploadCell:cell withDataModelIndexPath:indexPath]; //上传操作
        
        [self deleteCell:cell inCollectionView:collectionView withDataModelIndexPath:indexPath];
        
        return cell;
        
    } else {
        /*
        CJFullBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addCell" forIndexPath:indexPath];
        */
        CJUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CJUploadCollectionViewCellAddID forIndexPath:indexPath];
        
        cell.cjImageView.image = [UIImage imageNamed:@"cjCollectionViewCellAdd"];
        [cell.cjDeleteButton setImage:nil forState:UIControlStateNormal];
        
        return cell;
    }
}
    
    

/**
 *  设置或者更新Cell
 *
 *  @param cell             要设置或者更新的Cell
 *  @param indexPath        用于获取数据的indexPath(此值一般情况下与cell的indexPath相等)
 *  @param isSettingOperate 是否是设置，如果否则为更新
 */
- (void)operateCell:(CJUploadCollectionViewCell *)cell withDataModelIndexPath:(NSIndexPath *)indexPath isSettingOperate:(BOOL)isSettingOperate {
    
    CJImageUploadFileModelsOwner *dataModel = [self.equalCellSizeSetting getDataModelAtIndexPath:indexPath dataModels:self.dataModels];
    if (isSettingOperate) {
        dataModel.indexPath = indexPath;
    }
    
    cell.cjImageView.image = [UIImage imageNamed:@"icon"];
    if (cell.selected) {
        cell.cjImageView.image = [UIImage imageNamed:@"cjCollectionViewCellAdd"];
        cell.backgroundColor = [UIColor blueColor];
    } else {
        cell.cjImageView.image = dataModel.image;
        cell.backgroundColor = [UIColor whiteColor];
    }
}


/**
 *  完善cell这个view的上传请求
 *
 *  @param cell                 cell
 *  @param indexPath            indexPath
 */
- (void)uploadCell:(CJUploadCollectionViewCell *)cell withDataModelIndexPath:(NSIndexPath *)indexPath {
    if (self.uploadActionType == CJUploadActionTypeNone) {
        return;
    }
    
    __weak typeof(self)weakSelf = self;
    void (^uploadInfoChangeBlock)(CJUploadFileModelsOwner *itemThatSaveUploadInfo) = ^(CJUploadFileModelsOwner *itemThatSaveUploadInfo) {
        CJImageUploadFileModelsOwner *imageItem = (CJImageUploadFileModelsOwner *)itemThatSaveUploadInfo;
        CJUploadCollectionViewCell *myCell = (CJUploadCollectionViewCell *)[weakSelf cellForItemAtIndexPath:imageItem.indexPath];
        CJUploadMomentInfo *momentInfo = itemThatSaveUploadInfo.momentInfo;
        [myCell.uploadProgressView updateProgressText:momentInfo.uploadStatePromptText progressVaule:momentInfo.progressValue];
    };
    
    CJImageUploadFileModelsOwner *baseUploadItem = [self.equalCellSizeSetting getDataModelAtIndexPath:indexPath dataModels:self.dataModels];
    NSArray<CJUploadFileModel *> *uploadModels = baseUploadItem.uploadFileModels;

    
    CJUploadFileModelsOwner *saveUploadInfoToItem = baseUploadItem;
    
    
    
    /*
    NSURLSessionDataTask *(^createDetailedUploadRequestBlock)(void) = ^(void){
        NSURLSessionDataTask *operation =
        [IjinbuNetworkClient detailedRequestUploadItems:uploadModels
                                                toWhere:0
                                andsaveUploadInfoToItem:saveUploadInfoToItem
                                  uploadInfoChangeBlock:uploadInfoChangeBlock];
        
        return operation;
    };
    */

    NSURLSessionDataTask *operation = saveUploadInfoToItem.operation;
    if (operation == nil) {
        //operation = createDetailedUploadRequestBlock();
        operation = self.createDetailedUploadRequestBlock(uploadModels, saveUploadInfoToItem, uploadInfoChangeBlock);
        
        saveUploadInfoToItem.operation = operation;
    }
    
    
    //cjReUploadHandle
    __weak typeof(saveUploadInfoToItem)weakItem = saveUploadInfoToItem;
    [cell.uploadProgressView setCjReUploadHandle:^(UIView *uploadProgressView) {
        __strong __typeof(weakItem)strongItem = weakItem;
        
        [strongItem.operation cancel];
        
        NSURLSessionDataTask *newOperation = nil;
        //newOperation = createDetailedUploadRequestBlock();
        newOperation = self.createDetailedUploadRequestBlock(uploadModels, saveUploadInfoToItem, uploadInfoChangeBlock);
        
        strongItem.operation = newOperation;
    }];
    
    
    CJUploadMomentInfo *momentInfo = saveUploadInfoToItem.momentInfo;
    [cell.uploadProgressView updateProgressText:momentInfo.uploadStatePromptText progressVaule:momentInfo.progressValue];//调用此方法避免reload时候显示错误
}

///完善cell的deleteButton的操作
- (void)deleteCell:(CJUploadCollectionViewCell *)cell inCollectionView:(UICollectionView *)collectionView withDataModelIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self)weakSelf = self;
    
    CJImageUploadFileModelsOwner *baseUploadItem = [self.equalCellSizeSetting getDataModelAtIndexPath:indexPath dataModels:self.dataModels];
    [cell setDeleteHandle:^(CJUploadCollectionViewCell *baseCell) {
        if (baseUploadItem.operation) { //如果有请求任务，则还应该取消掉该任务
            [baseUploadItem.operation cancel];
        }
        NSIndexPath *indexPath = [collectionView indexPathForCell:baseCell];
        
        __strong __typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf.dataModels removeObjectAtIndex:indexPath.item];
        NSInteger currentCount = strongSelf.dataModels.count;
        NSInteger oldCount = [strongSelf numberOfItemsInSection:0];
        //NSLog(@"currentCount = %zd, oldCount = %zd", currentCount, oldCount);
        if (currentCount == oldCount) {
            [collectionView deleteItemsAtIndexPaths:@[indexPath]];
        } else {
            [collectionView reloadData];
        }
    }];
}


///删除第几张图片
- (void)deletePhoto:(NSInteger)index
{
    if (self.dataModels.count > index) {
        [self.dataModels removeObjectAtIndex:index];
        [self reloadData];
    }
}


- (BOOL)isAllUploadFinish {
    for (CJUploadFileModelsOwner *uploadItem in self.dataModels) {
        CJUploadMomentInfo *momentInfo = uploadItem.momentInfo;
        if (momentInfo.uploadState == CJUploadMomentStateFailure) {
            NSLog(@"Failure:请等待所有附件上传完成");
            return NO;
        }
    }
    return YES;
}

@end
