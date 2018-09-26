<p id="目录"></p>
## 目录
* [一、CJBaseUIKit：自定义的基础UI控件](#CJBaseUIKit)
* [二、CJComplexUIKit：自定义的稍微复杂的UI](#CJComplexUIKit)
* [三、CJFoundation：系统Foundation的扩展](#CJFoundation)
* [四、CJBaseUtil：自定义的基础工具类](#CJBaseUtil)
* [五、CJBaseHelper：自定义的基础帮助类](#CJBaseHelper)
* [其他](#其他)
* [版本介绍/更新记录](#版本介绍/更新记录)



<p id="CJBaseUIKit"></p>
## 一、CJBaseUIKit：自定义的基础UI控件
> [< 返回目录](#目录)

自定义的基础UI控件

内容如下：

>
- CJBaseUIKit/UIColor：颜色：用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
- CJBaseUIKit/UIImage：图片
- CJBaseUIKit/UINavigationBar：导航栏
>
- CJBaseUIKit/UIView：视图
- CJBaseUIKit/UIView/CJDragAction：视图拖动
- CJBaseUIKit/UIView/CJShakeAction：视图抖动
- CJBaseUIKit/UIView/CJPopupAction：视图弹窗：UIView的类别，用来实现UIView弹出popupView的一个Uiew的类别
- CJBaseUIKit/UIView/CJGestureRecognizer：视图手势
>
- CJBaseUIKit/UIWindow：窗口
- CJBaseUIKit/UIButton：按钮
- CJBaseUIKit/CJImageView：图片视图(包含CJBadgeImageView),用于设置imageView的title和badge
- CJBaseUIKit/UITextField：文本视图：包含文本框类别及新的自定义文本框
- CJBaseUIKit/CJTextView：文本视图：类似微信文本输入框实现
- CJBaseUIKit/UIToolbar：工具栏
- CJBaseUIKit/CJScrollView：滚动视图：自定义的基础滚动视图
>
- CJBaseUIKit/CJTableView：列表视图
- CJBaseUIKit/CJTableView/CJBaseTableViewCell：基础的TableViewCell
- CJBaseUIKit/CJTableView/CJBaseTableViewHeaderFooterView
>
- CJBaseUIKit/CJCollectionView：集合视图
- CJBaseUIKit/CJCollectionView/CJBaseCollectionViewCell：基础的CollectionViewCell
- CJBaseUIKit/CJCollectionView/CJCollectionViewLayout
- CJBaseUIKit/CJCollectionView/MyEqualCellSizeCollectionView：一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)
- CJBaseUIKit/CJCollectionView/CJOpenCollectionView：可展开的集合视图
>
- CJBaseUIKit/CJSlider：滑块
- CJBaseUIKit/CJRefreshView：刷新
- CJBaseUIKit/CJMJRefreshComponent：已包含pod 'MJRefresh'
- CJBaseUIKit/CJToast：Toast


如果只想加载某个类，可以用形如`pod 'CJBaseUIKit/CJTextView', '~> 0.0.1'`来加载

#### 1、CJBaseUIKit/UIColor：颜色
UIColor+CJHex用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式

#### 2、CJBaseUIKit/UIImage：图片
###### (1)、UIImage+CJChangeColor
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

#### 7、CJBaseUIKit/CJImageView：图片视图(包含CJBadgeImageView),用于设置imageView的title和badge
包含CJBadgeImageView

CJImageView，可为ImageView设置title；而CJBadgeImageView则还可以设置badge;

#### 8、CJBaseUIKit/UITextField：文本视图：包含文本框类别及新的自定义文本框

#### 9、CJBaseUIKit/CJTextView：文本视图：类似微信文本输入框实现
类似微信文本输入框实现

功能：

1. 有占位符placeholderView
2. 可设置最大行数maxNumberOfLines，当超过最大行文本框不在自增长长度



#### 10、CJBaseUIKit/UIToolbar：工具栏

#### 11、CJBaseUIKit/CJScrollView：滚动视图：自定义的基础滚动视图

#### 12、CJBaseUIKit/CJTableView：列表视图
###### (1)、CJBaseUIKit/CJTableView/CJBaseTableViewCell：基础的TableViewCell
###### (2)、CJBaseUIKit/CJTableView/CJBaseTableViewHeaderFooterView

#### 13、CJBaseUIKit/CJCollectionView：集合视图
###### (1)、CJBaseUIKit/CJCollectionView/CJBaseCollectionViewCell：基础的CollectionViewCell
###### (2)、CJBaseUIKit/CJCollectionView/CJCollectionViewLayout
###### (3)、CJBaseUIKit/CJCollectionView/MyEqualCellSizeCollectionView：一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)
###### (4)、CJBaseUIKit/CJCollectionView/CJOpenCollectionView：可展开的集合视图

#### 14、CJBaseUIKit/CJSlider：滑块

#### 15、CJBaseUIKit/CJRefreshView：刷新

#### 16、CJBaseUIKit/CJMJRefreshComponent：已包含pod 'MJRefresh'

#### 17、CJBaseUIKit/CJToast：Toast

#### 18、CJBaseUIKit/CJAlert：Alert


待完善









<p id="CJComplexUIKit"></p>
## 二、CJComplexUIKit：自定义的稍微复杂的UI
> [< 返回目录](#目录)

> 
- CJComplexUIKit/UIViewController：视图控制器相关
- CJComplexUIKit/UIViewController/CJCategory：控制器的分类：包含对视图控制器返回按钮的操作自定义等
- CJComplexUIKit/UIViewController/CJBaseWebViewController：基本的网页浏览器，包含了加载进度和空网页操作
>
- CJComplexUIKit/CJDataEmptyView：数据空时候的视图
>
- CJComplexUIKit/CJDataScrollView：含数据
- CJComplexUIKit/CJDataScrollView/SearchScrollView
- CJComplexUIKit/CJDataScrollView/ImagePickerCollectionlView







<p id="CJFoundation"></p>
## 三、CJFoundation：系统Foundation的扩展
> [< 返回目录](#目录)

>
- CJFoundation/NSString：包含字符串的各种相关操作(获取长度、判断是否手机号码等等等)
- CJFoundation/NSDictionary：包含字典的各种相关操作
- CJFoundation/NSJSONSerialization：模型转换






<p id="CJBaseUtil"></p>
## 四、CJBaseUtil：自定义的基础工具类
> [< 返回目录](#目录)

>
- CJBaseUtil/CJLog：日志输出工具
- CJBaseUtil/CJIndentedStringUtil：将类转成字符串，并缩进的工具
- CJBaseUtil/CJAppLastUtil：获取APP上次退出时候的信息工具
- CJBaseUtil/CJDataUtil：数据工具(包含分类、排序、搜索以及一些基本的数据模型等)
- CJBaseUtil/CJDateUtil：日期工具
- CJBaseUtil/CJKeyboardUtil：键盘工具
- CJBaseUtil/UIUtil：UI工具
- CJBaseUtil/CJCallUtil：调用系统功能的工具，如拨打电话
- CJBaseUtil/CJQRCodeUtil：二维码工具，如使用字符串生成二维码
- CJBaseUtil/CJLaunchImageUtil：启动页工具
>
- CJBaseUtil/CJManager
- CJBaseUtil/CJManager/CJModuleManager：模块化管理器
- CJBaseUtil/CJManager/CJLocationChangeManager：位置服务管理，包含位置更新等
- CJBaseUtil/CJManager/CJTimerManager：定时器管理器，如一个登录页需要短信验证码和语音验证码，但只使用一个定时器。
- CJBaseUtil/CJPinyinHelper：字符串转拼音工具






<p id="CJBaseHelper"></p>
## 五、CJBaseHelper：自定义的基础帮助类
> [< 返回目录](#目录)

- CJBaseUtil/DeviceCJHelper：获取设备信息
- CJBaseHelper/NSObjectCJHelper：对象判断帮助类
- CJBaseHelper/UIViewControllerCJHelper：视图控制器帮助类：包含获取当前显示的视图控制器和通过视图找到它所在的视图控制器等
- CJBaseHelper/NSOperationQueueCJHelper：多任务处理
- CJBaseHelper/WebCJHelper：Web工具，包含清除缓存







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



<p id="版本介绍/更新记录"></p>
## 版本介绍/更新记录
#### 总
* 2018-09-15

> 1. 调整项目结构

#### CJBaseUIKit
* 2018-09-27 V0.2.6

> 1. CJTextField增加添加下划线和设置支持selected的左侧图片

* 2018-09-22 V0.2.4

> 1. 修复CJTextView自定义的placeholder无法改变字体大小的问题；
> 2. 增加UIButton设置高亮时候的背景色方法。

#### CJBaseUtil
* 2018-08-29 V0.3.1

> 1. 在`CJLog`里增加`CJLogViewWindow`一个在 iOS 设备屏幕上实时打印 Log 的小工具；
> 2. 在`CJManager`下增加管理悬浮窗的`CJSuspendWindowManager`，用来处理防止重复生成等。


#### CJBaseHelper
* 2018-09-22 V0.0.6

> 1. 转移CJBaseUtil中的CJDateFormatterUtil为`NSDateFormatterCJHelper`
> 
> 2. 转移CJBaseUtil中的CJCalendarUtil为`NSCalendarCJHelper `

* 2018-09-15 V0.0.5

> 1. 更改对象判空的类名为`NSObjectCJHelper`
> 
> 2. DeviceCJHelper增加`getIPAddressByHostName:`根据域名host获取ip的方法


## Author Or Contact
* [邮箱：studyroad@qq.com](studyroad@qq.com)
* [简书：https://www.jianshu.com/u/498d9e6a26e1](https://www.jianshu.com/u/498d9e6a26e1)
* [码云：https://gitee.com/dvlproad](https://gitee.com/dvlproad)


## 结束语
欢迎Stat、Follow、Fork、Pull Request！
