//
//  AccuracyStringViewController.m
//  CJUIKitDemo
//
//  Created by ciyouzen on 2017/12/29.
//  Copyright © 2017年 dvlproad. All rights reserved.
//

#import "AccuracyStringViewController.h"

#import "ValidateStringTableViewCell.h"
#import "NSString+CJAccuracy.h"

typedef NS_ENUM(NSUInteger, ValidateStringType) {
    ValidateStringTypeNone = 0,     /**< 不验证 */
    ValidateStringTypeEmail,        /**< 邮箱 */
    ValidateStringTypePhone,        /**< 手机号码 */
    ValidateStringTypeCarNo,        /**< 车牌号 */
    ValidateStringTypeCarType,      /**< 车型 */
    ValidateStringTypeUserName,     /**< 用户名 */
    ValidateStringTypePassword,     /**< 密码 */
    ValidateStringTypeNickname,     /**< 昵称 */
    ValidateStringTypeIdentityCard, /**< 身份证号 */
};

@interface AccuracyStringViewController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation AccuracyStringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"cell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"ValidateStringTableViewCell" bundle:nil] forCellReuseIdentifier:@"ValidateStringTableViewCell"];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    self.dataModels = @[@"0.090222120000",
                        @"0.0900",
                        @"10.00",
                        ];
    
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSInteger count = self.dataModels.count;
    return count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger count = self.dataModels.count;
    if (indexPath.row < count) {
        ValidateStringTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ValidateStringTableViewCell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textField.placeholder = @"请输入要验证的字符串";
        cell.textField.text = [self.dataModels objectAtIndex:indexPath.row];
        cell.button.tag = 1000 + indexPath.row;
        [cell.button addTarget:self action:@selector(validateStringEvent:) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
        
    } else {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.text = [NSString stringWithFormat:@"%zd", indexPath.row];
        
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSLog(@"didSelectRowAtIndexPath = %ld %ld", indexPath.section, indexPath.row);
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Event
- (void)validateStringEvent:(UIButton *)button {
    NSInteger index = button.tag - 1000;
    NSString *originNumberString = [self.dataModels objectAtIndex:index];
    NSString *lastNumberString = [originNumberString removeEndZero];
    
    NSLog(@"lastNumberString = %@", lastNumberString);
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
