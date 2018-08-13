## 目录
本项目包含的开源库有


> 
* 1、CJBaseUIKit：自定义的基础UI控件
* 2、CJComplexUIKit：自定义的稍微复杂的UI
* 3、CJFoundation：系统Foundation的扩展
* 4、CJBaseUtil：自定义的基础工具类
* 5、CJBaseHelper：自定义的基础帮助类

## 一、CJBaseUIKit：自定义的基础UI控件
自定义的基础UI控件

如果只想加载某个类，可以用形如`pod 'CJBaseUIKit/CJTextView', '~> 0.0.1'`来加载

#### 1、CJBaseUIKit/UIColor
UIColor+CJHex用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式

#### 2、CJBaseUIKit/UIImage
###### (1)、UIImage+CJChangeColor
参考：[iOS中使用blend改变图片颜色](https://onevcat.com/2013/04/using-blending-in-ios/)

问题来源：在应用里一个很常见的需求是主题变换：同样的图标，同样的素材，但是需要按照用户喜爱变为不同的颜色。


#### CJBaseUIKit/CJImageView
包含CJBadgeImageView

CJImageView，可为ImageView设置title；而CJBadgeImageView则还可以设置badge;

#### CJBaseUIKit/UITextField


#### CJBaseUIKit/CJTextView
类似微信文本输入框实现

功能：

1. 有占位符placeholderView
2. 可设置最大行数maxNumberOfLines，当超过最大行文本框不在自增长长度


#### 顶部图片下拉放大、上推缩小
下拉放大原理：其实就是利用下拉的时候，根据contentOffset来对应跟新顶部视图的frame。
需求①：由于我们的顶部视图必须满足能够拖动，所以我们的顶部视图肯定是依赖于UIScrollView移动的。①如果我们的顶部视图是被添加到scrollView上，我们可以利用ScrollView的contentInset来将滚动视图的顶部留给顶部视图。随后，在滚动过程中如果发现是下拉滚动，则将顶部视图的frame根据滚动的contentOffset来减小它的y及增大它的height即可了。 ②如果我们的顶部视图是被添加到与scrollView同层级的view上，由于我们要满足在顶部上可以触发滚动，所以我们的顶部视图肯定还是得依赖于UIScrollView的滚动的。那么也就代表着我们的顶部视图其实还是应该看起来像是占据着ScrollView的contentInset的顶部的，也就是说我们得利用ScrollView的contentInset来将滚动视图的顶部留给顶部视图。且我们的view必须在ScrollView之下，而为了

```
	//[self.view addSubview:self.headerView]; //错误，因为放置位置错误
	
	[self.view insertSubview:self.headerView belowSubview:self.tableView]; //正确的放置位置（附：此时点击headerView上的操作是可以被触发的）
	self.tableView.backgroundColor = [UIColor clearColor]; //记得弄透明，以此来解决位置正确后被遮挡的问题
    
```


待完善

## 二、CJComplexUIKit：自定义的稍微复杂的UI
待整理

## 三、CJFoundation：系统Foundation的扩展
待整理

## 四、CJBaseUtil：自定义的基础工具类
待整理

## 五、CJBaseHelper：自定义的基础帮助类
待整理