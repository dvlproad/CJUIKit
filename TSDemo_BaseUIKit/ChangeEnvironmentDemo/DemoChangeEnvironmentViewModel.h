//
//  DemoChangeEnvironmentViewModel.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/14.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DemoChangeEnvironmentViewModel : NSObject {
    
}
/**< 改变环境按钮 */
@property (nonatomic, strong) UIButton *changeEnvironmentButton;

/**< 完成改变环境后的回调 */
@property (nonatomic, copy) void(^completeChangeEnvironment)(NSInteger currentEnvironmentIndex);

@end
