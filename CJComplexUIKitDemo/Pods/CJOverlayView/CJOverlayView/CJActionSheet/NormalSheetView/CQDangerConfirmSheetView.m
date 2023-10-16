//
//  CQDangerConfirmSheetView.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/7/3.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import "CQDangerConfirmSheetView.h"
#import <Masonry/Masonry.h>
#import "CJBaseOverlayThemeManager.h"
#import "CJOverlayTextSizeUtil.h"

@interface CQDangerConfirmSheetView () {
    
}

@end

@implementation CQDangerConfirmSheetView


#pragma mark - Init
/*
 *  初始化
 *
 *  @param promptTitle          视图顶部的提醒标题
 *  @param cancelEventText      取消操作事项的文字
 *  @param cancelBlock          取消操作事项的点击回调
 *  @param dangerEventText      危险操作事项的文字（危险操作下常见的标题有：删除）
 *  @param dangerEventBlock     危险操作事项的点击回调
 *
 *  @return  执行某个危险操作事件时候，需要弹出的确认提醒视图
 */
- (instancetype)initWithDangerPromptTitle:(NSString *)promptTitle
                          cancelEventText:(NSString *)cancelEventText
                         cancelEventBlock:(void(^)(void))cancelEventBlock
                          dangerEventText:(NSString *)dangerEventText
                         dangerEventBlock:(void(^)(void))dangerEventBlock
{
    self = [super initWithPromptTitle:promptTitle item1EventText:dangerEventText item1EventIsDanger:YES item1EventBlock:dangerEventBlock item2EventText:cancelEventText item2EventBlock:cancelEventBlock];
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
