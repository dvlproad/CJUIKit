# CJFoundation

自定义的UIFoundation的Extension


## NSDate
①、NSString转NSDate为nil

举例：2017-04-17 19:49:52

		NSString *currentTime = @"2017-04-17 19:49:52";
		
		NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
        NSDate *currentDate = [dateFormatter dateFromString:currentTime];

错误可能原因：

①、dateFormatter.dateFormat格式不对，比如string里面有时分秒，而dateFormatter.dateFormat却只写到@"yyyy-MM-dd";

②、还是dateFormatter.dateFormat格式不对，比如大小写错误，如HH被写成了小写了。即dateFormatter.dateFormat = @"yyyy-MM-dd hh:mm:ss"也是可能会造成错误的。因为小写的hh是代表跟随者系统采用的小时制，而上面的我们的值是24小时制，所以应该用大写的HH。即**注意的是formatter的格式，如果是小写的"hh"，那么时间将会跟着系统设置变成12小时或者24小时制。大写的"HH"，则强制为24小时制。**

##### 扩展：必须知道的事
参考：[iOS时间那点事--NSDateFormatter](https://my.oschina.net/yongbin45/blog/150667)

	 G: 公元时代，例如AD公元
    yy: 年的后2位
    yyyy: 完整年
    MM: 月，显示为1-12
    MMM: 月，显示为英文月份简写,如 Jan
    MMMM: 月，显示为英文月份全称，如 Janualy
    dd: 日，2位数表示，如02
    d: 日，1-2位显示，如 2
    EEE: 简写星期几，如Sun
    EEEE: 全写星期几，如Sunday
    aa: 上下午，AM/PM
    H: 时，24小时制，0-23
    K：时，12小时制，0-11
    m: 分，1-2位
    mm: 分，2位
    s: 秒，1-2位
    ss: 秒，2位
    S: 毫秒
    Z：GMT
    
    常用的时间格式有：
    yyyy-MM-dd HH:mm:ss.SSS
	yyyy-MM-dd HH:mm:ss
	yyyy-MM-dd
	MM dd yyyy 