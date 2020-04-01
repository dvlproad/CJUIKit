Pod::Spec.new do |s|
  # 验证方法：pod lib lint LuckinBaseUIKit.podspec --allow-warnings --use-libraries --verbose
  # pod的本地索引文件：~/Library/Caches/CocoaPods/search_index.json
  s.name         = "LuckinBaseUIKit"
  s.version      = "0.6.0"
  s.summary      = "自定义的基础UI"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 - LuckinBaseUIKit/CJUIKitConstant：常量：常量信息
                 - LuckinBaseUIKit/UIColor：颜色：用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
                 - LuckinBaseUIKit/UIImage：图片
                 - LuckinBaseUIKit/UINavigationBar：导航栏
                 - LuckinBaseUIKit/UIView：视图
                 - LuckinBaseUIKit/UIView/CJDragAction：视图拖动
                 - LuckinBaseUIKit/UIView/CJShakeAction：视图抖动
                 - LuckinBaseUIKit/UIView/CJPopupAction：视图弹窗：UIView的类别，用来实现UIView弹出popupView的一个Uiew的类别
                 - LuckinBaseUIKit/UIView/CJGestureRecognizer：视图手势
                 - LuckinBaseUIKit/UIWindow：窗口
                 - LuckinBaseUIKit/UIButton：按钮 及 CJBadgeButton
                 - LuckinBaseUIKit/UITextField：文本视图：包含文本框类别及新的自定义文本框
                 - LuckinBaseUIKit/CJTextView：文本视图：类似微信文本输入框实现
                 - LuckinBaseUIKit/UIToolbar：工具栏
                 - LuckinBaseUIKit/UIScrollView：滚动视图：含监听滚动视图的键盘
                 - LuckinBaseUIKit/CJBaseTableViewCell：基础的TableViewCell
                 - LuckinBaseUIKit/CJBaseTableViewHeaderFooterView：列表--HeaderFooterView
                 - LuckinBaseUIKit/CJSlider：滑块
                 - LuckinBaseUIKit/CJToast：Toast
                 - LuckinBaseUIKit/CJAlert：Alert
                 - LuckinBaseUIKit/UIViewController：自定义返回按钮

                   A longer description of LuckinBaseUIKit in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC
  

  #s.license      = {
  #  :type => 'Copyright',
  #  :text => <<-LICENSE
  #            © 2008-2016 Dvlproad. All rights reserved.
  #  LICENSE
  #}
  s.license      = "MIT"

  s.author   = { "dvlproad" => "" }

  s.platform     = :ios, "8.0"
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "LuckinBaseUIKit_0.6.0" }
  s.source_files  = "LuckinBaseUIKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "LuckinBaseUIKit/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  # s.dependency 'Masonry'

  # Constant 常量信息
  s.subspec 'CJUIKitConstant' do |ss|
    ss.source_files = "LuckinBaseUIKit/CJUIKitConstant/**/*.{h,m}"
  end

  s.subspec 'CJTheme' do |ss|
    ss.source_files = "LuckinBaseUIKit/CJTheme/**/*.{h,m}"
  end

  s.subspec 'UIColor' do |ss|
    ss.source_files = "LuckinBaseUIKit/UIColor/**/*.{h,m}"
  end

  s.subspec 'UIImage' do |ss|
    ss.source_files = "LuckinBaseUIKit/UIImage/**/*.{h,m}"
  end


  s.subspec 'UINavigationBar' do |ss|
    ss.source_files = "LuckinBaseUIKit/UINavigationBar/**/*.{h,m}"
  end





  # UIView
  s.subspec 'UIView' do |ss|
    ss.source_files = "LuckinBaseUIKit/UIView/*.{h,m}"

    ss.subspec 'CJDragAction' do |sss|
      sss.source_files = "LuckinBaseUIKit/UIView/CJDragAction/**/*.{h,m}"
  	end

  	ss.subspec 'CJShakeAction' do |sss|
      sss.source_files = "LuckinBaseUIKit/UIView/CJShakeAction/**/*.{h,m}"
  	end

  	ss.subspec 'CJPopupAction' do |sss|
      sss.source_files = "LuckinBaseUIKit/UIView/CJPopupAction/**/*.{h,m}"
  	end

  	ss.subspec 'CJGestureRecognizer' do |sss|
      sss.source_files = "LuckinBaseUIKit/UIView/CJGestureRecognizer/**/*.{h,m}"
  	end

    ss.subspec 'CJAnimation' do |sss|
      sss.source_files = "LuckinBaseUIKit/UIView/CJAnimation/**/*.{h,m}"
    end
  end

  # UIWindow
  s.subspec 'UIWindow' do |ss|
    ss.source_files = "LuckinBaseUIKit/UIWindow/**/*.{h,m}"
  end

  s.subspec 'UIViewController' do |ss|
    ss.source_files = "LuckinBaseUIKit/UIViewController/**/*.{h,m}"
    ss.resources = "LuckinBaseUIKit/UIViewController/Resources/**/*.{png}"
  end

  s.subspec 'UIButton' do |ss|
    ss.source_files = "LuckinBaseUIKit/UIButton/**/*.{h,m}"
  end

  s.subspec 'UITextField' do |ss|
    ss.source_files = "LuckinBaseUIKit/UITextField/**/*.{h,m}"
    ss.dependency "LuckinBaseUIKit/UIView/CJPopupAction"
  end

  s.subspec 'UILabel' do |ss|
    ss.source_files = "LuckinBaseUIKit/UILabel/**/*.{h,m}"
  end

  s.subspec 'CJTextView' do |ss|
    ss.source_files = "LuckinBaseUIKit/CJTextView/**/*.{h,m}"
    # ss.resources = "LuckinBaseUIKit/CJTextView/**/*.{png,xib}"
  end

  s.subspec 'CJSlider' do |ss|
    # ss.source_files = "LuckinBaseUIKit/CJSlider/*.{h,m}", "LuckinBaseUIKit/CJSlider/CJAdsorbModel/**/*.{h,m}"
    ss.source_files = "LuckinBaseUIKit/CJSlider/**/*.{h,m}"
  end
  
  s.subspec 'UIToolbar' do |ss|
    ss.source_files = "LuckinBaseUIKit/UIToolbar/**/*.{h,m}"
    ss.dependency "LuckinBaseUIKit/UIImage"
  end

  s.subspec 'CJSearchBar' do |ss|
    ss.source_files = "LuckinBaseUIKit/CJSearchBar/**/*.{h,m}"
  end


  # 与 UIScrollView 相关的基础类
  s.subspec 'UIScrollView' do |ss|
    ss.subspec 'CJKeyboardAvoiding' do |sss|
      sss.source_files = "LuckinBaseUIKit/UIScrollView/CJKeyboardAvoiding/**/*.{h,m}"
    end
  end

  # 与 UITableView 相关的基础类
  s.subspec 'CJBaseTableViewCell' do |ss|
    ss.source_files = "LuckinBaseUIKit/CJBaseTableViewCell/**/*.{h,m}"
    ss.resources = "LuckinBaseUIKit/CJBaseTableViewCell/**/*.{png}"
    ss.dependency "LuckinBaseUIKit/UIButton"
  end

  s.subspec 'CJBaseTableViewHeaderFooterView' do |ss|
    ss.source_files = "LuckinBaseUIKit/CJBaseTableViewHeaderFooterView/**/*.{h,m}"
  end


  s.subspec 'CJToast' do |ss|
    ss.source_files = "LuckinBaseUIKit/CJToast/**/*.{h,m}"
    ss.resources = "LuckinBaseUIKit/CJToast/**/*.{png,xib}"
    #多个依赖就写多行
    ss.dependency 'MBProgressHUD'
  end
  
  s.subspec 'CJAlert' do |ss|
    ss.source_files = "LuckinBaseUIKit/CJAlert/**/*.{h,m}"
    #多个依赖就写多行
    ss.dependency 'Masonry'
    ss.dependency 'LuckinBaseUIKit/UIView/CJPopupAction'
  end

  s.subspec 'CJActionSheet' do |ss|
    ss.source_files = "LuckinBaseUIKit/CJActionSheet/**/*.{h,m}"
    #多个依赖就写多行
    ss.dependency 'Masonry'
    ss.dependency 'LuckinBaseUIKit/UIView/CJPopupAction'
  end

  s.subspec 'CJProgressHUD' do |ss|
    ss.source_files = "LuckinBaseUIKit/CJProgressHUD/**/*.{h,m}"
    #多个依赖就写多行
    ss.dependency 'Masonry'
    ss.dependency 'lottie-ios', '~> 2.5.3'
  end



end
