# CJUIKit
自定义的基础UI控件

如果只想加载某个类，可以用形如`pod 'CJBaseUIKit/CJTextView', '~> 0.0.1'`来加载

## UIColor+CJCategory
UIColor+CJHex用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式

## CJImageView
包含CJBadgeImageView

CJImageView，可为ImageView设置title；而CJBadgeImageView则还可以设置badge;

## CJTextField


## CJTextView
类似微信文本输入框实现

功能：

1. 有占位符placeholderView
2. 可设置最大行数maxNumberOfLines，当超过最大行文本框不在自增长长度