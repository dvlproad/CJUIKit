//
//  CJImageAddDeletePickCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJImageAddDeletePickCollectionView.h"
#import "CJChooseFileActionSheetUtil.h"
#import "CJMediaBrowserUtil.h"


@interface CJImageAddDeletePickCollectionView () {
    
}

@end


@implementation CJImageAddDeletePickCollectionView

/*
 *  初始化方法
 *
 *  @param pickImageCompleteBlock       选择完图片后的操作
 *  @param pickVideoHandle              开始操作视频的操作
 *
 *  @return 返回列表
 */
- (instancetype)initWithPickImageCompleteBlock:(void(^)(void))pickImageCompleteBlock
                               pickVideoHandle:(void(^)(void))pickVideoHandle
{
    self = [super initWithConfigItemCellBlock:^(CQActionImageCollectionViewCell *bItemCell, id bDataModel) {
        UIImage *dataModel = (UIImage *)bDataModel;
        //dataModel.indexPath = indexPath;
        bItemCell.cjImageView.image = dataModel;
        
    } clickItemHandle:^(NSArray *bDataModels, NSInteger currentClickItemIndex) {
        [self __clickDataModelAtItemIndex:currentClickItemIndex
                             inDataModels:bDataModels];
    } addHandle:^(CQActionImageCollectionView *bCollectionView) {
        //NSLog(@"点击额外的item");
        if (self.mediaType == CJMediaTypeVideo) { //视频选择
            if (pickVideoHandle) {
                pickVideoHandle();
            } else {
                NSLog(@"未操作视频选择");
            }
        } else { // 图片选择
            [self __pickImageWithCompleteBlock:pickImageCompleteBlock];
        }
        
    } otherItemCellDeleteBlock:nil];
    
    return self;
}

/// 查看已添加的图片或者视频
- (void)__clickDataModelAtItemIndex:(NSInteger)itemIndex
                       inDataModels:(NSArray *)dataModels
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    if (self.mediaType == CJMediaTypeVideo) {
//        CJImageUploadFileModelsOwner *imageUploadItem = [dataModels objectAtIndex:itemIndex];
//        [CJMediaBrowserUtil browseVideoWithLocalRelativePath:imageUploadItem.localRelativePath];
    } else {
        
    }
}

/// 选择照片
- (void)__pickImageWithCompleteBlock:(void(^)(void))pickImageCompleteBlock {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    __weak typeof(self)weakSelf = self;
    NSInteger canMaxChooseImageCount = self.currentCanMaxAddCount;
    
    [CJChooseFileActionSheetUtil defaultImageChooseWithCanMaxChooseImageCount:canMaxChooseImageCount pickCompleteBlock:^(NSArray<UIImage *> *bImages) {
        [weakSelf addImageModels:bImages];
        
        if (pickImageCompleteBlock) {
            pickImageCompleteBlock();
        }
    }];
}






@end
