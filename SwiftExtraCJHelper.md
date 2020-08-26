# Swift中的NSClassFromString最全解

## 一、前言

在Swift中使用NSClassFromString有时候会遇到获取不到类的情况

1、Swift中调用OC写的类

2、Swift中调用Swift写的类，且该类在本工程中

3、Swift中调用Swift写的类，且该类在其他工程中



## 二、必备基础知识

1、Swift中调用OC写的类

```swift
// 当Swift中调用OC写的类
lastClassName = className

NSClassFromString(lastClassName)
```

2、Swift中调用Swift写的类

当Swift中调用Swift写的类，因为Swift类现在是命名空间，因此它不是“MyViewController”而是“AppName.MyViewController”

```swift
// 当Swift中调用Swift写的类，因为Swift类现在是命名空间，因此它不是“MyViewController”而是“AppName.MyViewController”
var nameSpace : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleExecutable") as! String
// 附：这个特别需要注意一点的是如果你的包名中有'-'横线这样的字符，在拿到包名后，还需要把包名的'-'转换成'_'下横线，这点特别坑(折腾了半天才找到原因😤)
nameSpace = nameSpace.replacingOccurrences(of: "-", with: "_")

lastClassName = lastNameSpace + "." + className

NSClassFromString(lastClassName)
```



## 三、快速准确一步调用

有了上述的知识了解，我们这里简单写了个库

1、Swift中调用OC写的类

```swift
let viewController: UIViewController = NSClassFromStringCJHelper.controllerFormString(className: "OverlayHomeViewController", isOC: true)
```

2、Swift中调用Swift写的类，且该类在本工程中

```swift
let viewController: UIViewController = NSClassFromStringCJHelper.controllerFormString(className: "OverlayHomeViewController", isOC: false)
```

3、Swift中调用Swift写的类，且该类在其他工程/库`TSSwiftDemo_Overlay`中

```swift
let viewController: UIViewController = NSClassFromStringCJHelper.controllerFormString(className: "OverlayHomeViewController", isOC: false, nameSpace='TSSwiftDemo_Overlay')
```





## End