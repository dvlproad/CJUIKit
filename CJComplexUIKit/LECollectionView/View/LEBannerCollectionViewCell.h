//
//  LEBannerCollectionViewCell.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/22.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEADPosModel.h"

NS_ASSUME_NONNULL_BEGIN

typedef void (^SingleBannerActivityClickBlock) (LEADPosModel *posModel, NSInteger index);

@interface LEBannerCollectionViewCell : UICollectionViewCell

@property (nonatomic, copy)SingleBannerActivityClickBlock activityClickBlock;
-(void)setValueCellWithModel:(LEADPosModelList *) listModel;

@end

NS_ASSUME_NONNULL_END
