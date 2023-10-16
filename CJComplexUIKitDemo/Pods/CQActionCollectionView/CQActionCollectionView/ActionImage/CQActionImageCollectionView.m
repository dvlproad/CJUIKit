//
//  CQActionImageCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CQActionImageCollectionView.h"
#import <CJCollectionViewLayout/CQCollectionViewFlowLayout.h>
#import "CJActionCollectionViewDataSource.h"

static NSString * const CJUploadCollectionViewCellID = @"CQActionImageCollectionViewCell";
static NSString * const CJUploadCollectionViewCellAddID = @"CJUploadCollectionViewCellAdd";

@interface CQActionImageCollectionView () <UICollectionViewDelegate> {
    
}
@property (nonatomic, strong) CJActionCollectionViewDataSource *cjDataSource;
@property (nonatomic, copy) void (^configItemCellBlock)(CQActionImageCollectionViewCell *bItemCell, UIImage *bImageModel);
@property (nonatomic, copy) void(^clickItemHandle)(NSArray *bDataModels, NSInteger currentClickItemIndex);
@property (nonatomic, copy) void(^addHandle)(CQActionImageCollectionView *bCollectionView);
@property (nonatomic, copy) void(^otherItemCellDeleteBlock)(UIImage *bImageModel);

@end


@implementation CQActionImageCollectionView

/*
*  初始化方法
*
*  @param configItemCellBlock       设置 itemCell 的方法（不能为nil）
*  @param clickItemHandle           点击item时候的操作(如查看大图)
*  @param addHandle                 添加操作(请调用 [bCollectionView addDtaModels:@[xxx]])
*  @param otherItemCellDeleteBlock  itemCell的其他属性如删除照片后，还要执行取消之前没结束的上传请求方法(一般为nil)
*
*  @return 返回图片添加删除列表
*/
- (instancetype)initWithConfigItemCellBlock:(void (^)(CQActionImageCollectionViewCell *bItemCell, UIImage *bImageModel))configItemCellBlock
                            clickItemHandle:(void(^)(NSArray *bDataModels, NSInteger currentClickItemIndex))clickItemHandle
                                  addHandle:(void(^)(CQActionImageCollectionView *bCollectionView))addHandle
                   otherItemCellDeleteBlock:(void(^)(UIImage *bImageModel))otherItemCellDeleteBlock
{
    NSAssert(configItemCellBlock != nil, @"cell设置方法不能为空");
    
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
        [self setupViews];
        
        self.configItemCellBlock = configItemCellBlock;
        self.clickItemHandle = clickItemHandle;
        self.addHandle = addHandle;
        self.otherItemCellDeleteBlock = otherItemCellDeleteBlock;
    }
    return self;
}

#pragma mark - UICollectionViewDelegate
////“点到”item时候执行的时间(allowsMultipleSelection为默认的NO的时候，只有选中，而为YES的时候有选中和取消选中两种操作)
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger itemIndex = [self.cjDataSource itemIndexByIndexPath:indexPath];
    if (itemIndex != -1) { // -1代表不是额外的item
        if (self.clickItemHandle) {
            self.clickItemHandle(self.imageModels, itemIndex);
        }
    } else {
        //NSLog(@"点击额外的item");
        if (self.addHandle) {
            self.addHandle(self);
        }
    }
}

#pragma mark - SetupViews
- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    
    //以下值，可选设置
    self.allowsMultipleSelection = YES; //是否打开多选
    
    /* 设置Register的Cell或Nib */
    CQActionImageCollectionViewCell *registerCell = [[CQActionImageCollectionViewCell alloc] init];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:CJUploadCollectionViewCellID];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:CJUploadCollectionViewCellAddID];

    
    /* 创建DataSource */
    CJActionCollectionViewDataSource *cjDataSource = [[CJActionCollectionViewDataSource alloc] initWithMaxShowCount:5 cellForPrefixBlock:nil cellForSuffixBlock:^UICollectionViewCell *(CJActionCollectionViewDataSource *bDataSource, UICollectionView *collectionView, NSIndexPath *indexPath) {
        CQActionImageCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CJUploadCollectionViewCellAddID forIndexPath:indexPath];
        cell.isAdd = YES;
        
        return cell;
    } cellForItemBlock:^UICollectionViewCell *(CJActionCollectionViewDataSource *bDataSource, UICollectionView *collectionView, NSIndexPath *indexPath) {
    
        CQActionImageCollectionViewCell *dataCell = [collectionView dequeueReusableCellWithReuseIdentifier:CJUploadCollectionViewCellID forIndexPath:indexPath];
        dataCell.isAdd = NO;
        
        [self __operateDataCell:dataCell withIndexPath:indexPath isSettingOperate:YES];
        
        return dataCell;
    }];
    self.cjDataSource = cjDataSource;
    
    /* 设置DataSource和Delegate */
    self.dataSource = self.cjDataSource;
    self.delegate = self;
}



- (NSInteger)currentCanMaxAddCount {
    return self.cjDataSource.currentCanMaxAddCount;
}

#pragma mark - Getter
- (NSMutableArray<UIImage *> *)imageModels {
    return self.cjDataSource.dataModels;
}

#pragma mark - Event
/// 添加数据
- (void)addImageModels:(NSArray<UIImage *> *)imageModels {
    [self.imageModels addObjectsFromArray:imageModels];
    [self reloadData];
}


#pragma mark - Private Method
/*
 *  设置或者更新Cell
 *
 *  @param cell             要设置或者更新的Cell
 *  @param indexPath        要设置或者更新的Cell的indexPath
 *  @param isSettingOperate 是否是设置，如果否则为更新
 */
- (void)__operateDataCell:(CQActionImageCollectionViewCell *)dataCell
            withIndexPath:(NSIndexPath *)indexPath
         isSettingOperate:(BOOL)isSettingOperate
{
    id dataModel = [self.cjDataSource dataModelAtIndexPath:indexPath];
    self.configItemCellBlock(dataCell, dataModel);
    
    dataCell.backgroundColor = [UIColor whiteColor];
    
    // cell 的删除操作
    __weak typeof(self)weakCollectionView = self;
    dataCell.deleteHandle = ^(CQActionImageCollectionViewCell *baseCell) {
        NSIndexPath *indexPath = [weakCollectionView indexPathForCell:baseCell];
        
        __strong __typeof(weakCollectionView)strongCollectionView = weakCollectionView;
        [strongCollectionView.cjDataSource deletePhotoAtIndexPath:indexPath];
        [strongCollectionView deleteItemsAtIndexPaths:@[indexPath]];
        
        if (self.otherItemCellDeleteBlock) {
            self.otherItemCellDeleteBlock(dataModel);
        }
    };
}


@end
