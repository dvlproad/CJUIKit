//
//  LECollectionView.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/3/26.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CJBaseUtil/CJSectionDataModel.h>   //在CJDataUtil中
#import "LEMenuDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LECollectionView : UICollectionView {
    
}
@property (nonatomic, strong) NSMutableArray<CJSectionDataModel *> *menuSectionDataModels;

@end

NS_ASSUME_NONNULL_END
