//
//  CJUIKitBaseTabBarViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CQDMTabBarModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface CJUIKitBaseTabBarViewController : UITabBarController {
    
}
@property (nonatomic, strong) NSArray<CQDMTabBarModel *> *tabBarModels; /**< 标签页数据 */

@end

NS_ASSUME_NONNULL_END
