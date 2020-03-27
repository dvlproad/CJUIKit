//
//  CJHomeCollectionView.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/3/26.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CJBaseUtil/CJSectionDataModel.h>   //在CJDataUtil中
#import "CJHomeAdDataModel.h"
#import "CJHomeMenuDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJHomeCollectionView : UICollectionView {
    
}
@property (nonatomic, strong) NSArray<CJHomeAdDataModel *> *adDataModels;
@property (nonatomic, strong) NSMutableArray<CJSectionDataModel *> *menuSectionDataModels;


- (void)configClickHomeAdHandle:(void(^ _Nullable)(NSInteger adIndex))clickHomeAdHandle
            clickHomeMenuHandle:(void(^ _Nullable)(NSIndexPath *menuIndexPath))clickHomeMenuHandle;

@end

NS_ASSUME_NONNULL_END
