//
//  CJImageAddDeleteCollectionView.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/1/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJUploadCollectionViewCell.h"

@interface CJImageAddDeleteCollectionView : UICollectionView {
    
}
@property (nonatomic, assign) NSInteger currentCanMaxAddCount;  /**< 当前剩余最多可添加多少个 */

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
                   otherItemCellDeleteBlock:(void(^)(id bDataModel))otherItemCellDeleteBlock;


/// 添加数据
- (void)addDtaModels:(NSArray *)dataModels;

@end
