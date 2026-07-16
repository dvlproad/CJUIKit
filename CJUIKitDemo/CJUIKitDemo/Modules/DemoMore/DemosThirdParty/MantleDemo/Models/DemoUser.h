//
//  DemoUser.h
//  CJDemoServiceDemo
//
//  Created by ciyouzen on 6/25/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CJFile/CJPathFileModel.h>
#import "DemoUsePermissionModel.h"


#import <Mantle/Mantle.h>


extern NSString *const DemoGeneralPassword;


typedef NS_ENUM(NSUInteger, SexType) {
    SexTypeMan,
    SexTypeWoman,
};


typedef NS_ENUM(NSUInteger, DemoHPPermissionType) {
    DemoHPPermissionType_Found                    = 87,//发现
    DemoHPPermissionType_Index_CourseManager      = 88,//课程管理
    DemoHPPermissionType_Students_HomeworkManager = 89,//作业管理
    DemoHPPermissionType_Notice_School            = 93,//学校通知
    DemoHPPermissionType_Notice_leave             = 94,//请假通知
    DemoHPPermissionType_Students_ScrollImage     = 99,//学生管理轮播图
    DemoHPPermissionType_AttendanceStat_AllStudent         = 603,//校学生考勤统计
    DemoHPPermissionType_AttendanceStat_Class              = 604,//班级考勤统计
    DemoHPPermissionType_AttendanceStat_StudentInOutSchool = 605,//学生出入校记录
    DemoHPPermissionType_AttendanceStat_Teacher            = 602,//教师考勤
    DemoHPPermissionType_ClassAddPhotoAlbum                = 4006,//新建相册
    DemoHPPermissionType_ClassUploadPhoto                  = 4007,//上传照片
};


@interface DemoUser : MTLModel <NSCopying, MTLJSONSerializing>
//@interface DemoUser : NSObject <NSCopying>

@property (nonatomic, copy) NSString *imName;
@property (nonatomic, copy) NSString *imPassword;

@property (nonatomic, copy) NSString *uid;
@property (nonatomic, copy) NSString *userToken;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *imageName;

@property (nonatomic, strong) CJPathFileModel *imagePathFileModel;
@property (nonatomic, copy) NSString *localRelativePath;/**< 本地相对路径(因为沙盒路径会变) */
@property (nonatomic, copy) NSString *networkAbsoluteUrl;/**< 网络绝对路径(有时服务器给的会是省略前缀后的) */

@property (nonatomic, assign) SexType sexType;
@property (nonatomic, assign) NSDate *birthday;

@property (nonatomic, copy) NSString *modified;
@property (nonatomic, copy) NSString *execTypeL;
@property (nonatomic, copy) NSString *execTypeN;

@property (nonatomic, strong) NSArray<DemoUsePermissionModel *> *auths;

#pragma mark - Other
+ (NSDateFormatter *)birthdayDateFormatter;


- (instancetype)initWithUserDictionary:(NSDictionary *)userDictionary;

#pragma mark - 头像
/**
 *  获取头像
 *
 *  @param completeBlock 获取到头像后，执行的回调
 */
- (void)getPortraitImageWithCompleteBlock:(void(^)(UIImage *portraitImage))completeBlock;

/**
 *  选择完头像后，更新头像的本地相对路径(此操作会对头像进行保存)
 *
 *  @param choosePortraitImage 图片选择器选择的头像
 */
- (void)updatePortraitImageLocalRelativePathByChooseImage:(UIImage *)choosePortraitImage;

#pragma mark - 权限
/**
 *  是否拥有指定权限
 *
 *  @param permissionID 指定的权限
 *
 *  @return 是否拥有
 */
- (BOOL)hasPermissionWithPermissionID:(DemoHPPermissionType)permissionID;

@end
