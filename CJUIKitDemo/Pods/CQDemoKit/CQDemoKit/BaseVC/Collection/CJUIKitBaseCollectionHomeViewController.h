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

/*
#pragma mark - Init
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
*/


@end

NS_ASSUME_NONNULL_END
