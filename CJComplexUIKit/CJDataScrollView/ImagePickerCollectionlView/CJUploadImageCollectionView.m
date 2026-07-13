//
//  CJUploadImageCollectionView.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/1/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJUploadImageCollectionView.h"
#import <CJCollectionViewLayout/CQCollectionViewFlowLayout.h>
#import <CQActionCollectionView/CJActionCollectionViewDataSource.h>
#import "CJUploadImageCollectionView+Tap.h"
#import "CJUploadCollectionViewCell.h"

static NSString * const CJUploadCollectionViewCellID = @"CJUploadCollectionViewCell";
static NSString * const CJUploadCollectionViewCellAddID = @"CJUploadCollectionViewCellAdd";

@interface CJUploadImageCollectionView () <UICollectionViewDataSource> {
    
}
@property (nonatomic, strong) CJActionCollectionViewDataSource *cjDataSource;

@end

@implementation CJUploadImageCollectionView

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self commonInit];
}


- (instancetype)initWithFrame:(CGRect)frame {
    UICollectionViewLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout {
    if (layout == nil) {
        layout = [[UICollectionViewFlowLayout alloc] init];
    }
    
    self = [super initWithFrame:frame collectionViewLayout:layout];
    if (self) {
        [self commonInit];
    }
    
    return self;
}


- (void)commonInit {
    //[super commonInit];
    
    self.dataModels = [[NSMutableArray alloc] init];
    
    /*
    {
        CJImageUploadFileModelsOwner *item = [[CJImageUploadFileModelsOwner alloc] init];
        item.image = [UIImage imageNamed:@"CJAvatar.png"];
        [self.dataModels addObject:item];
    }
    */
    CQCollectionViewFlowLayout *equalCellSizeSetting = [[CQCollectionViewFlowLayout alloc] init];
    //flowLayout.headerReferenceSize = CGSizeMake(110, 135);
    equalCellSizeSetting.minimumInteritemSpacing = 10;
    equalCellSizeSetting.minimumLineSpacing = 15;
    equalCellSizeSetting.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    
    //以下值必须二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）
    equalCellSizeSetting.cellWidthFromPerRowMaxShowCount = 4;
    //equalCellSizeSetting.cellWidthFromFixedWidth = 50;
    
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
    /* 创建DataSource */
    _maxDataModelShowCount = 5;
    CJActionCollectionViewDataSource *cjDataSource = [[CJActionCollectionViewDataSource alloc] initWithMaxShowCount:5 cellForPrefixBlock:nil cellForSuffixBlock:^UICollectionViewCell *(CJActionCollectionViewDataSource *bDataSource, UICollectionView *collectionView, NSIndexPath *indexPath) {
        return [weakSelf collectionView:collectionView cellForItemAtIndexPath:indexPath isExtralItem:YES];
    } cellForItemBlock:^UICollectionViewCell *(CJActionCollectionViewDataSource *bDataSource, UICollectionView *collectionView, NSIndexPath *indexPath) {
        return [weakSelf collectionView:collectionView cellForItemAtIndexPath:indexPath isExtralItem:NO];
    }];
    self.cjDataSource = cjDataSource;
    self.dataSource = self.cjDataSource;
    
    /* 设置Delegate */
    self.delegate = self;
}

#pragma mark - UICollectionViewDelegate
////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger itemIndex = [self.cjDataSource itemIndexByIndexPath:indexPath];
    if (itemIndex != -1) { // -1代表不是额外的item，而是数据
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
        
        CJUploadFileModelsOwner *baseUploadItem = [self.dataModels objectAtIndex:indexPath.row];
        
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

#pragma mark - UICollectionViewDataSource
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath
                            isExtralItem:(BOOL)isExtralItem
{
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
        NSString *bundleName = @"CJComplexUIKit_ImagePickerCollectionlView";
        NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
        NSURL *bundleURL = [frameworkBundle URLForResource:bundleName withExtension:@"bundle"];
        NSBundle *resourceBundle = bundleURL ? [NSBundle bundleWithURL:bundleURL] : nil;
        
        /*
        CJFullBottomCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"addCell" forIndexPath:indexPath];
        */
        CJUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CJUploadCollectionViewCellAddID forIndexPath:indexPath];
        
        cell.cjImageView.image = [UIImage imageNamed:@"cjCollectionViewCellAdd" inBundle:resourceBundle withConfiguration:nil];
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
    
    CJImageUploadFileModelsOwner *dataModel = [self.cjDataSource dataModelAtIndexPath:indexPath];
    if (isSettingOperate) {
        dataModel.indexPath = indexPath;
    }
    
    NSString *bundleName = @"CJComplexUIKit_ImagePickerCollectionlView";
    NSBundle *frameworkBundle = [NSBundle bundleForClass:[self class]];
    NSURL *bundleURL = [frameworkBundle URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *resourceBundle = bundleURL ? [NSBundle bundleWithURL:bundleURL] : nil;
    
    cell.cjImageView.image = [UIImage imageNamed:@"icons8-home" inBundle:resourceBundle withConfiguration:nil];
    if (cell.selected) {
        cell.cjImageView.image = [UIImage imageNamed:@"cjCollectionViewCellAdd" inBundle:resourceBundle withConfiguration:nil];
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
    
    CJImageUploadFileModelsOwner *baseUploadItem = [self.cjDataSource dataModelAtIndexPath:indexPath];
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
    
    CJImageUploadFileModelsOwner *baseUploadItem = [self.cjDataSource dataModelAtIndexPath:indexPath];
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
