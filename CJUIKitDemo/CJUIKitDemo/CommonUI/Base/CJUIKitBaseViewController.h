//
//  CJUIKitBaseViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>
#ifdef TEST_CJBASEUIKIT_POD
#import "UIColor+CJHex.h"
#import "CJToast.h"
#else
#import <CJBaseUIKit/UIColor+CJHex.h>
#import <CJBaseUIKit/CJToast.h>
#endif

@interface CJUIKitBaseViewController : UIViewController

@end
