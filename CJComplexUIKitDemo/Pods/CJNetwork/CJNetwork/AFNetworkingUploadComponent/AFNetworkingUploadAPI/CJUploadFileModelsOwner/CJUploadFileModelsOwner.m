//
//  CJUploadFileModelsOwner.m
//  FileChooseViewDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import "CJUploadFileModelsOwner.h"

@implementation CJUploadFileModelsOwner

- (instancetype)initWithUploadFileModels:(NSArray<CJUploadFileModel *> *)uploadFileModels {
    self = [super init];
    if (self) {
        _uploadFileModels = [NSMutableArray arrayWithArray:uploadFileModels];
    }
    return self;
}

@end
