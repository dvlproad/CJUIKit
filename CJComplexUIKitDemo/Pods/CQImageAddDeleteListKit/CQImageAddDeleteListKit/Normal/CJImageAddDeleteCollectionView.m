//
//  CJImageAddDeleteCollectionView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJImageAddDeleteCollectionView.h"
#import <CJCollectionViewLayout/CQCollectionViewFlowLayout.h>
#import "CJImageAddDeleteCollectionViewDataSource.h"

static NSString * const CJUploadCollectionViewCellID = @"CJUploadCollectionViewCell";
static NSString * const CJUploadCollectionViewCellAddID = @"CJUploadCollectionViewCellAdd";

@interface CJImageAddDeleteCollectionView () <UICollectionViewDelegate> {
    
}
@property (nonatomic, strong) CJImageAddDeleteCollectionViewDataSource *cjDataSource;
@property (nonatomic, copy) void (^configItemCellBlock)(CJUploadCollectionViewCell *bItemCell, id bDataModel);
@property (nonatomic, copy) void(^clickItemHandle)(NSArray *bDataModels, NSInteger currentClickItemIndex);
@property (nonatomic, copy) void(^addHandle)(void);
@property (nonatomic, copy) void(^otherItemCellDeleteBlock)(NSIndexPath *indexPath);

@end


@implementation CJImageAddDeleteCollectionView

/*
 *  初始化方法
 *
 *  @param configItemCellBlock  设置 itemCell 的方法（不能为nil）
 *  @param clickItemHandle      点击item时候的操作(如查看大图)
 *  @param addHandle            添加操作
 *  @param otherItemCellDeleteBlock  itemCell的其他属性如删除照片后，还要执行取消之前没结束的上传请求方法(一般为nil)
 *
 *  @return 返回
 */
- (instancetype)initWithConfigItemCellBlock:(void (^)(CJUploadCollectionViewCell *bItemCell, id bDataModel))configItemCellBlock
                            clickItemHandle:(void(^)(NSArray *bDataModels, NSInteger currentClickItemIndex))clickItemHandle
                                  addHandle:(void(^)(void))addHandle
                   otherItemCellDeleteBlock:(void(^)(id bDataModel))otherItemCellDeleteBlock
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
            self.clickItemHandle(self.cjDataSource.dataModels, itemIndex);
        }
    } else {
        //NSLog(@"点击额外的item");
        if (self.addHandle) {
            self.addHandle();
        }
    }
}

#pragma mark - SetupViews
- (void)setupViews {
    self.backgroundColor = [UIColor clearColor];
    
    //以下值，可选设置
    self.allowsMultipleSelection = YES; //是否打开多选
    
    /* 设置Register的Cell或Nib */
    CJUploadCollectionViewCell *registerCell = [[CJUploadCollectionViewCell alloc] init];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:CJUploadCollectionViewCellID];
    [self registerClass:[registerCell class] forCellWithReuseIdentifier:CJUploadCollectionViewCellAddID];

    
    /* 创建DataSource */
    CJImageAddDeleteCollectionViewDataSource *cjDataSource = [[CJImageAddDeleteCollectionViewDataSource alloc] initWithMaxShowCount:5 cellForPrefixBlock:^UICollectionViewCell *(CJImageAddDeleteCollectionViewDataSource *bDataSource, UICollectionView *collectionView, NSIndexPath *indexPath) {
        CJUploadCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CJUploadCollectionViewCellAddID forIndexPath:indexPath];
        
        cell.cjImageView.image = [UIImage imageNamed:@"CQImageAddDeleteListKit_NormalBundle.bundle/cjCollectionViewCellAdd"];
        [cell.cjDeleteButton setImage:nil forState:UIControlStateNormal];
        
        return cell;
        
    } cellForSuffixBlock:nil cellForItemBlock:^UICollectionViewCell *(CJImageAddDeleteCollectionViewDataSource *bDataSource, UICollectionView *collectionView, NSIndexPath *indexPath) {
    
        CJUploadCollectionViewCell *dataCell = [collectionView dequeueReusableCellWithReuseIdentifier:CJUploadCollectionViewCellID forIndexPath:indexPath];
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


#pragma mark - Event
- (void)addDtaModels:(NSArray *)dataModels {
    [self.cjDataSource.dataModels addObjectsFromArray:dataModels];
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
- (void)__operateDataCell:(CJUploadCollectionViewCell *)dataCell
            withIndexPath:(NSIndexPath *)indexPath
         isSettingOperate:(BOOL)isSettingOperate
{
    id dataModel = [self.cjDataSource dataModelAtIndexPath:indexPath];
    self.configItemCellBlock(dataCell, dataModel);
    
    dataCell.backgroundColor = [UIColor whiteColor];
    
    // cell 的删除操作
    __weak typeof(self)weakCollectionView = self;
    dataCell.deleteHandle = ^(CJUploadCollectionViewCell *baseCell) {
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
