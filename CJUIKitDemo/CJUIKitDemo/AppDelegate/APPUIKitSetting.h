//
//  APPUIKitSetting.h
//  AppCommonUICollect
//
//  Created by ciyouzen on 2019/3/15.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifdef TEST_CJBASEUIKIT_POD
#import "UIColor+CJHex.h"
#else
#import <LuckinBaseUIKit/UIColor+CJHex.h>
#endif


@interface APPUIKitSetting : NSObject {
    
}
/// 设置所有UIKit的主题
+ (void)configAppThemeUIKit;

@end
