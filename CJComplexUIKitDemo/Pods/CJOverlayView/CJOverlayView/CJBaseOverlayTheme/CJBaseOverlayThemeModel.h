//
//  CJBaseOverlayThemeModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJOverlayCommonThemeModel.h"
#import "CJOverlayAlertThemeModel.h"
#import "CJOverlaySheetThemeModel.h"

@interface CJBaseOverlayThemeModel : NSObject {
    
}
@property (nonatomic, strong) CJOverlayCommonThemeModel *commonThemeModel;
@property (nonatomic, strong) CJAlertThemeModel *alertThemeModel;
@property (nonatomic, strong) CJOverlaySheetThemeModel *sheetThemeModel;

@end
