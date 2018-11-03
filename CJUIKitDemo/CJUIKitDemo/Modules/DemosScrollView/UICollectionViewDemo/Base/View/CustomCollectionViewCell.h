//
//  CustomCollectionViewCell.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomCollectionViewCell : UICollectionViewCell

@property(nonatomic, strong) IBOutlet UILabel *labName;
@property(nonatomic, strong) IBOutlet UILabel *labPrice;
@property(nonatomic, strong) IBOutlet UIImageView *imageV;

@end
