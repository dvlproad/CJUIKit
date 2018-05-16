//
//  CJDeviceUtil.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2017/7/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface CJDeviceUtil : NSObject

#pragma mark - 电池Battery
///获取电池电量(一般用百分数表示,大家自行处理就好)
+ (CGFloat)getBatteryQuantity;

///获取电池状态(UIDeviceBatteryState为枚举类型)
+ (UIDeviceBatteryState)getBatteryStauts;

#pragma mark - 内存Memory & 磁盘容量
///获取总内存大小
+ (long long)getTotalMemorySize;

///获取当前未使用(即可用)内存
+ (long long)getAvailableMemorySize;

///获取已使用内存
+ (double)getUsedMemory;

///获取总磁盘容量
+ (long long)getTotalDiskSize;

///获取未使用(可用)磁盘容量
+ (long long)getAvailableDiskSize;


#pragma mark - 手机型号
/**
 *  手机型号
 *  @brief:可以根据自己的需求增改。有人说也可以按照手机屏幕来判断，但5和5s/5c等手机屏幕相同尺寸则无法判断。。。我只做了iPhone的机型，所以iPad和iPod Touch的信息并没有更新到最新，也请朋友们补充。
 *
 *  @return 手机型号
 */
+ (NSString *)getCurrentDeviceName;



#pragma mark - IP & WIFI
///获取手机IP地址
+ (NSString *)getIPAddress;

/**
 *  获取当前手机连接的WIFI名称(即SSID)(SSID全称Service Set IDentifier, 即Wifi网络的公开名称)
 *  @brief  模拟器测试无效，始终为空，真机有效
 *
 */
+ (NSString *)getWifiName;

@end
