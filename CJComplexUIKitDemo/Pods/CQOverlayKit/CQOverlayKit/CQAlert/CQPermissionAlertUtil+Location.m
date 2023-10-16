//
//  CQPermissionAlertUtil+Location.m
//  CQOverlayKit
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQPermissionAlertUtil+Location.h"

@implementation CQPermissionAlertUtil (Location)

+ (void)showLocationAlert:(CQLocationAlertFor)alertFor {
    NSString *title = @"开启定位，精准推荐";
    NSString *desText = @"打开定位，推荐同城好友，匹配更准确";
    UIImage *flagImage = [CQPermissionAlertUtil cqAlert_imageNamed:@"alert_permission_location"];
    if (alertFor == CQLocationAlertForPhotoCard) {
        title = @"位置信息不可用";
        desText = @"开启定位服务，即可添加拍拍卡的定位信息噢";
    }
    
    [self showPermissionAlertWithTitle:title message:desText flagImage:flagImage];
}

@end
