//
//  H5ImgSettingDataViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "H5ImgSettingDataViewController.h"

@implementation H5ImgSettingDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"H5的图片设置之②传数据给H5", nil);
}

- (void)updateH5Img:(NSData *)compressImageData {
    // 方法②:OC执行JS--设置图片(通过上传图片数据)
    [self updateH5ImgWithImageData:compressImageData];
}


- (void)updateH5ImgWithImageData:(NSData *)compressImageData {
    NSString *imageName = @"h5Img.png";
    
    NSString *imgSrc = @"data:image/png;base64,%E3%80%80iVBORw0KGgoAAAANSUhEUgAAAAEAAAAkCAYAAABIdFAMAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAHhJREFUeNo8zjsOxCAMBFB/%E3%80%80KEAUFFR0Cbng3nQPw68ArZdAlOZppPFIBhH5EAB8b+Tlt9MYQ6i1BuqFaq1CKSVcxZ2Acs6406KUgpt5/%E3%80%80LCKuVgz5BDCSb13ZO99ZOdcZGvt4mJjzMVKqcha68iIePB86GAiOv8CDADlIUQBs7MD3wAAAABJRU5ErkJggg%3D%3D"; //将这些字符复制黏贴到Safari的地址栏中并转到，就能看到它了，一张1X36的白灰png图片。
    
    //UIImage *compressImage = [UIImage imageWithData:compressImageData];
    //NSString *imageBase64String = [compressImage cj_imageTobase64];
//    NSString *imageBase64String = [compressImageData base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
//    NSString *imgSrc = [NSString stringWithFormat:@"data:image/png;base64,%@", imageBase64String]; //可将imageSrc整串放入浏览器地址来验证imageSrc是否正确
    
    //imgSrc = [[NSBundle mainBundle] pathForResource:@"add_red_Big" ofType:@"png"];
    
    NSString *jsString = [NSString stringWithFormat:@"js_updateH5ImgSrc('%@', '%@')", imgSrc, imageName];
    [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        NSLog(@"OC执行JS完成--设置图片(通过上传图片数据)");
    }];
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
