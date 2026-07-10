//
//  CQTSNetImageDataModel.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/11/12.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CQTSNetImageDataModel.h"

@implementation CQTSNetImageDataModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _imageUrl = @"https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=3407848463,1025443640&fm=26&gp=0.jpg";
    }
    return self;
}


#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _haveLoadImage = [coder decodeBoolForKey:@"haveLoadImage"];
        _name = [coder decodeObjectForKey:@"name"];
        _imageUrl = [coder decodeObjectForKey:@"imageUrl"];
        _badgeCount = [coder decodeIntegerForKey:@"badgeCount"];
        _selected = [coder decodeBoolForKey:@"selected"];
        
        // 解码 UIImage
        NSData *imageData = [coder decodeObjectForKey:@"imagePlaceholderImage"];
        if (imageData) {
            _imagePlaceholderImage = [UIImage imageWithData:imageData];
        }
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeBool:_haveLoadImage forKey:@"haveLoadImage"];
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_imageUrl forKey:@"imageUrl"];
    [coder encodeInteger:_badgeCount forKey:@"badgeCount"];
    [coder encodeBool:_selected forKey:@"selected"];

    // 编码 UIImage
    if (_imagePlaceholderImage) {
        NSData *imageData = UIImagePNGRepresentation(_imagePlaceholderImage);
        [coder encodeObject:imageData forKey:@"imagePlaceholderImage"];
    }
}


@end
