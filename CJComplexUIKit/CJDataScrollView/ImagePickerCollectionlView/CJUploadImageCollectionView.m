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

#import <CJCollectionViewLayout/CQCollectionViewFlowLayout.h>
#import <UICollectionViewCJSelectHelper/UICollectionView+CJSelect.h>

static NSString * const CJUploadCollectionViewCellID = @"CJUploadCollectionViewCell";
static NSString * const CJUploadCollectionViewCellAddID = @"CJUploadCollectionViewCellAdd";

@interface CJUploadImageCollectionView () <UICollectionViewDelegate> {
    
}


@end


@implementation CJUploadImageCollectionView


/// 初始化方法
- (instancetype)init {
    CQCollectionViewFlowLayout *layout = [[CQCollectionViewFlowLayout alloc] init];
    layout.minimumInteritemSpacing = 10;
    layout.minimumLineSpacing = 15;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
    layout.cellWidthFromPerRowMaxShowCount = 4;
    //layout.cellWidthFromFixedWidth = 50;
    layout.widthHeightRatio = 1.0;
    
    
    self = [super initWithFrame:CGRectZero collectionViewLayout:layout];
    if (self) {
        [self setupConfigure];
    }
    return self;
}


- (void)setupConfigure {
    
    self.backgroundColor = [UIColor clearColor];
    
    //以下值，可选设置
    self.allowsMultipleSelection = YES; //是否打开多选
    
    /* 设置Register的Cell或Nib */
    CJUploadCollectionViewCell *registerCell = [[CJUploadCollectionViewCell alloc] init];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:CJUploadCollectionViewCellID];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:CJUploadCollectionViewCellAddID];

    
    /* 创建DataSource */
    CJDataSourceSettingModel *dataSourceSettingModel = [[CJDataSourceSettingModel alloc] init];
    dataSourceSettingModel.maxDataModelShowCount = 5;
    dataSourceSettingModel.extralItemSetting = CJExtralItemSettingTailing;
    CQExtralItemCollectionViewDataSource *equalCellSizeCollectionViewDataSource = [[CQExtralItemCollectionViewDataSource alloc] initWithMaxShowCount:5 cellForPrefixBlock:^UICollectionViewCell *(CQExtralItemCollectionViewDataSource *bDataSource, UICollectionView *collectionView, NSIndexPath *indexPath) {
        CJUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CJUploadCollectionViewCellAddID forIndexPath:indexPath];
        
        cell.cjImageView.image = [UIImage imageNamed:@"cjCollectionViewCellAdd"];
        [cell.cjDeleteButton setImage:nil forState:UIControlStateNormal];
        
        return cell;
        
    } cellForSuffixBlock:nil cellForItemBlock:^UICollectionViewCell *(CQExtralItemCollectionViewDataSource *bDataSource, UICollectionView *collectionView, NSIndexPath *indexPath) {
    
        CJUploadCollectionViewCell *dataCell = [collectionView dequeueReusableCellWithReuseIdentifier:CJUploadCollectionViewCellID forIndexPath:indexPath];
        [self __operateDataCell:dataCell withIndexPath:indexPath isSettingOperate:YES];
        
        return dataCell;
    }];
    self.equalCellSizeCollectionViewDataSource = equalCellSizeCollectionViewDataSource;
    
    /* 设置DataSource和Delegate */
    //self.dataSource = self;
    self.dataSource = self.equalCellSizeCollectionViewDataSource;
    self.delegate = self;
    
    self.equalCellSizeCollectionViewDataSource.dataModels = [[NSMutableArray alloc] init];
}



//#pragma mark - Setter
//- (void)setDataModels:(NSMutableArray<NSString *> *)dataModels {
//    _dataModels = dataModels;
//    
//}

#pragma mark - UICollectionViewDelegate
////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self didTapItemWithCollectionView:collectionView indexPath:indexPath isDeselect:NO];
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self didTapItemWithCollectionView:collectionView indexPath:indexPath isDeselect:YES];
}


- (void)didTapItemWithCollectionView:(UICollectionView *)collectionView
                           indexPath:(NSIndexPath *)indexPath
                          isDeselect:(BOOL)isDeselect
{
    NSInteger itemIndex = [self.equalCellSizeCollectionViewDataSource itemIndexByIndexPath:indexPath];
    if (itemIndex != -1) { // -1代表不是额外的item
        CJUploadFileModelsOwner *baseUploadItem = [self.equalCellSizeCollectionViewDataSource dataModelAtIndexPath:indexPath];
        
        CJUploadMomentInfo *momentInfo = baseUploadItem.momentInfo;
        if (momentInfo.uploadState == CJUploadMomentStateFailure) {
            return;
        }
        
        [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
        
        [self didSelectMediaUploadItemAtIndexPath:indexPath];
    } else {
        //NSLog(@"点击额外的item");
        
        [self didTapToAddMediaUploadItemAction];
    }
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
    
    if (dataCell.selected) {
        dataCell.cjImageView.image = [UIImage imageNamed:@"cjCollectionViewCellAdd"];
        dataCell.backgroundColor = [UIColor blueColor];
    } else {
        dataCell.cjImageView.image = dataModel.image;
        dataCell.backgroundColor = [UIColor whiteColor];
    }
    
    // cell 的删除操作
    __weak typeof(self)weakCollectionView = self;
    [dataCell setDeleteHandle:^(CJUploadCollectionViewCell *baseCell) {
        if (dataModel.operation) { //如果有请求任务，则还应该取消掉该任务
            [dataModel.operation cancel];
        }
        NSIndexPath *indexPath = [weakCollectionView indexPathForCell:baseCell];
        
        __strong __typeof(weakCollectionView)strongCollectionView = weakCollectionView;
        [strongCollectionView.equalCellSizeCollectionViewDataSource deletePhotoAtIndexPath:indexPath];
        
        NSInteger currentCount = strongCollectionView.equalCellSizeCollectionViewDataSource.dataModels.count;
        NSInteger oldCount = [strongCollectionView numberOfItemsInSection:0];
        //NSLog(@"currentCount = %zd, oldCount = %zd", currentCount, oldCount);
        if (currentCount == oldCount) {
            [weakCollectionView deleteItemsAtIndexPaths:@[indexPath]];
        } else {
            [weakCollectionView reloadData];
        }
    }];
    
    
    // 完善cell这个view的上传请求
    if (self.uploadActionType == CJUploadActionTypeNone) {
        return;
    }
    CJUploadMomentInfo *momentInfo = dataModel.momentInfo;
    [dataCell.uploadProgressView updateProgressText:momentInfo.uploadStatePromptText progressVaule:momentInfo.progressValue];//调用此方法避免reload时候显示错误
    
    
    void (^uploadInfoChangeBlock)(CJUploadFileModelsOwner *itemThatSaveUploadInfo) = ^(CJUploadFileModelsOwner *itemThatSaveUploadInfo) {
        CJImageUploadFileModelsOwner *imageItem = (CJImageUploadFileModelsOwner *)itemThatSaveUploadInfo;
        CJUploadCollectionViewCell *myCell = (CJUploadCollectionViewCell *)[weakCollectionView cellForItemAtIndexPath:imageItem.indexPath];
        CJUploadMomentInfo *momentInfo = itemThatSaveUploadInfo.momentInfo;
        [myCell.uploadProgressView updateProgressText:momentInfo.uploadStatePromptText progressVaule:momentInfo.progressValue];
    };
    
    NSArray<CJUploadFileModel *> *uploadModels = dataModel.uploadFileModels;

    
    CJUploadFileModelsOwner *saveUploadInfoToItem = dataModel;
    
    
    
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
    [dataCell.uploadProgressView setCjReUploadHandle:^(UIView *uploadProgressView) {
        __strong __typeof(weakItem)strongItem = weakItem;
        
        [strongItem.operation cancel];
        
        NSURLSessionDataTask *newOperation = nil;
        //newOperation = createDetailedUploadRequestBlock();
        newOperation = self.createDetailedUploadRequestBlock(uploadModels, saveUploadInfoToItem, uploadInfoChangeBlock);
        
        strongItem.operation = newOperation;
    }];
    
    
}





- (BOOL)isAllUploadFinish {
    for (CJUploadFileModelsOwner *uploadItem in self.equalCellSizeCollectionViewDataSource.dataModels) {
        CJUploadMomentInfo *momentInfo = uploadItem.momentInfo;
        if (momentInfo.uploadState == CJUploadMomentStateFailure) {
            NSLog(@"Failure:请等待所有附件上传完成");
            return NO;
        }
    }
    return YES;
}

@end
