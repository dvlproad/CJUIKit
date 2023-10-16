//
//  CQTwoEventSheetView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQTwoEventSheetView.h"
#import <Masonry/Masonry.h>
#import "CJBaseOverlayThemeManager.h"
#import "CJOverlayTextSizeUtil.h"

@interface CQTwoEventSheetView () {
    
}

@end

@implementation CQTwoEventSheetView


#pragma mark - Init
/*
 *  初始化
 *
 *  @param promptTitle          视图顶部的提醒标题
 *  @param item1EventText       操作事项1的文字
 *  @param item1EventBlock      操作事项1的点击回调
 *  @param item2EventText       操作事项2的文字
 *  @param item2EventBlock      操作事项2的点击回调
 *
 *  @return  有两个操作事项的视图
 */
- (instancetype)initWithPromptTitle:(NSString *)promptTitle
                     item1EventText:(NSString *)item1EventText
                    item1EventBlock:(void(^)(void))item1EventBlock
                     item2EventText:(NSString *)item2EventText
                    item2EventBlock:(void(^)(void))item2EventBlock
{
    self = [super initWithPromptTitle:promptTitle item1EventText:item1EventText item1EventIsDanger:NO item1EventBlock:item1EventBlock item2EventText:item2EventText item2EventBlock:item2EventBlock];
    if (self) {
        
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
