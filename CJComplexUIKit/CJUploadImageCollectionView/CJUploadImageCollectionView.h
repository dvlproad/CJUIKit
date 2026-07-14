//
//  CJUploadImageCollectionView.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/1/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//


#import <CQImageAddDeleteListKit/CJImageUploadFileModelsOwner.h>
#import <CQImageAddDeleteListKit/CJVideoUploadFileModelsOwner.h>
#import <CQImageAddDeleteListKit/CJImageAddDeletePickCollectionView.h>          // 引入 CJMediaType
#import <CQImageAddDeleteListKit/CJImageAddDeletePickUploadCollectionView.h>    // 引入 CJUploadActionType

///TODO:将本工程CJTotalDemo中的FileChooseView抽出不含上传请求的部分到CJComplexUIKitDemo中
@interface CJUploadImageCollectionView : UICollectionView <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
}
@property (nonatomic, assign, readonly) NSUInteger maxDataModelShowCount; /**< 集合视图最大显示的dataModel数目(默认NSIntegerMax即无限制) */
@property (nonatomic, strong) NSMutableArray *dataModels;
//创建上传文件到服务器的方法的代码块要实现的效果为：给item设置上传请求，并将上传请求的各个时刻信息momentInfo①保存到该item上，②同时利用这些momentInfo设置uploadProgressView。所以如下

@property (nonatomic, assign) CJUploadActionType uploadActionType;  /**< 上传操作 TODO: */
@property (nonatomic, copy) NSURLSessionDataTask * (^createDetailedUploadRequestBlock)(NSArray<CJUploadFileModel *> *uploadFileModels, CJUploadFileModelsOwner *itemThatSaveUploadInfo, void(^uploadInfoChangeBlock)(CJUploadFileModelsOwner *item));    /**< 用来执行生成上传请求的代码块：其是一个用"要上传的数据uploadFileModels"、"上传时刻信息的保存位置itemThatSaveUploadInfo"、"上传时刻信息变化的触发方法uploadInfoChangeBlock"这些参数来创建得到上传请求的代码块，结果返回创建的请求任务DataTask */


@property (nonatomic, assign) CJMediaType mediaType;
@property (nonatomic, strong) UIViewController *belongToViewController;

//image
@property (nonatomic, copy) void(^pickImageCompleteBlock)(void); /**< 选择完图片后的操作 */

//video
@property (nonatomic, copy) void(^pickVideoHandle)(void);   /**< 开始操作视频的操作 */


/**
 *  检查所有文件是否上传完成
 *
 *  return 是否上传完成
 */
- (BOOL)isAllUploadFinish;




@end
