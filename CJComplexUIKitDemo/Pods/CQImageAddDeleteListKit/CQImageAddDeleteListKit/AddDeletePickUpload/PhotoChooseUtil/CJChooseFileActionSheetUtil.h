//
//  CJChooseFileActionSheetUtil.h
//  CJComplexUIKitDemo
//
//  Created by lcQian on 2020/4/6.
//  Copyright © 2020 dvlproad. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CJChooseFileActionSheetUtil : NSObject

/*
*  弹出图片选择并进行选择
*
*  @param canMaxChooseImageCount    在允许批量添加的情况下，当前还允许添加的最大值。(默认填1)
*  @param pickCompleteBlock         选择完图片后执行的操作
*/
+ (void)defaultImageChooseWithCanMaxChooseImageCount:(NSInteger)canMaxChooseImageCount
                                   pickCompleteBlock:(void (^)(NSArray<UIImage *> *bImages))pickCompleteBlock;

@end

NS_ASSUME_NONNULL_END
