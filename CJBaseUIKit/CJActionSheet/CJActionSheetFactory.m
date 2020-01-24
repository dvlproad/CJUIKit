//
//  CJActionSheetFactory.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "CJActionSheetFactory.h"
#import "CJJumpMapUtil.h"

@implementation CJActionSheetFactory

/**
 *  图片选择
 *
 *  @param takePhotoHandle 选择"拍摄"的回调
 *  @param pickImageHandle 选择"从手机相册选择"的回调
 */
+ (CJActionSheetView *)pickImageSheetWithTakePhotoHandle:(void(^)(void))takePhotoHandle
                                         pickImageHandle:(void(^)(void))pickImageHandle
{
    NSMutableArray *sheetModels = [[NSMutableArray alloc] init];
    {
        CJActionSheetModel *takPhotoSheetModel = [[CJActionSheetModel alloc] init];
        takPhotoSheetModel.title = NSLocalizedString(@"拍摄", nil);
        [sheetModels addObject:takPhotoSheetModel];
    }
    {
        CJActionSheetModel *pickImageSheetModel = [[CJActionSheetModel alloc] init];
        pickImageSheetModel.title = NSLocalizedString(@"从手机相册选择", nil);
        [sheetModels addObject:pickImageSheetModel];
    }
    
    CJActionSheetView *actionSheet = [[CJActionSheetView alloc] initWithSheetModels:sheetModels clickHandle:^(CJActionSheetModel *sheetModel, NSInteger selectIndex) {
        if (selectIndex == 0) {
            !takePhotoHandle ?: takePhotoHandle();
            
        } else if (selectIndex == 1) {
            !pickImageHandle ?: pickImageHandle();
        }
    }];
    
    return actionSheet;
}


/**
 *  地图选择
 *
 *  @param updateDefaultNavigationMap   是否在选择结束后更新默认的导航地图软件
 *  @param baiduMapBlock                选择"百度地图"
 *  @param amapBlock                    选择"高德地图"
 *  @param appleMapBlock                选择"苹果地图"
 */
+ (CJActionSheetView *)mapsActionSheetWithUpdateMap:(BOOL)updateDefaultNavigationMap
                                      baiduMapBlock:(void (^ __nullable)(BOOL canOpenBaiduMap))baiduMapBlock
                                          amapBlock:(void (^ __nullable)(BOOL canOpenAmap))amapBlock
                                      appleMapBlock:(void (^ __nullable)(void))appleMapBlock
{
    
    NSMutableArray *sheetModels = [[NSMutableArray alloc] init];
    // 百度地图 BaiduMap
    BOOL canOpenBaiduMap = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"baidumap://"]];
    CJActionSheetModel *baiduMapSheetModel = [[CJActionSheetModel alloc] init];
    baiduMapSheetModel.title = NSLocalizedString(@"百度地图", nil);
    baiduMapSheetModel.subTitle = canOpenBaiduMap ? @"" : NSLocalizedString(@"未安装", nil);
    [sheetModels addObject:baiduMapSheetModel];
    
    // 高德地图 Amap
    BOOL canOpenAmap = [[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"amapuri://"]];
    CJActionSheetModel *amapSheetModel = [[CJActionSheetModel alloc] init];
    amapSheetModel.title = NSLocalizedString(@"高德地图", nil);
    amapSheetModel.subTitle = canOpenAmap ? @"" : NSLocalizedString(@"未安装", nil);
    [sheetModels addObject:amapSheetModel];
    
    // 苹果地图 appleMap
    CJActionSheetModel *appleMapSheetModel = [[CJActionSheetModel alloc] init];
    appleMapSheetModel.title = NSLocalizedString(@"苹果地图", nil);
    appleMapSheetModel.subTitle = @"";
    [sheetModels addObject:appleMapSheetModel];
    
    CJActionSheetView *actionSheet = [[CJActionSheetView alloc] initWithSheetModels:sheetModels clickHandle:^(CJActionSheetModel * sheetModel, NSInteger selectIndex) {
        if (selectIndex == 0) {
            if (updateDefaultNavigationMap) {
                [CJJumpMapUtil updateDefaultMapType:CJDemoMapTypeBMKMap];
            }
            !baiduMapBlock ?: baiduMapBlock(canOpenBaiduMap);
            
        }else if (selectIndex == 1) {
            if (updateDefaultNavigationMap) {
                [CJJumpMapUtil updateDefaultMapType:CJDemoMapTypeAMap];
            }
            !amapBlock ?: amapBlock(canOpenAmap);
            
        }else{
            if (updateDefaultNavigationMap) {
                [CJJumpMapUtil updateDefaultMapType:CJDemoMapTypeAppleMap];
            }
            !appleMapBlock ?: appleMapBlock();
        }
    }];
    
    return actionSheet;
}



@end
