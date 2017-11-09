//
//  CJMultiColumnPhotoTableViewCell.h
//  CJPickerDemo
//
//  Created by ciyouzen on 2015/8/31.
//  Copyright © 2015年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CJPhotoGridCell.h"

@interface CJMultiColumnPhotoTableViewCell : UITableViewCell

@property (nonatomic, copy) void (^gridCellImageButtonTapBlock)(CJPhotoGridCell *photoGridCell); /**< 图片的点击操作 */
@property (nonatomic, copy) void (^gridCellCheckButtonTapBlock)(CJPhotoGridCell *photoGridCell); /**< 选择框的点击操作 */

@end
