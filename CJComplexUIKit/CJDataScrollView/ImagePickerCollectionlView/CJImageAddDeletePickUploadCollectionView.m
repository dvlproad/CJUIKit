//
//  CJImageAddDeletePickUploadCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJImageAddDeletePickUploadCollectionView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <CJBaseHelper/UIViewControllerCJHelper.h>

@interface CJImageAddDeletePickUploadCollectionView () <UICollectionViewDelegate> {
    
}


@end


@implementation CJImageAddDeletePickUploadCollectionView

/*
 *  初始化方法
 *
 *  @param configImageBlock     设置 imageView 的方法（不能为nil）
 *  @param clickItemHandle      点击item时候的操作(如查看大图)
 *  @param addHandle            添加操作
 *  @param deleteCompleteBlock  删除照片后还要执行的操作，如取消之前没结束的请求
 *
 *  @return 返回
 */
- (instancetype)init {
    self = [super initWithPickImageCompleteBlock:^{
        
    } pickVideoHandle:^{
        
    } otherItemCellConfigBlock:^(CJUploadCollectionViewCell *bItemCell, CJImageUploadFileModelsOwner *bDataModel) {
        [self __operateDataCell:bItemCell withDataModel:bDataModel];
        
    } otherItemCellDeleteBlock:^(CJImageUploadFileModelsOwner *bDataModel) {
        CJImageUploadFileModelsOwner *dataModel = (CJImageUploadFileModelsOwner *)bDataModel;
        if (dataModel.operation) { //如果有请求任务，则还应该取消掉该任务
            [dataModel.operation cancel];
        }
    }];
    
    return self;
}

#pragma mark - Private Method
/*
 *  设置或者更新Cell
 *
 *  @param cell             要设置或者更新的Cell
 *  @param dataModel        用来设置cell的dataModel
 */
- (void)__operateDataCell:(CJUploadCollectionViewCell *)dataCell
            withDataModel:(CJImageUploadFileModelsOwner *)dataModel
{
    // cell 的删除操作
    __weak typeof(self)weakCollectionView = self;
    
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
//    for (CJUploadFileModelsOwner *uploadItem in self.cjDataSource.dataModels) {
//        CJUploadMomentInfo *momentInfo = uploadItem.momentInfo;
//        if (momentInfo.uploadState == CJUploadMomentStateFailure) {
//            NSLog(@"Failure:请等待所有附件上传完成");
//            return NO;
//        }
//    }
    return YES;
}

@end
