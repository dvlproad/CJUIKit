//
//  CQJumpMapUtil.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2019/4/17.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "CQJumpMapUtil.h"
#import "CQOverlayTheme.h"

@implementation CQJumpMapUtil

/// 获取默认的导航地图软件类型
+ (CQMapType)defaultMapType {
    CQMapType mapType = (CQMapType)[[[NSUserDefaults standardUserDefaults] objectForKey:@"navigationMapType"] integerValue]; //默认地图导航软件
    return mapType;
}

/// 获取默认的导航地图软件名称
+ (NSString *)defaultMapTitle {
    NSString *sheetBaiduMapText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.sheetBaiduMapText;
    NSString *sheetAmapText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.sheetAmapText;
    NSString *sheetAppleMapText = [CJBaseOverlayThemeManager serviceThemeModel].overlayTextModel.sheetAppleMapText;
    
    CQMapType mapType = [self defaultMapType]; //默认地图导航软件
    if (mapType == CQMapTypeBMKMap) {
        return sheetBaiduMapText;
    } else if (mapType == CQMapTypeAMap) {
        return sheetAmapText;
    } else if (mapType == CQMapTypeAppleMap) {
        return sheetAppleMapText;
    } else {
        return @"";
    }
}

/// 更新默认的导航地图软件
+ (void)updateDefaultMapType:(CQMapType)mapType {
    [[NSUserDefaults standardUserDefaults] setObject:@(mapType) forKey:@"navigationMapType"];
}

/// 打开百度地图
+ (void)openBMKMapWithCanOpen:(BOOL)canOpenBaiduMap lat:(CGFloat)lat lon:(CGFloat)lon {
    if (canOpenBaiduMap) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"baidumap://map/ridenavi?destination=%f,%f&coord_type=gcj02&src=com.dvlproad.CJUIKitDemo",lat,lon]]];
    } else {
        [self goToDownloadBaiduMap];
    }
}

+ (void)goToDownloadBaiduMap
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E7%99%BE%E5%BA%A6%E5%9C%B0%E5%9B%BE-%E8%B7%AF%E7%BA%BF%E8%A7%84%E5%88%92-%E5%87%BA%E8%A1%8C%E5%BF%85%E5%A4%87/id452186370?mt=8"]];
}

/// 打开高德地图
+ (void)openAMapWithCanOpen:(BOOL)canOpenAmap lat:(CGFloat)lat lon:(CGFloat)lon {
    if (canOpenAmap) {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"amapuri://openFeature?featureName=OnRideNavi&rideType=elebike&sourceApplication=com.dvlproad.CJUIKitDemo&lat=%f&lon=%f&dev=0",lat,lon]]];
    }else{
        [self goToDownloadAMap];
    }
}

+ (void)goToDownloadAMap
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/cn/app/%E9%AB%98%E5%BE%B7%E5%9C%B0%E5%9B%BE-%E7%B2%BE%E5%87%86%E5%9C%B0%E5%9B%BE-%E5%AF%BC%E8%88%AA%E5%87%BA%E8%A1%8C%E5%BF%85%E5%A4%87/id461703208?mt=8"]];
}

/// 打开苹果地图
+ (void)openAppleMapWithLat:(CGFloat)lat lon:(CGFloat)lon {
    MKMapItem *currentLoc = [MKMapItem mapItemForCurrentLocation];
    MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:CLLocationCoordinate2DMake(lat, lon) addressDictionary:nil]];
    NSArray *items = @[currentLoc,toLocation];
    NSDictionary *dic = @{
                          MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving,
                          MKLaunchOptionsMapTypeKey : @(MKMapTypeStandard),
                          MKLaunchOptionsShowsTrafficKey : @(YES)
                          };
    [MKMapItem openMapsWithItems:items launchOptions:dic];
}

@end
