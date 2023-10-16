//
//  CQPermissionAlertUtil+Location.h
//  CQOverlayKit
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQPermissionAlertUtil.h"

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, CQLocationAlertFor) {
    CQLocationAlertForNormal = 0,
    CQLocationAlertForPhotoCard,
};

@interface CQPermissionAlertUtil (Location)

+ (void)showLocationAlert:(CQLocationAlertFor)alertFor;

@end

NS_ASSUME_NONNULL_END
