//
//  CQTSAssetModelGetter.m
//  CQDemoResource
//
//  Created by ciyouzen on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSAssetModelGetter.h"

#import "CQTSAssetSourceUtil.h"

@implementation CQTSAssetModelGetter


#pragma mark - 本地资源文件
/// 获取测试用的本地数据
/// （为本地图片名时候，UIImage *image = [UIImage cqresource_imageNamed:imageName]; ）
///
/// @param count                                                        文件个数
/// @param randomOrder                                          顺序是否随机
/// @param folderNames                                          要获取哪些文件夹下的文件
/// @param changeImageNameToNetworkUrl      是否将本地图片名转为其所在的网络地址
///
/// @return 返回图片数据
+ (nullable NSMutableArray<CQTSLocImageDataModel *> *)localFileModelsWithCount:(NSInteger)count
                                                          randomOrder:(BOOL)randomOrder
                                                       folderNames:(NSArray<NSString *> *)folderNames
//                                          changeImageNameToNetworkUrl:(BOOL)changeImageNameToNetworkUrl
{
    NSArray<NSString *> *titles = @[@"X透社", @"新鲜事", @"XX信", @"X角信", @"蓝精灵", @"年轻范", @"XX福", @"X之语", @"我是6个字哈"];
    NSArray<NSString *> *assetNameOrUrls;
//    if (changeImageNameToNetworkUrl) {
//        assetNameOrUrls = [CQTSAssetSourceUtil networkFileUrls:folderNames];
//    } else {
        assetNameOrUrls = [CQTSAssetSourceUtil localFileNames:folderNames];
//    }
    
    NSMutableArray<CQTSLocImageDataModel *> *dataModels = [self fileModelsWithTitles:titles assetNameOrUrls:assetNameOrUrls count:count randomOrder:randomOrder];
    return dataModels;
}

/// 获取测试用的数据
/// （为本地图片名时候，UIImage *image = [UIImage cqresource_imageNamed:imageName]; ）
///
/// @param titles                                                      标题数组
/// @param assetNameOrUrls                                  资源文件数组
/// @param requestCount                                        文件个数
/// @param randomOrder                                          顺序是否随机
///
/// @return 返回图片数据
+ (nullable NSMutableArray<CQTSLocImageDataModel *> *)fileModelsWithTitles:(NSArray<NSString *> *)titles
                                                  assetNameOrUrls:(NSArray<NSString *> *)assetNameOrUrls
                                                            count:(NSInteger)requestCount
                                                      randomOrder:(BOOL)randomOrder
{
    if (assetNameOrUrls.count == 0) {
        return nil;
    }
    
    NSMutableArray<CQTSLocImageDataModel *> *dataModels = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < requestCount; i++) {
        CQTSLocImageDataModel *dataModel = [[CQTSLocImageDataModel alloc] init];
        NSInteger maySelIndex = randomOrder ? random() : i;
        NSInteger lastImageSelIndex = maySelIndex%assetNameOrUrls.count;
        NSInteger lastTitleSelIndex = maySelIndex%titles.count;
        
        NSString *imageNameOrUrl = [assetNameOrUrls objectAtIndex:lastImageSelIndex];
        //NSString *title = [NSString stringWithFormat:@"%zd:第index=%zd张", i, lastImageSelIndex];
        NSString *title = [titles objectAtIndex:lastTitleSelIndex];
        
        dataModel.name = [NSString stringWithFormat:@"%02zd %@", i+1, title];
        dataModel.imageName = imageNameOrUrl;
        
//        UIImage *image = [UIImage cqresource_imageNamed:imageNameOrUrl];
//        if (image == nil) {
//            image = [[UIImage alloc] init];
//        }
        
        [dataModels addObject:dataModel];
    }
    
    return dataModels;
}



#pragma mark - 网络资源文件
/// 获取测试用的网络数据
///
/// @param count                                                        文件个数
/// @param randomOrder                                          顺序是否随机
/// @param folderNames                                          要获取哪些文件夹下的文件
///
/// @return 返回图片数据
+ (nullable NSMutableArray<CQTSNetImageDataModel *> *)networkFileModelsWithCount:(NSInteger)count
                                                            randomOrder:(BOOL)randomOrder
                                                         folderNames:(NSArray<NSString *> *)folderNames
{
    NSArray<NSString *> *titles = @[@"X透社", @"新鲜事", @"XX信", @"X角信", @"蓝精灵", @"年轻范", @"XX福", @"X之语", @"我是6个字哈"];
    NSArray<NSString *> *assetNameOrUrls = [CQTSAssetSourceUtil networkFileUrls:folderNames];
    
    NSMutableArray<CQTSNetImageDataModel *> *dataModels = [self fileModelsWithTitles:titles assetUrls:assetNameOrUrls count:count randomOrder:randomOrder];
    return dataModels;
}

/// 获取测试用的网络数据
///
/// @param titles                                                      标题数组
/// @param assetNameOrUrls                                  网络资源文件数组
/// @param requestCount                                        文件个数
/// @param randomOrder                                          顺序是否随机
///
/// @return 返回图片数据
+ (nullable NSMutableArray<CQTSNetImageDataModel *> *)fileModelsWithTitles:(NSArray<NSString *> *)titles
                                                        assetUrls:(NSArray<NSString *> *)assetNameOrUrls
                                                            count:(NSInteger)requestCount
                                                      randomOrder:(BOOL)randomOrder
{
    if (assetNameOrUrls.count == 0) {
        return nil;
    }
    
    NSMutableArray<CQTSNetImageDataModel *> *dataModels = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < requestCount; i++) {
        CQTSNetImageDataModel *dataModel = [[CQTSNetImageDataModel alloc] init];
        NSInteger maySelIndex = randomOrder ? random() : i;
        NSInteger lastImageSelIndex = maySelIndex%assetNameOrUrls.count;
        NSInteger lastTitleSelIndex = maySelIndex%titles.count;
        
        NSString *imageNameOrUrl = [assetNameOrUrls objectAtIndex:lastImageSelIndex];
        //NSString *title = [NSString stringWithFormat:@"%zd:第index=%zd张", i, lastImageSelIndex];
        NSString *title = [titles objectAtIndex:lastTitleSelIndex];
        
        dataModel.name = [NSString stringWithFormat:@"%02zd %@", i+1, title];
        dataModel.imageUrl = imageNameOrUrl;
        dataModel.badgeCount = i;
        
        [dataModels addObject:dataModel];
    }
    
    return dataModels;
}


#pragma mark - Icon资源文件
/// 获取测试用的Icon数据
///
/// @param count                                                        文件个数
/// @param randomOrder                                          顺序是否随机
///
/// @return 返回Icon数据
+ (nullable NSMutableArray<CQTSIconDataModel *> *)iconFileModelsWithCount:(NSInteger)count
                                                     randomOrder:(BOOL)randomOrder
{
    NSArray<NSString *> *titles = @[@"X透社", @"新鲜事", @"XX信", @"X角信", @"蓝精灵", @"年轻范", @"XX福", @"X之语", @"我是6个字哈"];
    NSArray<NSString *> *assetNameOrUrls = [CQTSAssetSourceUtil iconUrls];
    
    NSMutableArray<CQTSIconDataModel *> *dataModels = [self fileModelsWithTitles:titles iconUrls:assetNameOrUrls count:count randomOrder:randomOrder];
    return dataModels;
}



/// 获取测试用的网络数据
///
/// @param titles                                                      标题数组
/// @param assetNameOrUrls                                  Icon资源文件数组
/// @param requestCount                                        文件个数
/// @param randomOrder                                          顺序是否随机
///
/// @return 返回图片数据
+ (nullable NSMutableArray<CQTSIconDataModel *> *)fileModelsWithTitles:(NSArray<NSString *> *)titles
                                                     iconUrls:(NSArray<NSString *> *)assetNameOrUrls
                                                        count:(NSInteger)requestCount
                                                  randomOrder:(BOOL)randomOrder
{
    if (assetNameOrUrls.count == 0) {
        return nil;
    }
    
    NSMutableArray<CQTSIconDataModel *> *dataModels = [[NSMutableArray alloc] init];
    for (NSInteger i = 0; i < requestCount; i++) {
        CQTSIconDataModel *dataModel = [[CQTSIconDataModel alloc] init];
        NSInteger maySelIndex = randomOrder ? random() : i;
        NSInteger lastImageSelIndex = maySelIndex%assetNameOrUrls.count;
        NSInteger lastTitleSelIndex = maySelIndex%titles.count;
        
        NSString *imageNameOrUrl = [assetNameOrUrls objectAtIndex:lastImageSelIndex];
        //NSString *title = [NSString stringWithFormat:@"%zd:第index=%zd张", i, lastImageSelIndex];
        NSString *title = [titles objectAtIndex:lastTitleSelIndex];
        
        dataModel.name = [NSString stringWithFormat:@"%02zd %@", i+1, title];
        dataModel.imageUrl = imageNameOrUrl;
        dataModel.badgeCount = i * 5;
        if (i == 4) {
            dataModel.badgeCount = 9;
        } else if (i == 6) {
            dataModel.badgeCount = 66;
        } else if (i == 7) {
            dataModel.badgeCount = 777;
        } else if (i == 8) {
            dataModel.badgeCount = 8888;
        }
        
        [dataModels addObject:dataModel];
    }
    
    return dataModels;
}



@end
