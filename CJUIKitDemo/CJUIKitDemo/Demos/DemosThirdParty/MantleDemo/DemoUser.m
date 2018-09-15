//
//  DemoUser.m
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "DemoUser.h"

#import <CJFile/CJFileManager+GetCreatePath.h>
#import <CJFile/CJFileManager+SaveFileData.h>

NSString *const DemoGeneralPassword = @"123456";    //为测试而增加的通用密码

@interface DemoUser() {
    
}

@end


@implementation DemoUser

- (instancetype)init {
    self = [super init];
    if (self) {
        CJPathFileModel *imagePathFileModel = [[CJPathFileModel alloc] init];
        self.imagePathFileModel = imagePathFileModel;
    }
    return self;
}

+ (NSDictionary *)JSONKeyPathsByPropertyKey {
//    return @{
//             @"imName":     @"hxAccount",
//             @"imPassword": @"hxPassWord",
//             @"token":      @"token",
//             };
    return @{
             @"uid"    : @"uid",
             @"name"   : @"name",
             @"email"  : @"email",
             @"pasd"   : @"pasd",
             @"imageName": @"imageName",
             @"networkAbsoluteUrl": @"networkAbsoluteUrl",
             @"localRelativePath":  @"localRelativePath",
             
             @"sexType":    @"sexType",
             @"birthday":   @"birthday",
             
             @"modified" : @"modified",
             @"execTypeL": @"execTypeL",
             @"execTypeN": @"execTypeN"
             };
}

+ (NSValueTransformer *)JSONTransformerForKey:(NSString *)key {
    if ([key isEqualToString:@"birthday"])
    {
        //对于日期，服务器可能返回两种情况，分别为情况①：返回时间戳，情况②：返回时间字符串
        /*
        //情况①：返回时间戳
        //number 与date
        return [MTLValueTransformer transformerUsingForwardBlock:^id(NSNumber *number, BOOL *success, NSError *__autoreleasing *error) {
            NSTimeInterval secs = [number doubleValue];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:secs];
            return date;
        } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
            NSTimeInterval secs = [date timeIntervalSince1970];
            return @(secs);
        }];
        
        //string 与 date
        return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *string, BOOL *success, NSError *__autoreleasing *error) {
            NSTimeInterval secs = [string doubleValue];
            NSDate *date = [NSDate dateWithTimeIntervalSince1970:secs];
            return date;
        } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
            NSTimeInterval secs = [date timeIntervalSince1970];
            NSString *dateString = [NSString stringWithFormat:@"%f", secs];
            return dateString;
        }];
        
        //*/
        //情况②：返回时间字符串
        NSDateFormatter *birthdayDateFormatter = [DemoUser birthdayDateFormatter];
        return [MTLValueTransformer transformerUsingForwardBlock:^id(NSString *dateString, BOOL *success, NSError *__autoreleasing *error) {
            NSDate *date = [birthdayDateFormatter dateFromString:dateString];
            return date;
        } reverseBlock:^id(NSDate *date, BOOL *success, NSError *__autoreleasing *error) {
            NSString *dateString =  [birthdayDateFormatter stringFromDate:date];
            return dateString;
        }];
    }
//    else if ([key isEqualToString:@"list"])
//    {
//        return [MTLJSONAdapter arrayTransformerWithModelClass:[TempObj1 class]];
//    }
    /*
     跟方法二一样（不重复所以注释掉）
     else if ([key isEqualToString:@"model"])
     {
     return [MTLJSONAdapter dictionaryTransformerWithModelClass:[TempObj1 class]];
     }
     */
    return nil;

}

+ (NSValueTransformer *)sexTypeJSONTransformer {
    NSDictionary *dictionary = @{
                                 @"SexTypeMan":     @(SexTypeMan),
                                 @"SexTypeWoman":   @(SexTypeWoman)
                                 };
    return [NSValueTransformer mtl_valueMappingTransformerWithDictionary:dictionary];
}


- (instancetype)initWithUserDictionary:(NSDictionary *)userDictionary {
    self = [super init];
    if (self) {
        self.uid = userDictionary[@"uid"];
        self.name = userDictionary[@"name"];
        self.userToken = userDictionary[@"userToken"];
        self.email = userDictionary[@"email"];
        self.imageName = userDictionary[@"imageName"];
        self.networkAbsoluteUrl = userDictionary[@"networkAbsoluteUrl"];
        self.localRelativePath = userDictionary[@"localRelativePath"];
        self.auths = userDictionary[@"auths"];
        self.sexType = [userDictionary[@"sexType"] integerValue];
        
        NSString *birthday = userDictionary[@"birthday"];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.birthday = [dateFormatter dateFromString:birthday];
        
        self.imName = userDictionary[@"imName"];
        self.imPassword = userDictionary[@"imPassword"];
        
        self.modified = userDictionary[@"modified"];
        self.execTypeL = userDictionary[@"execTypeL"];
        self.execTypeN = userDictionary[@"execTypeN"];
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    DemoUser *user = [[[self class] allocWithZone:zone] init];
    user.uid = self.uid;
    user.name = self.name;
    user.userToken = self.userToken;
    user.email = self.email;
    user.imageName = self.imageName;
    user.networkAbsoluteUrl = self.networkAbsoluteUrl;
    user.localRelativePath = self.localRelativePath;
    user.auths = self.auths;
    user.sexType = self.sexType;
    user.birthday = self.birthday;
    
    user.imName = self.imName;
    user.imPassword = self.imPassword;
    
    user.modified = self.modified;
    user.execTypeL = self.execTypeL;
    user.execTypeN = self.execTypeN;
    
    return user;
}

#pragma mark - Other
+ (NSDateFormatter *)birthdayDateFormatter {
    NSDateFormatter *birthdayDateFormatter = [[NSDateFormatter alloc] init];
    //NSDateFormatter *birthdayDateFormatter = [CJDateFormatterUtil sharedInstance].dateFormatter;
    birthdayDateFormatter.dateFormat = @"yyyy-MM-dd";
    
    return birthdayDateFormatter;
}


#pragma mark - 头像
/* 完整的描述请参见文件头部 */
- (void)getPortraitImageWithCompleteBlock:(void(^)(UIImage *portraitImage))completeBlock {
    [self.imagePathFileModel getFileDataWithCompleteBlock:^(NSData *fileData) {
        UIImage *image = [UIImage imageWithData:fileData];
        if (image == nil) {
            image = [UIImage imageNamed:@"cjAvatar.png"];
        }
        if (completeBlock) {
            completeBlock(image);
        }
    }];
}


/* 完整的描述请参见文件头部 */
- (void)updatePortraitImageLocalRelativePathByChooseImage:(UIImage *)choosePortraitImage {
    NSString *relativeDirectory = [CJFileManager getLocalDirectoryPathType:CJLocalPathTypeRelative bySubDirectoryPath:@"DemoUserImage" inSearchPathDirectory:NSDocumentDirectory createIfNoExist:YES];
    
    //保存选择的头像到本地
    NSString *imageName = [NSString stringWithFormat:@"avantar_%@.jpg", self.uid];
    NSData *imageData = UIImageJPEGRepresentation(choosePortraitImage, 1.0f);
    [CJFileManager saveFileData:imageData withFileName:imageName toRelativeDirectoryPath:relativeDirectory];
    
    //更新头像的本地相对路径
    NSString *localRelativePath = [relativeDirectory stringByAppendingPathComponent:imageName];
    //self.localRelativePath = localRelativePath;
    [self.imagePathFileModel updateLocalRelativePath:localRelativePath localSourceType:CJFileSourceTypeLocalSandbox];
}

#pragma mark - 权限
- (BOOL)hasPermissionWithPermissionID:(DemoHPPermissionType)permissionID {
    for (DemoUsePermissionModel *e in self.auths) {
        if (e.permission == permissionID) {
            return YES;
        }
    }
    return NO;
}

@end
