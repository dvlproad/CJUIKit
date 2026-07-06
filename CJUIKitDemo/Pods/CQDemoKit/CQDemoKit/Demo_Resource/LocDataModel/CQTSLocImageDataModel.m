//
//  CQTSLocImageDataModel.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CQTSLocImageDataModel.h"

@implementation CQTSLocImageDataModel

#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _name = [coder decodeObjectForKey:@"name"];
        _imageName = [coder decodeObjectForKey:@"imageName"];
        _selected = [coder decodeBoolForKey:@"selected"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:_name forKey:@"name"];
    [coder encodeObject:_imageName forKey:@"imageName"];
    [coder encodeBool:_selected forKey:@"selected"];
}

@end
