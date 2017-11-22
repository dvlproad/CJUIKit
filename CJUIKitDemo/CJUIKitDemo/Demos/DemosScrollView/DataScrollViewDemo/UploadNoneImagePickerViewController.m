//
//  UploadNoneImagePickerViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/3/31.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UploadNoneImagePickerViewController.h"

@interface UploadNoneImagePickerViewController ()

@end

@implementation UploadNoneImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"图片选择", nil);
    
    
    self.uploadImageCollectionView.belongToViewController = self;
    self.uploadImageCollectionView.mediaType = CJMediaTypeImage;
    self.uploadImageCollectionView.equalCellSizeSetting.maxDataModelShowCount = 5;
    
//    __weak typeof(self)weakSelf = self;
    [self.uploadImageCollectionView setPickImageCompleteBlock:^{
        //[weakSelf.uploadImageCollectionView reloadData];
    }];
}


///开始上传/继续上传没上传完的
- (IBAction)uploadUnFinishImageModel:(id)sender {
    NSLog(@"对collectionView，开始上传/继续上传没上传完的");
}


- (IBAction)reloadCollectionView:(id)sender {
    [self.uploadImageCollectionView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
