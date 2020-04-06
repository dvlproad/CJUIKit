//
//  UploadDirectlyImagePickerViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2017/3/31.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "UploadDirectlyImagePickerViewController.h"

#import "IjinbuNetworkClient+Login.h"
#import "IjinbuNetworkClient+UploadFile.h"

#import <SVProgressHUD/SVProgressHUD.h>

@interface UploadDirectlyImagePickerViewController ()

@end

@implementation UploadDirectlyImagePickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = NSLocalizedString(@"图片选择", nil);
    
    //执行上传之前，确保登录了
    [[IjinbuNetworkClient sharedInstance] requestijinbuLogin_name:@"15800000007" pasd:@"123456" completeBlock:^(IjinbuResponseModel *responseModel) {
        if (responseModel.status == 1) {
            NSLog(@"登录成功");
        } else {
            NSLog(@"登录失败");
            [SVProgressHUD showErrorWithStatus:@"登录失败"];
        }
    }];
    
    
    self.uploadImageCollectionView.backgroundColor = [UIColor redColor];
    self.uploadImageCollectionView.belongToViewController = self;
    self.uploadImageCollectionView.mediaType = CJMediaTypeImage;
//    self.uploadImageCollectionView.equalCellSizeSetting.maxDataModelShowCount = 5; //TODO:
    
    __weak typeof(self)weakSelf = self;
    [self.uploadImageCollectionView setPickImageCompleteBlock:^{
        [weakSelf.uploadImageCollectionView reloadData];
    }];
    
    
    /* 设置上传 */
    NSInteger uploadItemToWhere = 0; /** 可选：上传到哪里(一个项目中可能有好几个地方都要上传) */
    self.uploadImageCollectionView.uploadActionType = CJUploadActionTypeDirectly;
    self.uploadImageCollectionView.createDetailedUploadRequestBlock = ^NSURLSessionDataTask *(NSArray<CJUploadFileModel *> *uploadFileModels, CJUploadFileModelsOwner *itemThatSaveUploadInfo, void (^uploadInfoChangeBlock)(CJUploadFileModelsOwner *item)) {
        NSURLSessionDataTask *dataTask =
        [IjinbuNetworkClient detailedRequestUploadItems:uploadFileModels
                                                toWhere:uploadItemToWhere
                                andsaveUploadInfoToItem:itemThatSaveUploadInfo
                                  uploadInfoChangeBlock:uploadInfoChangeBlock];
        
        return dataTask;
    };
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
