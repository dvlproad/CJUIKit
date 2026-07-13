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
/*
#pragma mark - Init
+ (instancetype)new NS_UNAVAILABLE;
- (instancetype)init NS_DESIGNATED_INITIALIZER;
- (instancetype)initWithNibName:(nullable NSString *)nibNameOrNil bundle:(nullable NSBundle *)nibBundleOrNil NS_UNAVAILABLE;
- (instancetype)initWithCoder:(NSCoder *)aDecoder NS_UNAVAILABLE;
*/
@end

NS_ASSUME_NONNULL_END
