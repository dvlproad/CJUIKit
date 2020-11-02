//
//  CJImageAddDeletePickCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJImageAddDeletePickCollectionView.h"
#import <MediaPlayer/MediaPlayer.h>
#import <CJBaseHelper/UIViewControllerCJHelper.h>
#import "CJChooseFileActionSheetUtil.h"


@interface CJImageAddDeletePickCollectionView () <UICollectionViewDelegate> {
    
}
//image
@property (nonatomic, copy) void(^pickImageCompleteBlock)(void); /**< 选择完图片后的操作 */

//video
@property (nonatomic, copy) void(^pickVideoHandle)(void);   /**< 开始操作视频的操作 */



@property (nonatomic, copy) void (^otherItemCellConfigBlock)(CJUploadCollectionViewCell *bItemCell, CJImageUploadFileModelsOwner *bDataModel);
@property (nonatomic, copy) void(^otherItemCellDeleteBlock)(CJImageUploadFileModelsOwner *bDataModel);

@end


@implementation CJImageAddDeletePickCollectionView

/*
 *  初始化方法
 *
 *  @param pickImageCompleteBlock       选择完图片后的操作
 *  @param pickVideoHandle              开始操作视频的操作
 *  @param otherItemCellConfigBlock    itemCell的其他属性如上传进度的设置方法(一般为nil)
 *  @param otherItemCellDeleteBlock  itemCell的其他属性如删除照片后，还要执行取消之前没结束的上传请求方法(一般为nil)
 *
 *  @return 返回
 */
- (instancetype)initWithPickImageCompleteBlock:(void(^)(void))pickImageCompleteBlock
                               pickVideoHandle:(void(^)(void))pickVideoHandle
                      otherItemCellConfigBlock:(void (^)(CJUploadCollectionViewCell *bItemCell, CJImageUploadFileModelsOwner *bDataModel))otherItemCellConfigBlock
                      otherItemCellDeleteBlock:(void(^)(CJImageUploadFileModelsOwner *bDataModel))otherItemCellDeleteBlock
{
    self = [super initWithConfigItemCellBlock:^(CJUploadCollectionViewCell *bItemCell, id bDataModel) {
        CJImageUploadFileModelsOwner *dataModel = (CJImageUploadFileModelsOwner *)bDataModel;
        //dataModel.indexPath = indexPath;
        bItemCell.cjImageView.image = dataModel.image;
        
        if (self.otherItemCellConfigBlock) {
            self.otherItemCellConfigBlock(bItemCell, dataModel);
        }
        
    } clickItemHandle:^(NSArray *bDataModels, NSInteger currentClickItemIndex) {
        [self __clickDataModelAtItemIndex:currentClickItemIndex
                             inDataModels:bDataModels];
    } addHandle:^{
        //NSLog(@"点击额外的item");
        if (self.mediaType == CJMediaTypeVideo) { //视频选择
            if (self.pickVideoHandle) {
                self.pickVideoHandle();
            } else {
                NSLog(@"未操作视频选择");
            }
        } else { // 图片选择
            [self __pickImageWithCompleteBlock:self.pickImageCompleteBlock];
        }
        
    } otherItemCellDeleteBlock:^(id bDataModel) {
        CJImageUploadFileModelsOwner *dataModel = (CJImageUploadFileModelsOwner *)bDataModel;
        if (self.otherItemCellDeleteBlock) {
            self.otherItemCellDeleteBlock(dataModel);
        }
    }];
    
    self.pickImageCompleteBlock = pickImageCompleteBlock;
    self.pickVideoHandle = pickVideoHandle;
    self.otherItemCellConfigBlock = otherItemCellConfigBlock;
    self.otherItemCellDeleteBlock = otherItemCellDeleteBlock;
    
    return self;
}

/// 查看已添加的图片或者视频
- (void)__clickDataModelAtItemIndex:(NSInteger)itemIndex
                       inDataModels:(NSArray *)dataModels
{
    CJUploadFileModelsOwner *baseUploadItem = [dataModels objectAtIndex:itemIndex];
    
    CJUploadMomentInfo *momentInfo = baseUploadItem.momentInfo;
    if (momentInfo.uploadState == CJUploadMomentStateFailure) {
        return;
    }
    
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    
    UIViewController *currentShowingVC = [UIViewControllerCJHelper findCurrentShowingViewController];
    
    if (self.mediaType == CJMediaTypeVideo) {
        CJImageUploadFileModelsOwner *imageUploadItem = [dataModels objectAtIndex:itemIndex];
        NSString *localPath = [NSHomeDirectory() stringByAppendingPathComponent:imageUploadItem.localRelativePath];
        NSURL *videoURL = [NSURL fileURLWithPath:localPath];
        MPMoviePlayerViewController *moviePlayerController = [[MPMoviePlayerViewController alloc] initWithContentURL:videoURL];
        [moviePlayerController.moviePlayer prepareToPlay];
        moviePlayerController.moviePlayer.movieSourceType = MPMovieSourceTypeFile;
        [currentShowingVC presentMoviePlayerViewControllerAnimated:moviePlayerController];
        
    } else {
        for (CJImageUploadFileModelsOwner *imageUploadItem in dataModels) {
            UIImage *image = imageUploadItem.image;
            if (image == nil) {
                image = nil;    //试着从本地种查找
            }
            
        }
    }
}

/// 选择照片
- (void)__pickImageWithCompleteBlock:(void(^)(void))pickImageCompleteBlock {
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    __weak typeof(self)weakSelf = self;
    NSInteger canMaxChooseImageCount = self.currentCanMaxAddCount;
    
    [CJChooseFileActionSheetUtil defaultImageChooseWithCanMaxChooseImageCount:canMaxChooseImageCount pickCompleteBlock:^(NSArray<CJImageUploadFileModelsOwner *> * _Nonnull pickedImageItems) {
        [weakSelf addDtaModels:pickedImageItems];
        
        [weakSelf reloadData];
        
        if (weakSelf.pickImageCompleteBlock) {
            weakSelf.pickImageCompleteBlock();
        }
    }];
}



@end
