//
//  CJUploadCollectionViewCell.h
//  AllScrollViewDemo
//
//  Created by ciyouzen on 2016/06/07.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

//#import "CJBaseCollectionViewCell.h"
#import "CJFullBottomCollectionViewCell.h"
#import <CJNetwork/CJUploadProgressView.h>

@interface CJUploadCollectionViewCell : CJFullBottomCollectionViewCell {
    
}
@property (nonatomic, strong) CJUploadProgressView *uploadProgressView;

@end
