//
//  CJImagePickerNavigatorController.m
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import "CJImagePickerNavigatorController.h"
#import "CJImagePickerViewController.h"

@interface CJImagePickerNavigatorController () {
    
}
@property (nonatomic, copy) void(^pickCancelBlock)(UINavigationController *bNavVC);
@property (nonatomic, copy) void(^changePhotoGroupBlock)(void);

@end






@implementation CJImagePickerNavigatorController

/*
 *  初始化
 *
 *  @param overLimitBlock           超过最大选择图片数量的限制回调
 *  @param clickImageBlock          点击图片执行的事件
 *  @param previewAction            点击底部左侧"预览"执行的事件
 *  @param pickFinishBlock          点击底部右侧"完成"执行的事件
 *  @param pickCancelBlock          点击顶部右侧"取消"执行的事件
 *  @param changePhotoGroupBlock    点击顶部左侧"相册"执行的事件
 *
 *  @return 照片选择器
 */
- (instancetype)initWithOverLimitBlock:(void(^)(void))overLimitBlock
                       clickImageBlock:(void(^)(CJAlumbImageModel *imageModel))clickImageBlock
                         previewAction:(void(^)(NSArray *bTotoalImageModels, NSMutableArray<CJAlumbImageModel *> *bSelectedImageModels))previewAction
                       pickFinishBlock:(void(^)(UINavigationController *bNavVC, NSArray<CJAlumbImageModel *> *bSelectedImageModels))pickFinishBlock
                       pickCancelBlock:(void(^)(UINavigationController *bNavVC))pickCancelBlock
                 changePhotoGroupBlock:(void(^)(void))changePhotoGroupBlock
{
    
    CJImagePickerViewController *viewController = [[CJImagePickerViewController alloc] initWithOverLimitBlock:overLimitBlock clickImageBlock:clickImageBlock previewAction:previewAction pickFinishBlock:^(UIViewController *bVC, NSArray<CJAlumbImageModel *> *bSelectedImageModels) {
        if (pickFinishBlock) {
            pickFinishBlock(self, bSelectedImageModels);
        }
    }];
    if (self = [super initWithRootViewController:viewController]) {
        self.changePhotoGroupBlock = changePhotoGroupBlock;
        self.pickCancelBlock = pickCancelBlock;
    }
    return self;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIBarButtonItem *leftItem =
    [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"相册", nil)
                                     style:UIBarButtonItemStylePlain
                                    target:self
                                    action:@selector(changePhotoGroup)];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    UIBarButtonItem *rightItem =
    [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"取消", nil)
                                    style:UIBarButtonItemStylePlain
                                   target:self
                                   action:@selector(dismissVC)];
    self.navigationItem.rightBarButtonItem = rightItem;
    
    
    UIColor *blueTextColor = [UIColor colorWithRed:104/255.0 green:194/255.0 blue:244/255.0 alpha:1]; //#68c2f4
    self.navigationBar.barTintColor = [UIColor redColor];
    [self.navigationBar setTitleTextAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:19],NSForegroundColorAttributeName:blueTextColor}];
    self.navigationBar.tintColor = blueTextColor;
}


#pragma mark - Event
///点击顶部左侧的"相册"：进入到相册控制器
- (void)changePhotoGroup {
    if (self.changePhotoGroupBlock) {
        self.changePhotoGroupBlock();
    }
}

///点击顶部右侧的-“取消”：返回前一个页面
- (void)dismissVC {
    if (self.pickCancelBlock) {
        self.pickCancelBlock(self);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
