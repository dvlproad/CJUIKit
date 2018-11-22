//
//  OpenCollectionViewController.h
//  CJCollectionViewDemo
//
//  Created by ciyouzen on 16/3/10.
//  Copyright © 2016年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CJOpenCollectionView.h"
#import "CJHeadAndCellHorizontalLayout.h"

@interface OpenCollectionViewController : UIViewController {
    
}

@property (nonatomic, strong) IBOutlet CJOpenCollectionView *collectionView;
@property (nonatomic, strong) NSMutableArray *datas;

@end
