//
//  ChangeEnvironmentViewController.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 2018/10/12.
//  Copyright © 2018年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Masonry/Masonry.h>

@interface ChangeEnvironmentViewController : UIViewController {
    
}
@property (nonatomic, strong) void(^changeEnvironmentCompleteBlock)(NSIndexPath *indexPath);

@end
