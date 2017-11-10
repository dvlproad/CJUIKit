# CJPopupView
包含CJPicker和CJPopupView
CJPopupView中包含类似美团的弹出下拉控件CJRelatedPickerRichView

## 目录
包含

1. CJPicker

	又包含
	①、CJIndependentPickerView
	
	②、CJRelatedPickerView
	
2. CJPopoverView 带箭头的弹出视图
3. CJDragView 可悬浮拖动的视图
4. CJMaskGuideHUD 镂空的引导视图
5. CJMaskGuideView 镂空的引导视图2

# CJPicker
包含：CJPickerView（**CJIndependentPickerView** 和 **CJRelatedPickerView**） 和 CJDatePicker
This is a view which contain UIPickerView/UIDatePicker and UIToolbar as subViews.

替换掉了原来的CJDataListView.podspec和CJPickerToolBarView.podspec

## Screenshots
![Example](./Screenshots/CJPicker/CJDatePickerToolBarView.png "生日选择")
![Example](./Screenshots/CJPicker/CJIndependentPickerView.png "体重选择")
![Example](./Screenshots/CJPicker/CJRelatedPickerView.png "地区选择")


## How to use
- ①、生日选择
```
- (IBAction)chooseBirthday:(id)sender{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    if (picker_birthday == nil) {
        picker_birthday = [[CJDatePickerToolBarView alloc]initWithNibName:@"CJDatePickerToolBarView" delegate:self];
        picker_birthday.datePicker.datePickerMode = UIDatePickerModeDate;
        picker_birthday.datePicker.maximumDate = [NSDate date];
        picker_birthday.datePicker.minimumDate = [dateFormatter dateFromString:@"1900-01-01"];;
    }

    picker_birthday.datePicker.date = [dateFormatter dateFromString:@"1989-12-27"];

    [picker_birthday showInView:self.view];
}

- (void)confirmDelegate_datePicker:(CJDatePickerToolBarView *)pickerToolBarView{
    NSDate *selDate = pickerToolBarView.datePicker.date;
    NSString *value = [NSString stringWithFormat:@"%@", selDate];
    [[[UIAlertView alloc]initWithTitle:@"所选日期为" message:value delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];

    [pickerToolBarView dismiss];
}


- (void)valueChangeDelegate_datePicker:(CJDatePickerToolBarView *)pickerToolBarView{
    UIDatePicker *m_datePicker = pickerToolBarView.datePicker;

    NSDate *date = m_datePicker.date;
    NSDate *maximumDate = m_datePicker.maximumDate;
    NSDate *minimumDate = m_datePicker.minimumDate;

    NSTimeZone *zone =[NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate: date];
    NSDate *localDate =[date dateByAddingTimeInterval: interval];

    NSLog(@"1当前选择:%@",localDate);

    if ([date compare:minimumDate] == NSOrderedAscending) {
        NSLog(@"当前选择日期太小");
    }else if ([date compare:maximumDate] == NSOrderedDescending) {
        NSLog(@"当前选择日期太大");
    }
}
```

- ②、体重选择
```
- (IBAction)chooseWeight:(id)sender{
    if (picker_weight == nil) {
        picker_weight = [[CJPickerWeightToolBarView alloc]initWithNibName:@"CJPickerWeightToolBarView" delegate:self];
        NSMutableArray *integers = [[NSMutableArray alloc]init];
        for (int i = 40; i < 100; i++) {
            [integers addObject:[NSString stringWithFormat:@"%d", i]];
        }

        NSMutableArray *decimals = [[NSMutableArray alloc]init];
        for (int i = 0; i < 10; i++) {
            [decimals addObject:[NSString stringWithFormat:@"%d", i]];
        }

        NSArray *units = @[@"kg", @"磅"];

        picker_weight.datas = @[integers, decimals, units];
        picker_weight.tag = 1000;
    }

    picker_weight.selecteds_default = @[@"60", @"5", @"kg"];

    [picker_weight showInView:self.view];
}

- (void)confirmDelegate_pickerView:(CJPickerWeightToolBarView *)pickerToolBarView{
    if (pickerToolBarView.tag == 1000) {
        NSString *integer = @"", *decimal = @"", *unit = @"";

        for (int indexC = 0; indexC < pickerToolBarView.datas.count; indexC++) {
            NSString *string = [pickerToolBarView.selecteds objectAtIndex:indexC];
            if (indexC == 0) {
                integer = string;
            }else if (indexC == 1){
                decimal = string;
            }else if (indexC == 2){
                unit = string;
            }
        }
        NSString *value = [NSString stringWithFormat:@"%@.%@.%@", integer, decimal, unit];
        [[[UIAlertView alloc]initWithTitle:@"最后的值为" message:value delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];

        [pickerToolBarView dismiss];
    }
}
```

- ③、地区选择
```
- (IBAction)chooseArea:(id)sender{
    if (picker_area == nil) {
        picker_area = [[CJPickerAreaToolBarView alloc]initWithNibName:@"CJPickerAreaToolBarView" delegate:self];

        NSArray *datasC_0 = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"area.plist" ofType:nil]];
        picker_area.dicArray = @[@{@"head": @"state", @"value": @"cities"},
                                 @{@"head": @"city",  @"value": @"areas"}];
        picker_area.datas = [CJPickerAreaToolBarView getDatasByDatasC_0:datasC_0 dicArray:picker_area.dicArray];
    }

    picker_area.selecteds_default = @[@"福建", @"泉州", @"安溪县"];

    [picker_area showInView:self.view];
}

- (void)confirmDelegate_pickerArea:(CJPickerAreaToolBarView *)pickerToolBarView{
    NSString *integer = @"", *decimal = @"", *unit = @"";

    for (int indexC = 0; indexC < pickerToolBarView.datas.count; indexC++) {
        NSString *string = [pickerToolBarView.selecteds objectAtIndex:indexC];
        if (indexC == 0) {
            integer = string;
        }else if (indexC == 1){
            decimal = string;
        }else if (indexC == 2){
            unit = string;
        }
    }
    NSString *value = [NSString stringWithFormat:@"%@.%@.%@", integer, decimal, unit];
    [[[UIAlertView alloc]initWithTitle:@"最后的值为" message:value delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil] show];

    [pickerToolBarView dismiss];
}
```

- dealloc
```
- (void)dealloc{
    [picker_birthday dismiss];
    picker_birthday.delegate = nil;
    picker_birthday = nil;

    [picker_weight dismiss];
    picker_weight.delegate = nil;
    picker_weight = nil;

    [picker_area dismiss];
    picker_area.delegate = nil;
    picker_area = nil;
}
```

 


## CJMaskGuideView
新手引导/遮罩层

## 目录
1、 CJPopoverView
a pop view 一个带箭号的弹出视图

2、CJPDropDownView
弹出视图(包含类似美团的弹出下拉控件CJPDropDownView)


## Screenshots
![Example](./Screenshots/CJPDropDownView1.gif "美团下拉")
![Example](./Screenshots/CJPDropDownView2.gif "美团下拉")
![Example](./Screenshots/CJPDropDownView1.png "美团下拉")
![Example](./Screenshots/CJPDropDownView2.png "美团下拉")

## How to use
- ①、CJPDropDownView的完整控件使用
```
初始化如下：
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    DropDownRadioButtons *ddview = [[DropDownRadioButtons alloc]initWithFrame:CGRectMake(0, 164, self.view.frame.size.width, 40)];
    ddview.datas = @[
                     @[@"区域", @"鼓楼", @"台江", @"仓山"],
                     @[@"面积", @"75平米以下", @"75-100平米", @"100-150平米", @"150平米以上"],
                     @[@"总价", @"80万以下", @"80-120万", @"120-200万", @"200万以上"]
                    ];
    ddview.delegate = self;
    [self.view addSubview:ddview];
}


点击时候会调用如下委托：
- (void)ddRadioButtons:(DropDownRadioButtons *)ddRadioButtons didSelectText:(NSString *)text{
    NSLog(@"text3 = %@", text);
}

```


- ②、RadioButtons的使用
```
初始化如下：
    CGRect rect_radioButtons222 = CGRectMake(0, 264, self.view.frame.size.width, 40);
    commonRadioButtons222 = [[RadioButtons alloc]initWithFrame:rect_radioButtons222];
    [commonRadioButtons222 setTitles:@[@"人物", @"爱好", @"其他", @"地区"] radioButtonNidName:@"RadioButton_DropDown"];
    commonRadioButtons222.delegate = self;
    commonRadioButtons222.tag = 222;
    [self.view addSubview:commonRadioButtons222];

点击时候会调用如下委托：
- (void)radioButtons:(RadioButtons *)radioButtons chooseIndex:(NSInteger)index{

}
```

- ③、TableViewArraySingle的使用
```
初始化如下：
    NSArray *chooseArray = @[@"区域", @"鼓楼", @"台江", @"仓山"];

    TableViewArraySingle *customView = [[TableViewArraySingle alloc]initWithFrame:CGRectZero];
    [customView setFrame:CGRectMake(self.view.frame.size.width*2/4, 0, self.view.frame.size.width/4, 200)];
    customView.datas = chooseArray;
    [customView setDelegate:self];
    customView.tag = radioButtons.tag;

从radioButtons中弹出的方法如下：
    [radioButtons showDropDownExtendView:customView inView:self.view complete:nil];

选择TableViewArraySingle中的内容时候会调用下面的委托：
- (void)tv_ArraySingle:(TableViewArraySingle *)tv_ArraySingle didSelectText:(NSString *)text{
    NSLog(@"text2 = %@", text);

    //通过tag，反取到弹出该视图的RadioButtons
    NSInteger tag = tv_ArraySingle.tag;
    RadioButtons *comRadioButtons = nil;
    if (tag == commonRadioButtons111.tag) {
        comRadioButtons = commonRadioButtons111;
    }else if (tag == commonRadioButtons222.tag){
        comRadioButtons = commonRadioButtons222;
    }
    [comRadioButtons didSelectInExtendView:text];
}

```

- ①、TableViewsArrayDictionary的使用
```
初始化如下：
    NSArray *C_0_data = @[
                         @{kChooseArrayTitle:@"娱乐", kChooseArrayValue: @[@"爱旅行", @"爱唱歌", @"爱电影"]},
                         @{kChooseArrayTitle:@"学习", kChooseArrayValue: @[@"爱读书", @"爱看报", @"爱书法", @"爱其他"]},
                         @{kChooseArrayTitle:@"0", kChooseArrayValue: @[@"0-0", @"0-1", @"0-2", @"0-3"]},
                         @{kChooseArrayTitle:@"1", kChooseArrayValue: @[@"1-1", @"1-2", @"1-3"]}
                        ];
    NSArray *dic_chooseArray = @[
                                 @{kAD_Title: kChooseArrayTitle, kAD_Value: kChooseArrayValue}
                                ];

    ArrayDictonaryModel *adModel = [[ArrayDictonaryModel alloc]initWithC_0_data:C_0_data dicArray:dic_chooseArray];
    [adModel updateSelecteds_index:@[@"0", @"0"]];

    TableViewsArrayDictionary *customView = [[TableViewsArrayDictionary alloc]initWithFrame:CGRectZero];
    [customView setFrame:CGRectMake(0, 0, self.view.frame.size.width, 200)];
    customView.adModel = adModel;
    [customView setDelegate:self];
    customView.tag = radioButtons.tag;
从radioButtons中弹出的方法如下：
    [radioButtons showDropDownExtendView:customView inView:self.view complete:nil];


选择TableViewsArrayDictionary中的内容时候会调用下面的委托：
- (void)tv_ArrayDictionary:(TableViewsArrayDictionary *)tv_ArrayDictionary didSelectText:(NSString *)text{
    NSLog(@"text1 = %@, %@", text, tv_ArrayDictionary.adModel.selecteds_titles);

    //通过tag，反取到弹出该视图的RadioButtons
    NSInteger tag = tv_ArrayDictionary.tag;
    RadioButtons *comRadioButtons = nil;
    if (tag == commonRadioButtons111.tag) {
        comRadioButtons = commonRadioButtons111;
    }else if (tag == commonRadioButtons222.tag){
        comRadioButtons = commonRadioButtons222;
    }
    [comRadioButtons didSelectInExtendView:text];

}
```


### CJPopoverView
a pop view 一个带箭号的弹出视图


## CJDragView
可悬浮拖动的视图

#### 用法

1、把需要拖曳view的父类从原本继承UIView，改成继承CJDragView就OK了。

2、通过dragEnable可设置是否允许拖曳动作；isKeepBounds是不是又自动黏贴边界效果(YES时自动黏贴边界，而且是最近的边界。NO时不会黏贴在边界，它是自由状态，跟随手指到任意位置，但是也不可以拖出规定的范围)；freeRect可以任意设置活动范围，默认为活动范围为父视图大小frame，

3、拖动过程的回调block

* 	开始拖动的回调	dragBeginBlock
* 	拖动中回调		dragDuringBlock
* 	结束拖动的回调 	dragEndBlock

#### Screenshots
<!--![Example](./Screenshots/Demo.gif "Demo")-->
![Example](./Screenshots/CJPopoverView/CJPopoverView01.png "Demo")


## 修改记录
CJPopupView 在2.0.0之前实际上是现在CJPopupAction.






