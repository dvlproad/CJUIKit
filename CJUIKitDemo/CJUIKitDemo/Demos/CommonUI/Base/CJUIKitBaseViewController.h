//
//  CJUIKitBaseViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

#ifdef CJTESTPOD
#import "CJSectionDataModel.h"
#import "CJModuleModel.h"
#else
#import <CJBaseUtil/CJSectionDataModel.h>   //在CJDataUtil中
#import <CJBaseUtil/CJModuleModel.h>        //在CJDataUtil中
#endif

@interface CJUIKitBaseViewController : UIViewController

@end
