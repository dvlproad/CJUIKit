//
//  CQActionImageCollectionView.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/1/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQActionImageCollectionViewCell.h"

@interface CQActionImageCollectionView : UICollectionView {
    
}
@property (nonatomic, assign, readonly) NSInteger currentCanMaxAddCount;  /**< 当前剩余最多可添加多少个 */
@property (nonatomic, strong, readonly) NSMutableArray<UIImage *> *imageModels;

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
                   otherItemCellDeleteBlock:(void(^)(UIImage *bImageModel))otherItemCellDeleteBlock NS_DESIGNATED_INITIALIZER;
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout NS_UNAVAILABLE;

/// 添加数据
- (void)addImageModels:(NSArray<UIImage *> *)imageModels;

@end
