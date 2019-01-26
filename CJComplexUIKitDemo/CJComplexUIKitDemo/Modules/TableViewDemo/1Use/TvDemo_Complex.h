//
//  TvDemo_Complex.h
//  CJUIKitDemo
//
//  Created by ciyouzen on 8/26/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TvDemo_Complex : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    NSArray *sectionArray;
    NSMutableArray *datas;
    
    BOOL isEditing;
}
@property(nonatomic, strong) IBOutlet UITableView *tv;

@end
