# AllScrollView
A demo contain scrollView、tableView、collectionView

## 知识储备
#### 一、tableView updates 对比 reloadData
	调用numberOfRows方法的次数比较：都只调用一次 numberOfRows 方法

	调用cellForRow方法的次数比较：
	①reloadData会为当前显示的所有cell调用这个方法
	②updates只会为新增的cell调用这个方法

	调用cellForRow方法的调用时刻比较：
	①、reloadData：会在numberOfRows方法调用后的某一时间异步调用cellForRow方法
	②、updates：会在numberOfRows方法调用后马上调用cellForRow方法

	各自的缺陷：
	①reloadData方法缺陷：带来额外的不必要开销，缺乏动画
	②updates方法缺陷：deleteRows不会调用cellForRow方法，可能导致显示结果与数据源不一致；需要手动保证 insertRows、deleteRows 之后，row 的数量与 numberOfRows 的结果一致，否则会运行时崩溃
	
## CollectionView的自定义
参考文档：[横向排列数据的UICollectionview](http://blog.csdn.net/shengpeng3344/article/details/51673707) 其中包含可以拖动cell的示例

## MyEqualCellSizeCollectionView
一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)


## UIScrollView+AutoLayout
[iOS中Xcode使用UIScrollView+AutoLayout轻松实现滚动布局](http://www.2cto.com/kf/201604/503132.html)

实际上只要我们往UIScrollView中添加的containerView，能够依靠自己知道宽、高即可。比如

## CJBadgeImageView
包含Badge的ImageView,该类直接继承于UIImageView

## CJBaseTableViewCell
基本UITableViewCell继承而来的自己的各种基本TableView

## FriendCircle
实现类似微信朋友圈或者QQ空间，评论回复，贴吧盖楼，九宫格布局。处理键盘弹出后定位到当前点击的被评论人处。

## 单选、多选、全选
问题1：怎么在切换到编辑的时候，出现一排待选中框？不采用reloadData方式。
以下内容摘自：[UITableView编辑模式中的《五.多行选取模式》](http://blog.sina.com.cn/s/blog_51a995b70101iwgx.html)

在iOS5.0中UITableView增加了`allowsMultipleSelectionDuringEditing`属性和`indexPathsForSelectedRows`方法。其中`allowsMultipleSelectionDuringEditing`属性默认为NO,当此值为YES时，UITableView进入编辑模式，不会向dataSource查询editStyle,而会直接每个Cell的左边显示圆形选择框，点击选择该行后圆形框里面为对勾。附：可使用indexPathsForSelectedRows方法获取到所有选择行的indexPath。参考苹果公司提供了使用此种方式的实例代码[Multiple Selection with UITableView](https://developer.apple.com/library/content/samplecode/TableMultiSelect/Introduction/Intro.html#//apple_ref/doc/uid/DTS40011189)

## 滑动选择UITableViewRowAction

## CJSearchUtil
搜索功能的工具类


#### Screenshots
![Example](./Screenshots/Demo.gif "Demo")
![Example](./Screenshots/Demo.png "Demo")

#### TableView多选
[UITableView的多选在选中时有一层View将cell 盖住了。怎么将它设置成透明，或者去掉](http://www.cocoachina.com/bbs/read.php?tid-249017.html)
正确答案是：

```
cell.multipleSelectionBackgroundView = [[UIView alloc] init];
cell.multipleSelectionBackgroundView.backgroundColor = [UIColor clearColor];
```

##### 点赞
功能有：

* 点击点赞按钮，能点赞/取消点赞
* 点击点赞列表里的用户名，能进入相应操作
* 点赞增加、删除成功时候：点赞表高及内容cell高的同时更新

###### 评论增删
功能有:

* 点击评论按钮，能增加评论；
* 点击评论列表中不同评论能进行增加评论和删除评论
* 增加评论时候弹出键盘的处理： 
（1）点击评论则定位在当前点击的评论按钮下方
（2）点击评论内容所在cell，则直接定位在点击的评论内容的cell的下方
（3）完美兼容系统键盘和搜狗键盘
* 评论增加、删除成功时候：评论表高及内容cell高的同时更新

