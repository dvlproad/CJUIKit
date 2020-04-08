//
//  CJFilesLookDataModel.h
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/7.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJFilesLookDataModel : NSObject

@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;

- (void)setImageWithUrl:(NSString *)imageUrl;

@end

NS_ASSUME_NONNULL_END
