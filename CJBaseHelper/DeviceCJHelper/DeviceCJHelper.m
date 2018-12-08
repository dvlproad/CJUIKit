//
//  DeviceCJHelper.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2017/7/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "DeviceCJHelper.h"

//为了获取设备型号引入下面头文件
#import <sys/utsname.h>

//为了获取内存引入下面头文件
#import <mach/mach_host.h>
#import <mach/task.h>

//为了获取磁盘大小引入下面头文件
#import <sys/mount.h>

//为了获取本地IP引入下面头文件
#import <arpa/inet.h>
#import <ifaddrs.h>

//为了获取WIFI引入下面头文件
#import <SystemConfiguration/CaptiveNetwork.h>

//为了根据域名host获取ip引入下面的头文件
#include <netdb.h>
#include <sys/socket.h>

@implementation DeviceCJHelper

#pragma mark - 电池Battery
///获取电池电量(一般用百分数表示,大家自行处理就好)
+ (CGFloat)getBatteryQuantity
{
    return [[UIDevice currentDevice] batteryLevel];
}

///获取电池状态(UIDeviceBatteryState为枚举类型)
+ (UIDeviceBatteryState)getBatteryStauts
{
    return [UIDevice currentDevice].batteryState;
}


#pragma mark - 屏幕亮度
///获取屏幕亮度(这个值介于0和1之间,且屏幕的亮度调节只能在真机上看到效果 在模拟器上看不到效果)
+ (CGFloat)getScreenBrightness
{
    CGFloat currentScreenBrightness = [[UIScreen mainScreen] brightness];
    return currentScreenBrightness;
}

#pragma mark - 内存Memory & 磁盘容量
///获取总内存大小
+ (long long)getTotalMemorySize
{
    return [NSProcessInfo processInfo].physicalMemory;
}

///获取当前未使用(即可用)内存
+ (long long)getAvailableMemorySize
{
    vm_statistics_data_t vmStats;
    mach_msg_type_number_t infoCount = HOST_VM_INFO_COUNT;
    kern_return_t kernReturn = host_statistics(mach_host_self(), HOST_VM_INFO, (host_info_t)&vmStats, &infoCount);
    if (kernReturn != KERN_SUCCESS)
    {
        return NSNotFound;
    }
    return ((vm_page_size * vmStats.free_count + vm_page_size * vmStats.inactive_count));
}

///获取已使用内存
+ (double)getUsedMemory
{
    task_basic_info_data_t taskInfo;
    mach_msg_type_number_t infoCount = TASK_BASIC_INFO_COUNT;
    kern_return_t kernReturn = task_info(mach_task_self(),
                                         TASK_BASIC_INFO,
                                         (task_info_t)&taskInfo,
                                         &infoCount);
    
    if (kernReturn != KERN_SUCCESS
        ) {
        return NSNotFound;
    }
    
    return taskInfo.resident_size;
}

///获取总磁盘容量
+ (long long)getTotalDiskSize
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_blocks);
    }
    return freeSpace;
}

///获取未使用(可用)磁盘容量
+ (long long)getAvailableDiskSize
{
    struct statfs buf;
    unsigned long long freeSpace = -1;
    if (statfs("/var", &buf) >= 0)
    {
        freeSpace = (unsigned long long)(buf.f_bsize * buf.f_bavail);
    }
    return freeSpace;
}


#pragma mark - 手机型号
/**
 *  手机型号
 *  @brief:可以根据自己的需求增改。有人说也可以按照手机屏幕来判断，但5和5s/5c等手机屏幕相同尺寸则无法判断。。。我只做了iPhone的机型，所以iPad和iPod Touch的信息并没有更新到最新，也请朋友们补充。
 *
 *  @return 手机型号
 */
+ (NSString *)getCurrentDeviceName
{
    struct utsname systemInfo;
    uname(&systemInfo);
    
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    
    platform = [self getFullDeviceNameByPlatform:platform];
    
    return platform;
}


///获取完整的设备型号
+ (NSString *)getFullDeviceNameByPlatform:(NSString *)platform {
    //iPhone系列
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4 (A1332)";
    if ([platform isEqualToString:@"iPhone3,3"])    return @"iPhone 4 (A1349)";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4s (A1387/A1431)";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5 (A1428)";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5 (A1429/A1442)";
    if ([platform isEqualToString:@"iPhone5,3"])    return @"iPhone 5c (A1456/A1532)";
    if ([platform isEqualToString:@"iPhone5,4"])    return @"iPhone 5c (A1507/A1516/A1526/A1529)";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5s (A1453/A1533)";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5s (A1457/A1518/A1528/A1530)";
    if ([platform isEqualToString:@"iPhone7,1"])    return @"iPhone 6 Plus (A1522/A1524)";
    if ([platform isEqualToString:@"iPhone7,2"])    return @"iPhone 6 (A1549/A1586)";
    if ([platform isEqualToString:@"iPhone8,1"])    return @"iPhone 6s";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone8,2"])    return @"iPhone 6s Plus";
    if ([platform isEqualToString:@"iPhone9,1"])    return @"iPhone 7 (CDMA)";
    if ([platform isEqualToString:@"iPhone9,3"])    return @"iPhone 7 (GSM)";
    if ([platform isEqualToString:@"iPhone9,2"])    return @"iPhone 7 Plus (CDMA)";
    if ([platform isEqualToString:@"iPhone9,4"])    return @"iPhone 7 Plus (GSM)";
    
    //iPod
    if ([platform isEqualToString:@"iPod1,1"])   return @"iPod Touch 1G (A1213)";
    if ([platform isEqualToString:@"iPod2,1"])   return @"iPod Touch 2G (A1288)";
    if ([platform isEqualToString:@"iPod3,1"])   return @"iPod Touch 3G (A1318)";
    if ([platform isEqualToString:@"iPod4,1"])   return @"iPod Touch 4G (A1367)";
    if ([platform isEqualToString:@"iPod5,1"])   return @"iPod Touch 5G (A1421/A1509)";
    
    //iPad系列
    if ([platform isEqualToString:@"iPad1,1"])   return @"iPad 1G (A1219/A1337)";
    if ([platform isEqualToString:@"iPad2,1"])   return @"iPad 2 (A1395)";
    if ([platform isEqualToString:@"iPad2,2"])   return @"iPad 2 (A1396)";
    if ([platform isEqualToString:@"iPad2,3"])   return @"iPad 2 (A1397)";
    if ([platform isEqualToString:@"iPad2,4"])   return @"iPad 2 (A1395+New Chip)";
    if ([platform isEqualToString:@"iPad2,5"])   return @"iPad Mini 1G (A1432)";
    if ([platform isEqualToString:@"iPad2,6"])   return @"iPad Mini 1G (A1454)";
    if ([platform isEqualToString:@"iPad2,7"])   return @"iPad Mini 1G (A1455)";
    
    if ([platform isEqualToString:@"iPad3,1"])   return @"iPad 3 (A1416)";
    if ([platform isEqualToString:@"iPad3,2"])   return @"iPad 3 (A1403)";
    if ([platform isEqualToString:@"iPad3,3"])   return @"iPad 3 (A1430)";
    if ([platform isEqualToString:@"iPad3,4"])   return @"iPad 4 (A1458)";
    if ([platform isEqualToString:@"iPad3,5"])   return @"iPad 4 (A1459)";
    if ([platform isEqualToString:@"iPad3,6"])   return @"iPad 4 (A1460)";
    
    if ([platform isEqualToString:@"iPad4,1"])   return @"iPad Air (A1474)";
    if ([platform isEqualToString:@"iPad4,2"])   return @"iPad Air (A1475)";
    if ([platform isEqualToString:@"iPad4,3"])   return @"iPad Air (A1476)";
    if ([platform isEqualToString:@"iPad4,4"])   return @"iPad Mini 2G (A1489)";
    if ([platform isEqualToString:@"iPad4,5"])   return @"iPad Mini 2G (A1490)";
    if ([platform isEqualToString:@"iPad4,6"])   return @"iPad Mini 2G (A1491)";
    
    //Simulator系列
    if ([platform isEqualToString:@"i386"])      return @"iPhone Simulator";
    if ([platform isEqualToString:@"x86_64"])    return @"iPhone Simulator";
    
    return platform;
}

#pragma mark - IP & WIFI
///根据域名host获取ip引入下面的头文件
+ (NSString *)getIPAddressByHostName:(NSString *)hostName {
    //需要的头文件 #include <netdb.h> 和 #include <sys/socket.h>
    const char *hostN= [hostName UTF8String];
    struct hostent* phot;
    @try {
        phot = gethostbyname(hostN);
        if (phot == NULL) {
            NSLog(@"DNS解析 失败");
            return nil;
        }
        
    } @catch (NSException *exception) {
        return nil;
    }
    
    struct in_addr ip_addr;
    memcpy(&ip_addr, phot->h_addr_list[0], 4);
    //h_addr_list[0]里4个字节,每个字节8位，此处为一个数组，一个域名对应多个ip地址或者本地时一个机器有多个网卡
    
    char ip[20] = {0};
    inet_ntop(AF_INET, &ip_addr, ip, sizeof(ip));
    
    NSString *ipAddressString = [NSString stringWithUTF8String:ip];
    return ipAddressString;
}

///获取手机IP地址
+ (NSString *)getIPAddress {
    /*
    NSString *address = @"an error occurred when obtaining ip address";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    
    success = getifaddrs(&interfaces);
    
    if (success == 0) { // 0 表示获取成功
        
        temp_addr = interfaces;
        while (temp_addr != NULL) {
            if( temp_addr->ifa_addr->sa_family == AF_INET) {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"]) {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            
            temp_addr = temp_addr->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
    */
    NSString* address;
    struct ifaddrs *interfaces = nil;
    
    // get all our interfaces and find the one that corresponds to wifi
    if (!getifaddrs(&interfaces))
    {
        for (struct ifaddrs* addr = interfaces; addr != NULL; addr = addr->ifa_next)
        {
            if (([[NSString stringWithUTF8String:addr->ifa_name] isEqualToString:@"en0"]) &&
                (addr->ifa_addr->sa_family == AF_INET))
            {
                struct sockaddr_in* sa = (struct sockaddr_in*) addr->ifa_addr;
                address = [NSString stringWithUTF8String:inet_ntoa(sa->sin_addr)];
                break;
            }
        }
    }
    freeifaddrs(interfaces);
    return address;
}

///获取当前手机连接的WIFI名称(SSID)
+ (NSString *)getWifiName
{
    NSString *wifiName = nil;
    
    CFArrayRef wifiInterfaces = CNCopySupportedInterfaces();
    if (!wifiInterfaces) {
        return nil;
    }
    
    NSArray *interfaces = (__bridge NSArray *)wifiInterfaces;
    
    for (NSString *interfaceName in interfaces) {
        CFDictionaryRef dictRef = CNCopyCurrentNetworkInfo((__bridge CFStringRef)(interfaceName));
        
        if (dictRef) {
            NSDictionary *networkInfo = (__bridge NSDictionary *)dictRef;
            
            wifiName = [networkInfo objectForKey:(__bridge NSString *)kCNNetworkInfoKeySSID];
            
            CFRelease(dictRef);
        }
    }
    
    CFRelease(wifiInterfaces);
    return wifiName;
}

@end
