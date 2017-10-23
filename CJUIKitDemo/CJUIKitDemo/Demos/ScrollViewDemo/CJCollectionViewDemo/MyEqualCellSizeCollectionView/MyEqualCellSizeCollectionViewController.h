//
//  MyEqualCellSizeCollectionViewController.h
//  AllScrollViewDemo
//
//  Created by ciyouzen on 8/10/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyEqualCellSizeCollectionView.h"
#import "MyEqualCellSizeCollectionView+Select.h"

@interface MyEqualCellSizeCollectionViewController : UIViewController {
    
}
@property (nonatomic, strong) NSMutableArray *dataModels;
@property (nonatomic, weak) IBOutlet MyEqualCellSizeCollectionView *equalCellSizeCollectionView;

@end
