//
//  CJUIKitBaseCollectionHomeViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJUIKitBaseViewController.h"
#import <CJBaseUtil/CJSectionDataModel.h>   //在CJDataUtil中
#import <CJBaseUtil/CJModuleModel.h>        //在CJDataUtil中
#import <CJComplexUIKit/MyEqualCellSizeCollectionView.h>

@interface CJUIKitBaseCollectionHomeViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, strong) MyEqualCellSizeCollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray<CJSectionDataModel *> *sectionDataModels;

@end
