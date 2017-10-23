////
////  CJFileChooseToolBar.h
////  FileChooseViewDemo
////
////  Created by ciyouzen on 2016/4/10.
////  Copyright © 2016年 dvlproad. All rights reserved.
////
//
//#import <UIKit/UIKit.h>
////#import "MJImagePicker.h"
//#import "HPToolBarImageInputView.h"
//#import "HPToolBarSoundInputView.h"
//#import "HPToolBarAttachInputView.h"
////#import "HPRequest+UploadFile.h"
//
//extern NSString * const HPResourceHaveNotUploadSuccess;
//
//typedef NS_OPTIONS(NSUInteger, HPToolBarOptions) {
//    HPToolBarOptionsImage                   = 1 << 0,//图片
//    HPToolBarOptionsMic                     = 1 << 1,//语音
//    HPToolBarOptionsAttachment              = 1 << 2,//附件
//};
//
//typedef NS_ENUM(NSUInteger, HPToolBarInputViewType) {//标记当前的inputView类型
//    HPToolBarInputViewTypeNone = 0,
//    HPToolBarInputViewTypePhoto,
//    HPToolBarInputViewTypeMic,
//    HPToolBarInputViewTypeAttach,
//};
//
//
//
//@interface CJFileChooseToolBar : UIView
//
////@property (assign,nonatomic       ) HPUpLoadType uploadType;//default is HPUpLoadTypeNone
//@property (assign,nonatomic       ) HPToolBarOptions   options;
//@property (weak,nonatomic         ) UIViewController   * vc;
//@property (strong,nonatomic       ) UIColor            * toolBarColor;
//
///**
// *  图片获取设置
// */
//@property (weak,nonatomic,readonly) NSArray     * originImageSource;
//@property (weak,nonatomic,readonly) NSArray     * originImageItems;
//@property (assign,nonatomic       ) NSInteger          maxImageCount;//default is 5.
//@property (assign,nonatomic       ) BOOL               showImageAddItem;//default is yes;
//@property (copy,nonatomic         ) void(^pickPhotoBlock    )();
//
///**
// *  语音获取设置
// */
//@property (weak,nonatomic,readonly) NSArray     * originSoundSource;
//@property (strong,nonatomic) NSArray * originSoundItems;
//@property (assign,nonatomic       ) NSInteger          maxSoundCount;//default is 3.
//
///**
// *  附件获取设置
// */
//@property (weak,nonatomic,readonly) NSMutableArray     * originAttachItems;
//@property (assign,nonatomic       ) NSInteger          maxAttachCount;
//@property (assign,nonatomic       ) BOOL               showAttachAddItem;//default is no;
//
//- (instancetype)initWithFrame:(CGRect)frame optoins:(HPToolBarOptions)options viewController:(UIViewController*)viewController;
//
////获取所有资源并转换成json
//- (NSString *)getAllCurrentSourceJsonString;
//
//- (void)setupOriginImageSource:(NSArray *)originImageSource;
//- (void)setupOriginImageItems:(NSArray <HPToolBarImageInputViewItem *>*)originImageItems;
//
//- (void)setupOriginSoundSource:(NSArray *)originSoundSource;
//- (void)setupOriginSoundItems:(NSArray <HPToolbarSoundInputViewItem *>*)originSoundItems;
//
//-(void)setupOriginAttachItems:(NSMutableArray<HPToolBarAttachInputViewItem *>*)originAttachItems;
//- (NSArray<HPToolBarImageInputViewItem *>*)getCurrentImageItems;
//- (BOOL)hasImageEdite;//是否编辑过图片
//- (NSArray <HPToolbarSoundInputViewItem *>*)getCurrentSoundItems;
//- (BOOL)hasSoundEdite;//是否编辑过语音
//- (NSArray <HPToolBarAttachInputViewItem *>*)getCurrentAttachItems;
//- (BOOL)hasAttachEdite;
//@property (copy, nonatomic) void(^handleAddAttachActionBlock)(HPToolBarAttachInputView *toolBarAttachInputView);
//
//- (BOOL)allResourcesUploaded;
//- (BOOL)hasAnyOptoinEdite;
//
//@end
//
