//
//  NSObjectCJHelperViewController.h
//  CJFoundationDemo
//
//  Created by ciyouzen on 2016/3/26.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJUIKitBaseHomeViewController.h"

#ifdef TEST_CJBASEHELPER_POD
#import "NSObjectCJHelper.h"
#else
#import <CJBaseHelper/NSObjectCJHelper.h>
#endif


@interface NSObjectCJHelperViewController : CJUIKitBaseHomeViewController {
    
}

@end
