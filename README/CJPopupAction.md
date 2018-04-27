# CJPopupAction
UIView的Category，用于弹出自定义的UIView
 (Using this class to popup your custom view)

#### Screenshots
![Example](./Screenshots/Demo.gif "Demo")
![Example](./Screenshots/Demo.png "Demo")

###How to use
```
1、将一个视图弹出到某个视图里

2、弹出某个视图的扩展视图，比如点击按钮弹出

```

######目前引用到此库的有
1、CJRadio项目中的CJRadioButtonDropDownSample的使用
2、CJPickerToolBarView的使用中



#####用到的知识
```
 当前view中的某个point在toView中对应的位置是多少的计算方法
 方法介绍：- (CGPoint)convertPoint:(CGPoint)point toView:(UIView *)view;
 //第一个参数必须为所要转化的rect的视图的父视图，这里可以将父视图直接写出，也可用该视图的superview来替代，这样更方便
```

