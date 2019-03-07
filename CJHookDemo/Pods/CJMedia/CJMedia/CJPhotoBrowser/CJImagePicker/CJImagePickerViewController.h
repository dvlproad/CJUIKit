//
//  CJImagePickerViewController.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <Masonry/Masonry.h>

#import <AssetsLibrary/AssetsLibrary.h>

#import "AlumbImageModel.h"

#import "AlumbSectionDataModel.h"


/**
 *  自定义的“图片选择器CJImagePickerViewController”
 */
@interface CJImagePickerViewController : UIViewController {
    
}
@property (nonatomic, assign) NSInteger canMaxChooseImageCount;     /**< 可一次性选取的最大数目 */
@property (nonatomic, copy) void (^pickCompleteBlock)(NSArray<AlumbImageModel *> *imageModels);    /**< 照片选取完毕后 */



@property (nonatomic, strong) ALAssetsGroup *assetsGroup;
@property (nonatomic, strong) NSMutableArray *assets;

@property (nonatomic, strong) NSMutableArray<AlumbSectionDataModel *> *sectionDataModels;


- (void)hcRefreshViewDidDataUpdated;



@end
