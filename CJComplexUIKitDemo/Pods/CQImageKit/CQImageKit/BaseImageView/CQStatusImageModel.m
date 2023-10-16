//
//  CQStatusImageModel.m
//  TSImageDemo
//
//  Created by ciyouzen on 2018/9/27.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQStatusImageModel.h"

@implementation CQStatusImageModel

#pragma mark - JsonToModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    return [self modelCustomPropertyMapper];
}
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{
        @"imageId":         @"id_p",
        @"imageUrl":        @"URL", // 图片的网络地址
        //@"imageStatus":           // 图片违规状态imageStatus 在 modelCustomTransformFromDictionary 中的 violation
    };//前边的是你自己想要命名的key，后边的是接口返回的key
}

- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    BOOL violation = [dic[@"violation"] boolValue];
    CQImageStatus imageStatus = violation == YES ? CQImageStatusBanned : CQImageStatusActive;
    [self updateImageStatus:imageStatus];

    return YES;
}

#pragma mark - Init
- (instancetype)initWithImageUrl:(NSString *)imageUrl imageStatus:(CQImageStatus)imageStatus {
    self = [super init];
    if (self) {
        _imageUrl = imageUrl;
        _imageStatus = imageStatus;
    }
    return self;
}

#pragma mark - Update
/*
 *  更新图片状态（使用于：有些图片在上传到阿里云oss后，得到的地址并不一定能立马知道是否违规，而是只有在使用该地址，进行其他业务的时候，才发现该图片是违规状态）
 *
 *  @param imageStatus  图片的违规状态
 */
- (void)updateImageStatus:(CQImageStatus)imageStatus {
    _imageStatus = imageStatus;
}

#pragma mark - Simulation模拟数据
/// 测试图片被banned
- (void)testBanned {
    _imageUrl = @"https://xxxx.jpg";
    _imageStatus = CQImageStatusBanned;
}

@end
