[TOC]

## 目录

* 一、CJBaseUIKit：自定义的基础UI控件
* 二、CJComplexUIKit：自定义的稍微复杂的UI
* 三、CJFoundation：系统Foundation的扩展
* 四、CJBaseUtil：自定义的基础工具类
* 五、CJBaseHelper：自定义的基础帮助类
* 六、CJBaseTest：自定义的基础测试类
* 版本介绍/更新记录


## 一、CJBaseUIKit：自定义的基础UI控件

#### 0、内容涵盖------[点击进入详情查看](./README/CJBaseUIKit_CJComplexUIKit.md)

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





## 二、CJComplexUIKit：自定义的稍微复杂的UI

#### 0、内容涵盖------[点击进入详情查看](./README/CJBaseUIKit_CJComplexUIKit.md)

> - CJComplexUIKit/UIViewController：视图控制器相关
>   - CJComplexUIKit/UIViewController/CJCategory：控制器的分类：包含对视图控制器返回按钮的操作自定义等
>   - CJComplexUIKit/UIViewController/CJBaseWebViewController：基本的网页浏览器，包含了加载进度和空网页操作
> - CJComplexUIKit/CJDataScrollView：含数据
>   - CJComplexUIKit/CJDataScrollView/SearchScrollView
>   - CJComplexUIKit/CJDataScrollView/ImagePickerCollectionlView



## 三、CJFoundation：系统Foundation的扩展

#### 0、内容涵盖------[点击进入详情查看](./README/CJFoundation_CJBaseHelper_CJBaseUtil.md)

> - CJFoundation/NSString：包含字符串的各种相关操作(获取长度、判断是否手机号码等等等)
> - CJFoundation/NSDictionary：包含字典的各种相关操作
> - CJFoundation/NSJSONSerialization：模型转换





## 四、CJBaseHelper：自定义的基础帮助类

#### 0、内容涵盖------[点击进入详情查看](./README/CJFoundation_CJBaseHelper_CJBaseUtil.md)

> - CJBaseUtil/DeviceCJHelper：获取设备信息
> - CJBaseHelper/NSObjectCJHelper：对象判断帮助类
> - CJBaseHelper/UIViewControllerCJHelper：视图控制器帮助类：包含获取当前显示的视图控制器和通过视图找到它所在的视图控制器等
> - CJBaseHelper/NSOperationQueueCJHelper：多任务处理
> - CJBaseHelper/WebCJHelper：Web工具，包含清除缓存
> - CJBaseHelper/AuthorizationCJHelper：权限判断及系统设置打开





## 五、CJBaseUtil：自定义的基础工具类

#### 0、内容涵盖------[点击进入详情查看](./README/CJFoundation_CJBaseHelper_CJBaseUtil.md)

> - CJBaseUtil/CJIndentedStringUtil：将类转成字符串，并缩进的工具
> - CJBaseUtil/CJAppLastUtil：获取APP上次退出时候的信息工具
> - CJBaseUtil/CJDataUtil：数据工具(包含分类、排序、搜索以及一些基本的数据模型等)
> - CJBaseUtil/CJDateUtil：日期工具
> - CJBaseUtil/CJKeyboardUtil：键盘工具
> - CJBaseUtil/UIUtil：UI工具
> - CJBaseUtil/CJCallUtil：调用系统功能的工具，如拨打电话
> - CJBaseUtil/CJQRCodeUtil：二维码工具，如使用字符串生成二维码
> - CJBaseUtil/CJLaunchImageUtil：启动页工具
> - CJBaseUtil/CJManager
>   - CJBaseUtil/CJManager/CJModuleManager：模块化管理器
>   - CJBaseUtil/CJManager/CJLocationChangeManager：位置服务管理，包含位置更新等
>   - CJBaseUtil/CJManager/CJTimerManager：定时器管理器，如一个登录页需要短信验证码和语音验证码，但只使用一个定时器。
> - CJBaseUtil/CJPinyinHelper：字符串转拼音工具



## 六、CJBaseTest：自定义的基础测试类

#### 0、内容涵盖------[点击进入详情查看](./README/CJBaseTest.md)

> - CJBaseTest/Test：单元测试类
> - CJBaseTest/UITest：自动化测试类






## 版本介绍/更新记录
#### 0、总更新记录
* 2018-09-15

> 1. 调整项目结构



#### 1、CJBaseUIKit更新记录

- 2019-01-21 V0.4.0

> 1. 精简CJBaseUIKit库，转移不一定是Base的库到CJComplexUIKit中

- 2018-10-16 V0.3.0

> 1. UIView+CJPopupInView 增加设置空白区域的背景颜色blankBGColor；

- 2018-10-10 V0.2.9

> 1. 去除CJBadgeImageView，改为CJBadgeButton
> 2. 添加UIViewController+CJSystemComposeView，处理添加childViewController以及转换的方法；

- 2018-09-27 V0.2.6

> 1. CJTextField增加添加下划线和设置支持selected的左侧图片

- 2018-09-22 V0.2.4

> 1. 修复CJTextView自定义的placeholder无法改变字体大小的问题；
> 2. 增加UIButton设置高亮时候的背景色方法。



#### 2、CJComplexUIKit更新记录

- 2018-09-27 V0.2.0

> 1. 转移CJDataEmptyView到CJBaseUIKit上



#### 3、CJFoundation更新记录

- 2018-09-27 V0.2.0

> 1. 转移CJDataEmptyView到CJBaseUIKit上



#### 4、CJBaseHelper更新记录

- 2018-12-10 V0.1.0

> 1. 将NSCalendarCJHelper中的方法改为C函数来提供

- 2018-11-01 V0.0.7

> 1. 转移CJMedia中的CJValidateAuthorizationUtil到CJBaseHelper/AuthorizationCJHelper：权限判断及系统设置打开

- 2018-09-22 V0.0.6

> 1. 转移CJBaseUtil中的CJDateFormatterUtil为`NSDateFormatterCJHelper`
> 2. 转移CJBaseUtil中的CJCalendarUtil为`NSCalendarCJHelper `

- 2018-09-15 V0.0.5

> 1. 更改对象判空的类名为`NSObjectCJHelper`
> 2. DeviceCJHelper增加`getIPAddressByHostName:`根据域名host获取ip的方法



#### 5、CJBaseUtil更新记录

- 2019-01-03 V0.5.0

> 1. 将 `CJLog`从CJBaseUtil中转移到CJMonitor中

- 2018-08-29 V0.3.1

> 1. 在`CJLog`里增加`CJLogViewWindow`一个在 iOS 设备屏幕上实时打印 Log 的小工具；
> 2. 在`CJManager`下增加管理悬浮窗的`CJSuspendWindowManager`，用来处理防止重复生成等。



#### 6、CJBaseTest更新记录

> 无




## Author Or Contact

* [邮箱：studyroad@qq.com](studyroad@qq.com)
* [简书：https://www.jianshu.com/u/498d9e6a26e1](https://www.jianshu.com/u/498d9e6a26e1)
* [码云：https://gitee.com/dvlproad](https://gitee.com/dvlproad)




## 结束语
欢迎Stat、Follow、Fork、Pull Request！
