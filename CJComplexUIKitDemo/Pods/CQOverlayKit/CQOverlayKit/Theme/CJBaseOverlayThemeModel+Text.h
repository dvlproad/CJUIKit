//
//  CJBaseOverlayThemeModel+Text.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 7/9/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <CJOverlayView/CJBaseOverlayThemeModel.h>

// UI
#import "CQToastThemeModel.h"
#import "CQHUDThemeModel.h"

// 文本(主要处理国际化类型)
#import "CQOverlayTextModel.h"

@interface CJBaseOverlayThemeModel (Text)

@property (nonatomic, strong) CQToastThemeModel *toastThemeModel;
@property (nonatomic, strong) CQHUDThemeModel *hudThemeModel;
@property (nonatomic, strong) CQOverlayTextModel *overlayTextModel;     /**< Overlay文本(主要处理国际化类型) */

@end
