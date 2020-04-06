//
//  CJUploadImageCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUploadImageCollectionView.h"
#import "CJUploadImageCollectionView+Tap.h"
#import "CJUploadCollectionViewCell.h"

#import "UICollectionView+CJSelect.h"



static NSString * const CJUploadCollectionViewCellID = @"CJUploadCollectionViewCell";
static NSString * const CJUploadCollectionViewCellAddID = @"CJUploadCollectionViewCellAdd";

@interface CJUploadImageCollectionView () {
    
}


@end


@implementation CJUploadImageCollectionView


- (void)commonInit {
    [super commonInit];
    
    self.backgroundColor = [UIColor clearColor];
    
    //flowLayout.headerReferenceSize = CGSizeMake(110, 135);
    
    MyEqualCellSizeSetting *equalCellSizeSetting = [[MyEqualCellSizeSetting alloc] init];
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
    
    
    //以下值，可选设置
    self.allowsMultipleSelection = YES; //是否打开多选
    
    /* 设置Register的Cell或Nib */
    CJUploadCollectionViewCell *registerCell = [[CJUploadCollectionViewCell alloc] init];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:CJUploadCollectionViewCellID];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:CJUploadCollectionViewCellAddID];

    
    __weak typeof(self)weakSelf = self;
    
    /* 创建DataSource */
    MyEqualCellSizeCollectionViewDataSource *equalCellSizeCollectionViewDataSource = [[MyEqualCellSizeCollectionViewDataSource alloc] initWithEqualCellSizeSetting:equalCellSizeSetting cellForItemAtIndexPathBlock:^UICollectionViewCell *(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isExtralItem) {
        if (!isExtralItem) {
            CJUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CJUploadCollectionViewCellID forIndexPath:indexPath];
            [self __operateDataCell:cell withIndexPath:indexPath isSettingOperate:YES];
            
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
    }];
    self.equalCellSizeCollectionViewDataSource = equalCellSizeCollectionViewDataSource;
    
    /* 创建Delegate (UICollectionViewDelegateFlowLayout也需实现UICollectionViewDelegate) */
    MyEqualCellSizeCollectionViewDelegate *delegate = [[MyEqualCellSizeCollectionViewDelegate alloc] initWithEqualCellSizeSetting:equalCellSizeSetting didTapItemBlock:^(UICollectionView *collectionView, NSIndexPath *indexPath, BOOL isDeselect, MyEqualCellSizeSetting *equalCellSizeSetting) {
        BOOL isExtralItem = [weakSelf.equalCellSizeCollectionViewDataSource isExtraItemIndexPath:indexPath];
        
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
    }];
    self.equalCellSizeCollectionViewDelegate = delegate;
    
    /* 设置DataSource和Delegate */
    //self.dataSource = self;
    //self.delegate = self;
    self.dataSource = self.equalCellSizeCollectionViewDataSource;
    self.delegate = self.equalCellSizeCollectionViewDelegate;
    
    self.dataModels = [[NSMutableArray alloc] init];
    self.equalCellSizeCollectionViewDataSource.dataModels = self.dataModels;
}



//#pragma mark - Setter
//- (void)setDataModels:(NSMutableArray<NSString *> *)dataModels {
//    _dataModels = dataModels;
//    
//}

#pragma mark - Update
/// 更新额外cell的样式即位置，(默认不添加）
- (void)updateExtralItemSetting:(CJExtralItemSetting)extralItemSetting {
    [self.equalCellSizeCollectionViewDataSource updateExtralItemSetting:extralItemSetting];
    [self.equalCellSizeCollectionViewDelegate updateExtralItemSetting:extralItemSetting];
}


#pragma mark - Private Method
/*
 *  设置或者更新Cell
 *
 *  @param cell             要设置或者更新的Cell
 *  @param indexPath        要设置或者更新的Cell的indexPath
 *  @param isSettingOperate 是否是设置，如果否则为更新
 */
- (void)__operateDataCell:(CJUploadCollectionViewCell *)dataCell
            withIndexPath:(NSIndexPath *)indexPath
         isSettingOperate:(BOOL)isSettingOperate
{
    CJImageUploadFileModelsOwner *dataModel = [self.equalCellSizeCollectionViewDataSource dataModelAtIndexPath:indexPath];
    
    if (isSettingOperate) {
        dataModel.indexPath = indexPath;
    }
    
    dataCell.cjImageView.image = [UIImage imageNamed:@"icon"];
    if (dataCell.selected) {
        dataCell.cjImageView.image = [UIImage imageNamed:@"cjCollectionViewCellAdd"];
        dataCell.backgroundColor = [UIColor blueColor];
    } else {
        dataCell.cjImageView.image = dataModel.image;
        dataCell.backgroundColor = [UIColor whiteColor];
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
    
    CJImageUploadFileModelsOwner *baseUploadItem = [self.equalCellSizeCollectionViewDataSource dataModelAtIndexPath:indexPath];
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
    
    CJImageUploadFileModelsOwner *baseUploadItem = [self.equalCellSizeCollectionViewDataSource dataModelAtIndexPath:indexPath];
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
