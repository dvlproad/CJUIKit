//
//  CJFilesLookDataModel.m
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import "CJFilesLookDataModel.h"

@implementation CJFilesLookDataModel

- (void)setImageWithUrl:(NSString *)imageUrl {
    UIImage *image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:imageUrl]]];
    self.image = image;
}

@end
