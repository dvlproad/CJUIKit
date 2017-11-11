//
//  UploadDirectlyImagePickerViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/3/31.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJUploadImageCollectionView.h"

//TODO：选择图片后，情况②是否立即上传，还是等候上传？
@interface UploadDirectlyImagePickerViewController : UIViewController {
    
}
@property (nonatomic, strong) IBOutlet CJUploadImageCollectionView *uploadImageCollectionView;


@end
