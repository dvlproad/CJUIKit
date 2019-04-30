//
//  AuthorizationCJHelperViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 12/7/18.
//  Copyright © 2018 dvlproad. All rights reserved.
//

#import "CJUIKitBaseHomeViewController.h"

#ifdef TEST_CJBASEHELPER_POD
#import "AuthorizationCJHelper.h"
#else
#import <CJBaseHelper/AuthorizationCJHelper.h>
#endif

NS_ASSUME_NONNULL_BEGIN

@interface AuthorizationCJHelperViewController : CJUIKitBaseHomeViewController

@end

NS_ASSUME_NONNULL_END
