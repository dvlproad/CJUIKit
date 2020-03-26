//
//  LEADPosModel.m
//  CJComplexUIKitDemo
//
//  Created by ciyouzen on 2019/5/23.
//  Copyright © 2019 dvlproad. All rights reserved.
//

#import "LEADPosModel.h"

@implementation LEADPosModelList

+ (NSDictionary *)mj_objectClassInArray {
    return @{@"contentList" : @"LEADPosModel"};
}

@end

@implementation LEADPosModel

@synthesize title = _title;
- (NSString *)title {
    if (!_title) {
        _title = @"";
    }
    return _title;
}

@synthesize clickUrl = _clickUrl;
- (NSString *)clickUrl {
    if (!_clickUrl) {
        _clickUrl = @"";
    }
    return _clickUrl;
}

@end
