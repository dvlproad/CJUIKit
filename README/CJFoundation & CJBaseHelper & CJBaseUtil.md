[TOC]

# CJFoundation & CJBaseHelper & CJBaseUtil

“工具”类



## 目录
- 一、CJBaseUIKit：自定义的基础UI控件
- 二、CJComplexUIKit：自定义的稍微复杂的UI
- 三、CJFoundation：系统Foundation的扩展
- 四、CJBaseHelper：自定义的基础帮助类
- 五、CJBaseUtil：自定义的基础工具类
- 六、CJBaseTest：自定义的基础测试类
- 其他
- 版本介绍/更新记录



## 三、CJFoundation：系统Foundation的扩展
#### 0、内容涵盖
> - CJFoundation/NSString：包含字符串的各种相关操作(获取长度、判断是否手机号码等等等)
> - CJFoundation/NSDictionary：包含字典的各种相关操作
> - CJFoundation/NSJSONSerialization：模型转换





## 四、CJBaseHelper：自定义的基础帮助类

#### 0、内容涵盖

> - CJBaseUtil/DeviceCJHelper：获取设备信息
> - CJBaseHelper/NSObjectCJHelper：对象判断帮助类
> - CJBaseHelper/UIViewControllerCJHelper：视图控制器帮助类：包含获取当前显示的视图控制器和通过视图找到它所在的视图控制器等
> - CJBaseHelper/NSOperationQueueCJHelper：多任务处理
> - CJBaseHelper/WebCJHelper：Web工具，包含清除缓存
> - CJBaseHelper/AuthorizationCJHelper：权限判断及系统设置打开





## 五、CJBaseUtil：自定义的基础工具类
#### 0、内容涵盖
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
