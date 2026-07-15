Pod::Spec.new do |s|
  # 验证方法：pod lib lint CJBaseUIKit.podspec --sources='https://github.com/CocoaPods/Specs.git' --allow-warnings --use-libraries --verbose
  # 上传方法：pod trunk push CJBaseUIKit.podspec --allow-warnings --use-libraries --verbose
  # pod的本地索引文件：~/Library/Caches/CocoaPods/search_index.json
  # pod的owner操作：https://www.jianshu.com/p/a9b8c2a1f3cf
  s.name         = "CJBaseUIKit"
  s.version      = "0.9.0"
  s.summary      = "自定义的基础UI"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 自定义的基础UI，可按需独立引入：
                 • CJBaseUIKit/CJUIKitConstant - Constant 常量信息
                 • CJBaseUIKit/UIColor - 颜色：用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
                 • CJBaseUIKit/UIImage - 图片
                 • CJBaseUIKit/UINavigationBar - 导航栏
                 • CJBaseUIKit/UIView - UIView(视图拖动、抖动、根据键盘自动上移、手势、出现动画、转场动画、加圆角等)
                 • CJBaseUIKit/UIView/CJDragAction - 视图拖动
                 • CJBaseUIKit/UIView/CJShakeAction - 视图抖动
                 • CJBaseUIKit/UIView/CJAutoMoveUp - 本视图根据键盘自动上移的方法
                 • CJBaseUIKit/UIView/CJGestureRecognizer - 视图手势
                 • CJBaseUIKit/UIView/CJAnimation - Animation(出现动画、转场动画。如常见的出现动画：Fade淡入淡出、MoveIn覆盖、Push推挤、Reveal揭开；自定义的出现动画：Cube立方体、SuckEffect吮吸、OglFlip翻转、RippleEffect波纹、PageCurl翻页、PageUnCurl反翻页、CameraIrisHollowOpen开镜头、CameraIrisHollowClose关镜头；转场动画：None无、FlipFromLeft左翻转、FlipFromRight右翻转、CurlUp上翻页、CurlDown下翻页)
                 • CJBaseUIKit/UIView/CJAddCorner - 视图添加圆角
                 • CJBaseUIKit/UIWindow - UIWindow
                 • CJBaseUIKit/UIViewController - 自定义返回按钮
                 • CJBaseUIKit/UILabel - Label
                 • CJBaseUIKit/UIButton - 按钮 及 CJBadgeButton
                 • CJBaseUIKit/UITextField - 文本视图：包含文本框类别及新的自定义文本框
                 • CJBaseUIKit/UITextInputCJHelper - 文本长度限制、光标设置等：UITextField 和 UITextView 会需要使用到的字符串处理方法，会依赖CJDataVientianeSDK(从0.9.0开始，1指定位置、指定范围、最大长度字符串获取；2复制粘贴新字符串获取的方法，已移动到 CJDataVientianeSDK)
                 • CJBaseUIKit/UITextHeightCenterCJHelper - 竖直居中设置方法：UITextView 会需要使用到(从0.9.0开始，文本在指定宽度下的高度计算，已移动到 CJDataVientianeSDK)
                 • CJBaseUIKit/UITextView - 文本视图：类似微信文本输入框实现
                 • CJBaseUIKit/UIToolbar - 工具栏
                 • CJBaseUIKit/UIScrollView - 与 UIScrollView 相关的基础类
                 • CJBaseUIKit/UIScrollView/CJKeyboardAvoiding - 滚动视图：含监听滚动视图的键盘(用于让点击的文本框视图，不会被键盘遮挡住)
                 • CJBaseUIKit/CJBaseTableViewCell - 列表--基础的TableViewCell
                 • CJBaseUIKit/CJBaseTableViewHeaderFooterView - 列表--HeaderFooterView
                 • CJBaseUIKit/CJSlider - 滑块

                 每个子库可独立引入，详见各子库描述。
                 DESC
  

  #s.license      = {
  #  :type => 'Copyright',
  #  :text => <<-LICENSE
  #            © 2008-2016 Dvlproad. All rights reserved.
  #  LICENSE
  #}
  s.license      = "MIT"

  s.author   = { "dvlproad" => "" }

  s.platform     = :ios, "9.0"
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseUIKit_0.9.0_1" }
  s.source_files  = "CJBaseUIKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "CJBaseUIKit/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  # s.dependency 'Masonry'

  # Constant 常量信息
  s.subspec 'CJUIKitConstant' do |ss|
    ss.source_files = "CJBaseUIKit/CJUIKitConstant/**/*.{h,m}"
  end

  # 颜色：用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
  s.subspec 'UIColor' do |ss|
    ss.source_files = "CJBaseUIKit/UIColor/**/*.{h,m}"
  end

  # 图片
  s.subspec 'UIImage' do |ss|
    ss.source_files = "CJBaseUIKit/UIImage/**/*.{h,m}"
  end


  # 导航栏
  s.subspec 'UINavigationBar' do |ss|
    ss.source_files = "CJBaseUIKit/UINavigationBar/**/*.{h,m}"
  end





  # UIView(视图拖动、抖动、根据键盘自动上移、手势、出现动画、转场动画、加圆角等)
  s.subspec 'UIView' do |ss|
    ss.source_files = "CJBaseUIKit/UIView/*.{h,m}"

    # 视图拖动
    ss.subspec 'CJDragAction' do |sss|
      sss.source_files = "CJBaseUIKit/UIView/CJDragAction/**/*.{h,m}"
  	end

    # 视图抖动
  	ss.subspec 'CJShakeAction' do |sss|
      sss.source_files = "CJBaseUIKit/UIView/CJShakeAction/**/*.{h,m}"
  	end

    # 本视图根据键盘自动上移的方法
  	ss.subspec 'CJAutoMoveUp' do |sss|
      sss.source_files = "CJBaseUIKit/UIView/CJAutoMoveUp/**/*.{h,m}"
  	end

    # 视图手势
  	ss.subspec 'CJGestureRecognizer' do |sss|
      sss.source_files = "CJBaseUIKit/UIView/CJGestureRecognizer/**/*.{h,m}"
  	end

    # Animation(出现动画、转场动画。如常见的出现动画：Fade淡入淡出、MoveIn覆盖、Push推挤、Reveal揭开；自定义的出现动画：Cube立方体、SuckEffect吮吸、OglFlip翻转、RippleEffect波纹、PageCurl翻页、PageUnCurl反翻页、CameraIrisHollowOpen开镜头、CameraIrisHollowClose关镜头；转场动画：None无、FlipFromLeft左翻转、FlipFromRight右翻转、CurlUp上翻页、CurlDown下翻页)
    ss.subspec 'CJAnimation' do |sss|
      sss.source_files = "CJBaseUIKit/UIView/CJAnimation/**/*.{h,m}"
    end

    # 视图添加圆角
    ss.subspec 'CJAddCorner' do |sss|
      sss.source_files = "CJBaseUIKit/UIView/CJAddCorner/**/*.{h,m}"
    end
  end

  # UIWindow
  s.subspec 'UIWindow' do |ss|
    ss.source_files = "CJBaseUIKit/UIWindow/**/*.{h,m}"
  end

  # 自定义返回按钮
  s.subspec 'UIViewController' do |ss|
    ss.source_files = "CJBaseUIKit/UIViewController/**/*.{h,m}"
    ss.resources = "CJBaseUIKit/UIViewController/Resources/**/*.{png}"
  end

  # Label
  s.subspec 'UILabel' do |ss|
    ss.source_files = "CJBaseUIKit/UILabel/**/*.{h,m}"
  end

  # 按钮 及 CJBadgeButton
  s.subspec 'UIButton' do |ss|
    ss.source_files = "CJBaseUIKit/UIButton/**/*.{h,m}"
  end

  # 文本视图：包含文本框类别及新的自定义文本框
  s.subspec 'UITextField' do |ss|
    ss.source_files = "CJBaseUIKit/UITextField/**/*.{h,m}"
  end

  # 文本长度限制、光标设置等：UITextField 和 UITextView 会需要使用到的字符串处理方法，会依赖CJDataVientianeSDK(从0.9.0开始，1指定位置、指定范围、最大长度字符串获取；2复制粘贴新字符串获取的方法，已移动到 CJDataVientianeSDK)
  s.subspec 'UITextInputCJHelper' do |ss|
    ss.source_files = "CJBaseUIKit/UITextInputCJHelper/**/*.{h,m}"
    ss.dependency 'CJDataVientianeSDK/UITextInputLimitCJHelper'
  end

  # 竖直居中设置方法：UITextView 会需要使用到(从0.9.0开始，文本在指定宽度下的高度计算，已移动到 CJDataVientianeSDK)
  s.subspec 'UITextHeightCenterCJHelper' do |ss|
    ss.source_files = "CJBaseUIKit/UITextHeightCenterCJHelper/**/*.{h,m}"
  end

  # 文本视图：类似微信文本输入框实现
  s.subspec 'UITextView' do |ss|
    ss.source_files = "CJBaseUIKit/UITextView/**/*.{h,m}"
    # ss.resources = "CJBaseUIKit/UITextView/**/*.{png,xib}"
    ss.dependency "CJBaseUIKit/UITextHeightCenterCJHelper"
    ss.dependency 'CJDataVientianeSDK/UITextInputHeightCJHelper'
  end
  
  # 工具栏
  s.subspec 'UIToolbar' do |ss|
    ss.source_files = "CJBaseUIKit/UIToolbar/**/*.{h,m}"
    ss.dependency "CJBaseUIKit/UIImage"
  end


  # 与 UIScrollView 相关的基础类
  s.subspec 'UIScrollView' do |ss|
    # 滚动视图：含监听滚动视图的键盘(用于让点击的文本框视图，不会被键盘遮挡住)
    ss.subspec 'CJKeyboardAvoiding' do |sss|
      sss.source_files = "CJBaseUIKit/UIScrollView/CJKeyboardAvoiding/**/*.{h,m}"
    end
  end

  # 列表--基础的TableViewCell
  s.subspec 'CJBaseTableViewCell' do |ss|
    ss.source_files = "CJBaseUIKit/CJBaseTableViewCell/**/*.{h,m}"
    ss.resources = "CJBaseUIKit/CJBaseTableViewCell/**/*.{png}"
    ss.dependency "CJBaseUIKit/UIButton"
  end

  # 列表--HeaderFooterView
  s.subspec 'CJBaseTableViewHeaderFooterView' do |ss|
    ss.source_files = "CJBaseUIKit/CJBaseTableViewHeaderFooterView/**/*.{h,m}"
  end

  # 滑块
  s.subspec 'CJSlider' do |ss|
    # ss.source_files = "CJBaseUIKit/CJSlider/*.{h,m}", "CJBaseUIKit/CJSlider/CJAdsorbModel/**/*.{h,m}"
    ss.source_files = "CJBaseUIKit/CJSlider/**/*.{h,m}"
  end


end
