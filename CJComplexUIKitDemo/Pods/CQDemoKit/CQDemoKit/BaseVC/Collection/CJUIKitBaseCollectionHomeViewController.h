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

@interface CJUIKitBaseCollectionHomeViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<CQDMSectionDataModel *> *sectionDataModels;

@end
