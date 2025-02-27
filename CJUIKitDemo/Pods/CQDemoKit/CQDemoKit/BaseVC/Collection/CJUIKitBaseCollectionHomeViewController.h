//
//  CJUIKitBaseCollectionHomeViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJUIKitBaseViewController.h"
#import "CQDMSectionDataModel.h"
#import "CQDMModuleModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJUIKitBaseCollectionHomeViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<CQDMSectionDataModel *> *sectionDataModels;

@property (nonatomic, assign) NSInteger perMaxCount;
@property (nonatomic) UICollectionViewScrollDirection scrollDirection;

@end

NS_ASSUME_NONNULL_END
