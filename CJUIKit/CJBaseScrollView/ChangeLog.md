# ChangeLog
A demo contain scrollView、tableView、collectionView

## MyEqualCellSizeCollectionView
###### V0.1.0
去掉下面这部分

* ①原本用NSUInteger currentDataModelCount(数据源的个数)来控制collectionView的显示个数，而不是使用dataModels来控制，这种情况下则易出现崩溃的问题。因为[collectionView reloadData];之前必须先修改currentDataModelCount的值使其与dataModel的个数一样，而这个很容易被我们忽略掉

* ②原本的布局用一些默认参数以及NSInteger cellWidthFromPerRowMaxShowCount(通过每行可显示的最多个数来设置每个cell的宽度) 和 CGFloat cellWidthFromFixedWidth(通过cell的固定宽度来设置每个cell的宽度)二选一设置（默认cellWidthFromFixedWidth设置后，另外一个自动失效）cellWidth 以及 用CGFloat collectionViewCellHeight（cell高,没设置的话等于其宽）,但这种方法不满足有时候我们需要设置minimumInteritemSpacing等，所以我们扩大设置项增加MyEqualCellSizeLayout来设置

###### V0.2.0
2017-10-12
将MyEqualCellSizeCollectionView中的dataModel去掉，使其耦合性更低


