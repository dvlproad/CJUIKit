//
//  PresentBaseViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/8/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseViewController.h"

#ifdef TEST_CJBASEHELPER_POD
#import "UIViewControllerCJHelper.h"
#else
#import <CJBaseHelper/UIViewControllerCJHelper.h>
#endif


@interface PresentBaseViewController : CJUIKitBaseViewController {
    
}
@property (nonatomic, strong) UILabel *resultClassNameLabel;

@end
