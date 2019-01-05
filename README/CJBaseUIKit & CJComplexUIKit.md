[TOC]

# CJBaseUIKit & CJComplexUIKit
UI控件



## 目录

- 一、CJBaseUIKit：自定义的基础UI控件
- 二、CJComplexUIKit：自定义的稍微复杂的UI
- 三、CJFoundation：系统Foundation的扩展------[见首页](./../README.md)
- 四、CJBaseHelper：自定义的基础帮助类------[见首页](./../README.md)
- 五、CJBaseUtil：自定义的基础工具类------[见首页](./../README.md)
- 六、CJBaseTest：自定义的基础测试类------[见首页](./../README.md)
- 其他
- 版本介绍/更新记录





## 一、CJBaseUIKit：自定义的UI控件

#### 0、内容涵盖

> - CJBaseUIKit/UIColor：颜色：用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
> - CJBaseUIKit/UIImage：图片
> - CJBaseUIKit/UINavigationBar：导航栏
>
> - CJBaseUIKit/UIView：视图
>   - CJBaseUIKit/UIView/CJDragAction：视图拖动
>   - CJBaseUIKit/UIView/CJShakeAction：视图抖动
>   - CJBaseUIKit/UIView/CJPopupAction：视图弹窗：UIView的类别，用来实现UIView弹出popupView的一个Uiew的类别
>   - CJBaseUIKit/UIView/CJGestureRecognizer：视图手势
>
> - CJBaseUIKit/UIWindow：窗口
> - CJBaseUIKit/UIButton：按钮 及 CJBadgeButton
> - CJBaseUIKit/UITextField：文本视图：包含文本框类别及新的自定义文本框
> - CJBaseUIKit/CJTextView：文本视图：类似微信文本输入框实现
> - CJBaseUIKit/UIToolbar：工具栏
> - CJBaseUIKit/CJScrollView：滚动视图：自定义的基础滚动视图
>
> - CJBaseUIKit/CJTableView：列表视图
>   - CJBaseUIKit/CJTableView/CJBaseTableViewCell：基础的TableViewCell
>   - CJBaseUIKit/CJTableView/CJBaseTableViewHeaderFooterView
>
> - CJBaseUIKit/CJCollectionView：集合视图
>   - CJBaseUIKit/CJCollectionView/CJBaseCollectionViewCell：基础的CollectionViewCell
>   - CJBaseUIKit/CJCollectionView/CJCollectionViewLayout
>   - CJBaseUIKit/CJCollectionView/MyEqualCellSizeCollectionView：一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)
>   - CJBaseUIKit/CJCollectionView/CJOpenCollectionView：可展开的集合视图
>
> - CJBaseUIKit/CJSlider：滑块
> - CJBaseUIKit/CJRefreshView：刷新
> - CJBaseUIKit/CJMJRefreshComponent：已包含pod 'MJRefresh'
> - CJBaseUIKit/CJToast：Toast
> - CJBaseUIKit/CJDataEmptyView：空视图(处理数据为空、网络加载失败等情况)
待完善


如果只想加载某个类，可以用形如`pod 'CJBaseUIKit/CJTextView', '~> 0.0.1'`来加载



#### 1、CJBaseUIKit/UIColor：颜色

UIColor+CJHex用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式

#### 2、CJBaseUIKit/UIImage：图片

###### (1)、UIImage+CJChangeColor：修改图片颜色
参考：[iOS中使用blend改变图片颜色](https://onevcat.com/2013/04/using-blending-in-ios/)

问题来源：在应用里一个很常见的需求是主题变换：同样的图标，同样的素材，但是需要按照用户喜爱变为不同的颜色。

#### 3、CJBaseUIKit/UINavigationBar：导航栏

#### 4、CJBaseUIKit/UIView：视图

###### (1)、CJBaseUIKit/UIView/CJDragAction：视图拖动
###### (2)、CJBaseUIKit/UIView/CJShakeAction：视图抖动
###### (3)、CJBaseUIKit/UIView/CJPopupAction：视图弹窗：UIView的类别，用来实现UIView弹出popupView的一个Uiew的类别
###### (4)、CJBaseUIKit/UIView/CJGestureRecognizer：视图手势

#### 5、CJBaseUIKit/UIWindow：窗口

#### 6、CJBaseUIKit/UIButton：按钮
CJBaseUIKit/UIButton：按钮 及 CJBadgeButton

#### 7、CJBaseUIKit/UITextField：文本视图：包含文本框类别及新的自定义文本框

#### 8、CJBaseUIKit/CJTextView：文本视图：类似微信文本输入框实现

类似微信文本输入框实现

功能：

1. 有占位符placeholderView
2. 可设置最大行数maxNumberOfLines，当超过最大行文本框不在自增长长度

#### 9、CJBaseUIKit/UIToolbar：工具栏

#### 10、CJBaseUIKit/CJScrollView：滚动视图：自定义的基础滚动视图

#### 11、CJBaseUIKit/CJTableView：列表视图

###### (1)、CJBaseUIKit/CJTableView/CJBaseTableViewCell：基础的TableViewCell
###### (2)、CJBaseUIKit/CJTableView/CJBaseTableViewHeaderFooterView

#### 12、CJBaseUIKit/CJCollectionView：集合视图

###### (1)、CJBaseUIKit/CJCollectionView/CJBaseCollectionViewCell：基础的CollectionViewCell
###### (2)、CJBaseUIKit/CJCollectionView/CJCollectionViewLayout
###### (3)、CJBaseUIKit/CJCollectionView/MyEqualCellSizeCollectionView：一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)
###### (4)、CJBaseUIKit/CJCollectionView/CJOpenCollectionView：可展开的集合视图

#### 13、CJBaseUIKit/CJSlider：滑块

#### 14、CJBaseUIKit/CJRefreshView：刷新

#### 15、CJBaseUIKit/CJMJRefreshComponent：已包含pod 'MJRefresh'

#### 16、CJBaseUIKit/CJToast：Toast

#### 17、CJBaseUIKit/CJAlert：Alert

#### 18、 CJBaseUIKit/CJDataEmptyView：空视图(处理数据为空、网络加载失败等情况)

待完善







## 二、CJComplexUIKit：自定义的稍微复杂的UI

#### 0、内容涵盖

> - CJComplexUIKit/UIViewController：视图控制器相关
>   - CJComplexUIKit/UIViewController/CJCategory：控制器的分类：包含对视图控制器返回按钮的操作自定义等
>   - CJComplexUIKit/UIViewController/CJBaseWebViewController：基本的网页浏览器，包含了加载进度和空网页操作
>
> - CJComplexUIKit/CJDataScrollView：含数据
>   - CJComplexUIKit/CJDataScrollView/SearchScrollView
>   - CJComplexUIKit/CJDataScrollView/ImagePickerCollectionlView



<p id="其他"></p>
## 其他
> [< 返回目录](#目录)

#### 1、顶部图片下拉放大、上推缩小
下拉放大原理：其实就是利用下拉的时候，根据contentOffset来对应跟新顶部视图的frame。
需求①：由于我们的顶部视图必须满足能够拖动，所以我们的顶部视图肯定是依赖于UIScrollView移动的。①如果我们的顶部视图是被添加到scrollView上，我们可以利用ScrollView的contentInset来将滚动视图的顶部留给顶部视图。随后，在滚动过程中如果发现是下拉滚动，则将顶部视图的frame根据滚动的contentOffset来减小它的y及增大它的height即可了。 ②如果我们的顶部视图是被添加到与scrollView同层级的view上，由于我们要满足在顶部上可以触发滚动，所以我们的顶部视图肯定还是得依赖于UIScrollView的滚动的。那么也就代表着我们的顶部视图其实还是应该看起来像是占据着ScrollView的contentInset的顶部的，也就是说我们得利用ScrollView的contentInset来将滚动视图的顶部留给顶部视图。且我们的view必须在ScrollView之下，而为了

```
	//[self.view addSubview:self.headerView]; //错误，因为放置位置错误
	
	[self.view insertSubview:self.headerView belowSubview:self.tableView]; //正确的放置位置（附：此时点击headerView上的操作是可以被触发的）
	self.tableView.backgroundColor = [UIColor clearColor]; //记得弄透明，以此来解决位置正确后被遮挡的问题
    
```

