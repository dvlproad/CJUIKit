//
//  EmptyWebViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/2/8.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "BaseWebViewController.h"
#import "DemoEmptyView.h"

@interface EmptyWebViewController : BaseWebViewController

@property (nonatomic, strong) DemoEmptyView *emptyView;
@property (nonatomic, copy) NSString *networkUrl; /**< web的网络地址(附：本地的因为不需要emptyView,所以直接继承BaseWebViewController即可) */

@end
