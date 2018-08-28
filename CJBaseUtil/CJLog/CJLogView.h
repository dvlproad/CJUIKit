//
//  CJLogViewWindow.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/3/11.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

/**
 *  一个在 iOS 设备屏幕上实时打印 Log 的小工具
 */
@interface CJLogView : UIView {
    
}

/**
 *  将appendObject追加写入视图
 *
 *  @param appendObject     要追加写入视图的数据（NSData、NSString、NSDictrionary、NSArray）
 */
- (void)appendObject:(id)appendObject;

///清空测试窗口
- (void)clear;

@end
