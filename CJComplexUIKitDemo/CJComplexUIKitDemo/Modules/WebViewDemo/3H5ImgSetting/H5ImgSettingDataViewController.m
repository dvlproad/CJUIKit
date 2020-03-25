//
//  H5ImgSettingDataViewController.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/1/16.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "H5ImgSettingDataViewController.h"
#import "TSToast.h"

@implementation H5ImgSettingDataViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = NSLocalizedString(@"H5的图片设置之②传数据给H5", nil);
}

- (void)updateH5Img:(NSData *)compressImageData {
    // 方法②:OC执行JS--设置图片(通过上传图片数据)
    NSLog(@"1111");
    [self updateH5ImgWithImageData:compressImageData];
    NSLog(@"2222");
}


- (void)updateH5ImgWithImageData:(NSData *)compressImageData {
    NSString *imageName = @"h5Img.png";
    
    NSString *imageBase64String = [compressImageData base64EncodedStringWithOptions:NSDataBase64Encoding76CharacterLineLength];
    NSString *imgSrc = [NSString stringWithFormat:@"data:image/png;base64,%@", imageBase64String]; //可将imgSrc整个字符串复制黏贴到浏览器Safari的地址栏中并转到，就能看到这张图片了。这个方法可以用来验证imgSrc是否正确
    imgSrc = [self noWhiteSpaceString:imgSrc];
    NSString *jsString = [NSString stringWithFormat:@"js_updateH5ImgSrc('%@', '%@')", imgSrc, imageName];
    [self.webView evaluateJavaScript:jsString completionHandler:^(id _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"error = %@", error);
            [TSToast showMessage:@"Error:更新H5显示的图片的JS调用失败"];
            return;
        }
        NSLog(@"OC执行JS完成--设置图片(通过上传图片数据)");
    }];
}


- (NSString *)noWhiteSpaceString:(NSString *)newString {
    //去除掉首尾的空白字符和换行字符
    newString = [newString stringByReplacingOccurrencesOfString:@"\r" withString:@""];
    newString = [newString stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    newString = [newString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];  //去除掉首尾的空白字符和换行字符使用
    newString = [newString stringByReplacingOccurrencesOfString:@" " withString:@""];
    return newString;
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
