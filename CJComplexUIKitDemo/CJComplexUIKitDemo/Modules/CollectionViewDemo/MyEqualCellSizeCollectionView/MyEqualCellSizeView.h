//
//  MyEqualCellSizeView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/9/11.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#import "CQFilesLookCollectionView.h"

///用来测试将MyEqualCellSizeCollectionView包含在自定义的View中时候，时候会有错误
@interface MyEqualCellSizeView : UIView {
    
}
@property (nonatomic, strong) NSMutableArray<NSString *> *dataModels;/**< 数据源 */
@property (nonatomic, strong) CQFilesLookCollectionView *equalCellSizeCollectionView;

@end
