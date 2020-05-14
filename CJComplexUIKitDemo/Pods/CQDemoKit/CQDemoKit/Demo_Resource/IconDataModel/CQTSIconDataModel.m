//
//  CQTSIconDataModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CQTSIconDataModel.h"

@implementation CQTSIconDataModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _imageUrl = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3407848463,1025443640&fm=26&gp=0.jpg";
    }
    return self;
}

+ (void)setupImageView:(UIImageView *)imageView withImageUrl:(NSString *)imageUrl {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];

        dispatch_async(dispatch_get_main_queue(), ^{
            imageView.image = image;
        });
    });
}


@end
