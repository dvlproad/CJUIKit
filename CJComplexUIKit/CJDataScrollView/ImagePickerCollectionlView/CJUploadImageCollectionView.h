//
//  CJUploadImageCollectionView.h
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/1/19.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CJMedia/CJImageUploadFileModelsOwner.h>
#import <CJMedia/CJVideoUploadFileModelsOwner.h>

#import "CQExtralItemCollectionViewDataSource.h"

typedef NS_ENUM(NSUInteger, CJMediaType) {
    CJMediaTypeImage,
    CJMediaTypeVideo
};

///上传操作
typedef NS_ENUM(NSUInteger, CJUploadActionType) {
    CJUploadActionTypeNone = 0,         /**< 没有上传文件的操作 */
    CJUploadActionTypeDirectly,         /**< 选择完之后直接上传(cell显示的时候就开始直接上传) */
    CJUploadActionTypeWaitForClick,     /**< 等待点击"上传"按钮再统一上传(不直接上传,则我们一般会有一个统一“上传”的按钮，来让这些上传) */
};

///TODO:将本工程CJTotalDemo中的FileChooseView抽出不含上传请求的部分到CJComplexUIKitDemo中
@interface CJUploadImageCollectionView : UICollectionView <UIImagePickerControllerDelegate, UINavigationControllerDelegate> {
    
}
@property (nonatomic, strong) CQExtralItemCollectionViewDataSource *equalCellSizeCollectionViewDataSource;

//@property (nonatomic, strong) NSMutableArray<NSString *> *dataModels;/**< 数据源 */
//@property (nonatomic, assign) DataCellActionType dataCellActionType;/**< 当前状态dataCell点击执行的操作是 */
@property (nonatomic, strong) NSIndexPath *alwaysAloneIndexPath;/**< 与其他不共存的indexPath */

//UICollectionUpdateAction



@property (nonatomic, strong) NSMutableArray *dataModels;
//创建上传文件到服务器的方法的代码块要实现的效果为：给item设置上传请求，并将上传请求的各个时刻信息momentInfo①保存到该item上，②同时利用这些momentInfo设置uploadProgressView。所以如下
//@property (nonatomic, assign) NSInteger maxDataModelShowCount;

@property (nonatomic, assign) CJUploadActionType uploadActionType;  /**< 上传操作 TODO: */
@property (nonatomic, copy) NSURLSessionDataTask * (^createDetailedUploadRequestBlock)(NSArray<CJUploadFileModel *> *uploadFileModels, CJUploadFileModelsOwner *itemThatSaveUploadInfo, void(^uploadInfoChangeBlock)(CJUploadFileModelsOwner *item));    /**< 用来执行生成上传请求的代码块：其是一个用"要上传的数据uploadFileModels"、"上传时刻信息的保存位置itemThatSaveUploadInfo"、"上传时刻信息变化的触发方法uploadInfoChangeBlock"这些参数来创建得到上传请求的代码块，结果返回创建的请求任务DataTask */


@property (nonatomic, assign) CJMediaType mediaType;
//@property (nonatomic, strong) UIViewController *belongToViewController;

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
