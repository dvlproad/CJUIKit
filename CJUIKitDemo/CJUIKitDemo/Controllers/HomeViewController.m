//
//  HomeViewController.m
//  CJUIKitDemo
//
//  Created by 李超前 on 2017/2/25.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "HomeViewController.h"

#import "ImageViewController.h"
#import "TextFieldViewController.h"
#import "TextViewController.h"
#import "KeyboardAvoidingViewController.h"
#import "SliderViewController.h"


#import "ImageChangeColorViewController.h"

typedef NS_ENUM(NSUInteger, TabelIndexType) {
    TabelIndexTypeCJImageView,
    TabelIndexTypeCJTextField,
    TabelIndexTypeCJTextView,
    TabelIndexTypeCJScrollView,
    TabelIndexTypeCJSlider,
    
    TabelIndexTypeUIImage,
};

@interface HomeViewController ()

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = NSLocalizedString(@"Home首页", nil);
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 30;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
    
    switch (indexPath.row) {
        case TabelIndexTypeCJImageView:
        {
            cell.textLabel.text = @"CJImageView";
            break;
        }
        case TabelIndexTypeCJTextField:
        {
            cell.textLabel.text = @"CJTextField";
            break;
        }
        case TabelIndexTypeCJTextView:
        {
            cell.textLabel.text = @"CJTextView";
            break;
        }
        case TabelIndexTypeCJScrollView:
        {
            cell.textLabel.text = @"CJScrollView";
            break;
        }
        case TabelIndexTypeCJSlider:
        {
            cell.textLabel.text = @"CJSlider";
            break;
        }
        case TabelIndexTypeUIImage:
        {
            cell.textLabel.text = @"UIImage";
            break;
        }
        default:
        {
            break;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    
    switch (indexPath.row) {
        case TabelIndexTypeCJImageView:
        {
            ImageViewController *viewController = [[ImageViewController alloc] initWithNibName:@"ImageViewController" bundle:nil];
            viewController.title = NSLocalizedString(@"CJImageView", nil);
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case TabelIndexTypeCJTextField:
        {
            TextFieldViewController *viewController = [[TextFieldViewController alloc] initWithNibName:@"TextFieldViewController" bundle:nil];
            viewController.title = NSLocalizedString(@"CJTextField", nil);
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case TabelIndexTypeCJTextView:
        {
            TextViewController *viewController = [[TextViewController alloc] initWithNibName:@"TextViewController" bundle:nil];
            viewController.title = NSLocalizedString(@"CJTextView", nil);
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case TabelIndexTypeCJScrollView:
        {
            KeyboardAvoidingViewController *viewController = [[KeyboardAvoidingViewController alloc] initWithNibName:@"KeyboardAvoidingViewController" bundle:nil];
            viewController.title = NSLocalizedString(@"KeyboardAvoiding", nil);
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case TabelIndexTypeCJSlider:
        {
            SliderViewController *viewController = [[SliderViewController alloc] initWithNibName:@"SliderViewController" bundle:nil];
            viewController.title = NSLocalizedString(@"CJSliderControl", nil);
            [self.navigationController pushViewController:viewController animated:YES];
            break;
        }
        case TabelIndexTypeUIImage:
        {
            ImageChangeColorViewController *viewController = [[ImageChangeColorViewController alloc] initWithNibName:@"ImageChangeColorViewController" bundle:nil];
            viewController.title = NSLocalizedString(@"UIImage", nil);
            [self.navigationController pushViewController:viewController animated:YES];
            break;
            break;
        }
        default:
        {
            break;
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
