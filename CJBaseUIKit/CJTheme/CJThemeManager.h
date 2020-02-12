//
//  CJThemeManager.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CJThemeModel.h"

@interface CJThemeManager : NSObject {
    
}
@property (nonatomic, strong) CJThemeModel *serviceThemeModel;

+ (CJThemeManager *)sharedInstance;

/**
 *  获取当前正在使用的主题
 *
 *  @return serviceThemeModel
 */
+ (CJThemeModel *)serviceThemeModel;

@end
