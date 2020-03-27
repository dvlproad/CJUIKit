//
//  CJHomeAdCollectionViewCell.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/22.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJHomeAdDataModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJHomeAdCollectionViewCell : UICollectionViewCell {
    
}
@property (nonatomic, strong) NSArray<CJHomeAdDataModel *> *adDataModels;
@property (nonatomic, copy) void (^activityClickBlock) (CJHomeAdDataModel *posModel, NSInteger index);

@end

NS_ASSUME_NONNULL_END
