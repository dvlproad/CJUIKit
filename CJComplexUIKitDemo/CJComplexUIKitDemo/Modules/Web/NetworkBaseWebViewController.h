//
//  NetworkBaseWebViewController.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2018/2/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#ifdef CJTESTComplexUIKitPOD
#import "CJBaseWebViewController.h"
#import "CJDataEmptyView.h"
#else
#import <CJComplexUIKit/CJBaseWebViewController.h>
#import <CJComplexUIKit/CJDataEmptyView.h>
#endif


@interface NetworkBaseWebViewController : CJBaseWebViewController

@property (nonatomic, strong) CJDataEmptyView *emptyView;
@property (nonatomic, copy) NSString *networkUrl; /**< web的网络地址(附：本地的因为不需要emptyView,所以直接继承CJBaseWebViewController即可) */

@end
