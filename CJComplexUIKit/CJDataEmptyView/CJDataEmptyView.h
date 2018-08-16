//
//  CJDataEmptyView.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2016/2/6.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface CJDataEmptyView : UIView {
    
}
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSString *buttonTitle;

@property (nonatomic, copy) void(^reloadBlock)(void);

@end
