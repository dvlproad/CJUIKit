//
//  CQDMSectionDataModel.m
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2016/11/23.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CQDMSectionDataModel.h"

@implementation CQDMSectionDataModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _values = [[NSMutableArray alloc] init];
    }
    return self;
}

#pragma mark - NSCopying, NSMutableCopying
//知识点(深拷贝deepCopy)
- (id)copyWithZone:(NSZone *)zone {
    CQDMSectionDataModel *deepCopySectionDataModel = [[self class] allocWithZone:zone];
    deepCopySectionDataModel.type = _type;
    deepCopySectionDataModel.theme = [_theme copy];
    
    //deepCopySectionDataModel.values = [_values mutableCopy]; //没有达到深复制到最里层
    NSMutableArray *values2 = [[NSMutableArray alloc] init];
    for (id dataModel in _values) {
        [values2 addObject:[dataModel copy]];
    }
    deepCopySectionDataModel.values = values2;
    
    return deepCopySectionDataModel;
}

- (id)mutableCopyWithZone:(NSZone *)zone {
    CQDMSectionDataModel *deepCopySectionDataModel = [[self class] allocWithZone:zone];
    deepCopySectionDataModel.type = _type;
    deepCopySectionDataModel.theme = [_theme copy];
    
    //deepCopySectionDataModel.values = [_values mutableCopy]; //没有达到深复制到最里层
    NSMutableArray *values2 = [[NSMutableArray alloc] init];
    for (id dataModel in _values) {
        [values2 addObject:[dataModel copy]];
    }
    deepCopySectionDataModel.values = values2;
    
    return deepCopySectionDataModel;
}


#pragma mark - NSCoding
- (instancetype)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        _type = [coder decodeIntegerForKey:@"type"];
        _theme = [coder decodeObjectForKey:@"theme"];
        _values = [coder decodeObjectForKey:@"values"];
    }
    return self;
}

- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeInteger:_type forKey:@"type"];
    [coder encodeObject:_theme forKey:@"theme"];
    [coder encodeObject:_values forKey:@"values"];
}


@end
