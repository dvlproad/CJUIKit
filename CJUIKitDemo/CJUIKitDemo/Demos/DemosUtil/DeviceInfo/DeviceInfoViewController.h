//
//  DeviceInfoViewController.h
//  CJBaseUtilDemo
//
//  Created by ciyouzen on 2017/7/5.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeviceInfoViewController : UIViewController {
    
}
@property (nonatomic, weak) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *array;

//@property (nonatomic, weak) IBOutlet UILabel *deviceNameLabel;
//
//@property (nonatomic, weak) IBOutlet UILabel *batteryQuantityLabel;
//@property (nonatomic, weak) IBOutlet UILabel *batteryStautsLabel;
//
//@property (nonatomic, weak) IBOutlet UILabel *totalMemorySizeLabel;
//@property (nonatomic, weak) IBOutlet UILabel *availableMemorySizeLabel;
//@property (nonatomic, weak) IBOutlet UILabel *usedMemoryLabel;
//@property (nonatomic, weak) IBOutlet UILabel *totalDiskSizeLabel;
//@property (nonatomic, weak) IBOutlet UILabel *availableDiskSizeLabel;
//
//@property (nonatomic, weak) IBOutlet UILabel *IPAddressLabel;
//@property (nonatomic, weak) IBOutlet UILabel *WifiNameLabel;

@end
