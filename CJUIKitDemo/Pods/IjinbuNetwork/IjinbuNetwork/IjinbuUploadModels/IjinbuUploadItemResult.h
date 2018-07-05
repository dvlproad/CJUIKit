//
//  IjinbuUploadItemResult.h
//  CJNetworkDemo
//
//  Created by ciyouzen on 2017/1/20.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IjinbuUploadItemResult : NSObject

@property (nonatomic, copy) NSString *networkId;    //网络Id:f1f425e7b43645e29f0b2696a120b463,
@property (nonatomic, copy) NSString *networkUrl;   //网络路径：upload/homework/image/20160612/20160612144549-2506939.jpg
@property (nonatomic, copy) NSString *networkName;  //网络文件：C35E8D45-05EF-4C04-A44B-E924072F749E-1489-00000F547F68CCD1.jpg,

@property (nonatomic, copy) NSString *size;   // 573.11K,
@property (nonatomic, copy) NSString *ext;    // jpg,


//@property (nonatomic, assign, readonly) BOOL uploaded;

- (instancetype)initWithHisDictionary:(NSDictionary *)dictionary;

+ (NSString *)jsonArrayWithObjectArray:(NSArray<IjinbuUploadItemResult *> *)jsonArray;

@end
