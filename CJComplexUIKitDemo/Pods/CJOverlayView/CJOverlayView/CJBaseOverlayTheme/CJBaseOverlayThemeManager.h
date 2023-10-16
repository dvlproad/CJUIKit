//
//  CJBaseOverlayThemeManager.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJBaseOverlayThemeModel.h"

@interface CJBaseOverlayThemeManager : NSObject {
    
}
@property (nonatomic, strong) CJBaseOverlayThemeModel *serviceThemeModel;

+ (CJBaseOverlayThemeManager *)sharedInstance;

/**
 *  获取当前正在使用的主题
 *
 *  @return serviceThemeModel
 */
+ (CJBaseOverlayThemeModel *)serviceThemeModel;

/// 获取sheet使用的主题
+ (CJOverlaySheetThemeModel *)sheetThemeModel;

@end
