//
//  CJIndependentPickerView.m
//  CJPickerDemo
//
//  Created by ciyouzen on 6/20/15.
//  Copyright (c) 2015 dvlproad. All rights reserved.
//

#import "CJIndependentPickerView.h"

@implementation CJIndependentPickerView

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    [self commonInit];
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self commonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
    }
    return self;
}

- (void)commonInit {
    self.backgroundColor = [UIColor whiteColor];
    [self setFrame:CGRectMake(0, 0, 0, 260)];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectZero];
    //pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.dataSource = self;
    pickerView.delegate = self;
    [self addSubview:pickerView];
    pickerView.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:pickerView
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:pickerView
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:pickerView
                                  attribute:NSLayoutAttributeHeight //height
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:216]];  //UIDatePicker默认216的高
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:pickerView
                                  attribute:NSLayoutAttributeBottom //bottom
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeBottom
                                 multiplier:1
                                   constant:0]];
    
    self.pickerView = pickerView;
}

- (void)addToolbar:(UIToolbar *)toolbar {
    _toolbar = toolbar;
    
    [self addSubview:toolbar];
    toolbar.translatesAutoresizingMaskIntoConstraints = NO;
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:toolbar
                                  attribute:NSLayoutAttributeLeft   //left
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeLeft
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:toolbar
                                  attribute:NSLayoutAttributeRight  //right
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeRight
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:toolbar
                                  attribute:NSLayoutAttributeTop    //top
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:self
                                  attribute:NSLayoutAttributeTop
                                 multiplier:1
                                   constant:0]];
    
    [self addConstraint:
     [NSLayoutConstraint constraintWithItem:toolbar
                                  attribute:NSLayoutAttributeHeight //height
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:nil
                                  attribute:NSLayoutAttributeNotAnAttribute
                                 multiplier:1
                                   constant:44]];
}


/** datePicker值改变触发 */
- (void)valueChangedAction:(UIPickerView *)pickerView {
    if (self.valueChangedHandel) {
        self.valueChangedHandel(pickerView);
    }
}


#pragma mark - UIPickerViewDataSource && UIPickerViewDelegate
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return [self.datas count];
}

- (NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return [[self.datas objectAtIndex:component] count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return [[self.datas objectAtIndex:component] objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    NSArray *datasC = [self.datas objectAtIndex:component];
    NSString *string = [datasC objectAtIndex:row];
    [self.selecteds replaceObjectAtIndex:component withObject:string];
    
    if (self.valueChangedHandel) {
        self.valueChangedHandel(pickerView);
    }
}


#pragma mark - 设置初始默认值
- (void)setSelecteds_default:(NSArray *)selecteds_default{
    if (selecteds_default.count != self.datas.count) {
        NSLog(@"ERROR: 默认值个数不正确 应该是%zd个，而不是%zd个", self.datas.count, selecteds_default.count);
        return;
    }
    
    self.selecteds = [[NSMutableArray alloc] initWithArray:selecteds_default];
    
    for (int indexC = 0; indexC < self.datas.count; indexC++) {
        NSArray *datasC = [self.datas objectAtIndex:indexC];
        NSString *selected_default = [selecteds_default objectAtIndex:indexC];
        if ([datasC containsObject:selected_default] == NO) {
            NSLog(@"ERROR: %@ noContain", [NSString stringWithFormat:@"%s:%d", __func__, __LINE__]);
            continue;
        }
        NSInteger indexR = [datasC indexOfObject:selected_default];
        [self.pickerView selectRow:indexR inComponent:indexC animated:NO];
    }
    
}

@end
