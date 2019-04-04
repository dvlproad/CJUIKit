Pod::Spec.new do |s|
  # 验证方法：pod lib lint CJBaseUIKit.podspec --allow-warnings --use-libraries --verbose
  # pod的本地索引文件：~/Library/Caches/CocoaPods/search_index.json
  s.name         = "CJBaseUIKit"
  s.version      = "0.4.6"
  s.summary      = "自定义的基础UI"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 - CJBaseUIKit/UIColor：颜色：用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
                 - CJBaseUIKit/UIImage：图片
                 - CJBaseUIKit/UINavigationBar：导航栏
                 - CJBaseUIKit/UIView：视图
                 - CJBaseUIKit/UIView/CJDragAction：视图拖动
                 - CJBaseUIKit/UIView/CJShakeAction：视图抖动
                 - CJBaseUIKit/UIView/CJPopupAction：视图弹窗：UIView的类别，用来实现UIView弹出popupView的一个Uiew的类别
                 - CJBaseUIKit/UIView/CJGestureRecognizer：视图手势
                 - CJBaseUIKit/UIWindow：窗口
                 - CJBaseUIKit/UIButton：按钮 及 CJBadgeButton
                 - CJBaseUIKit/UITextField：文本视图：包含文本框类别及新的自定义文本框
                 - CJBaseUIKit/CJTextView：文本视图：类似微信文本输入框实现
                 - CJBaseUIKit/UIToolbar：工具栏
                 - CJBaseUIKit/UIScrollView：滚动视图：含监听滚动视图的键盘
                 - CJBaseUIKit/CJBaseTableViewCell：基础的TableViewCell
                 - CJBaseUIKit/CJBaseTableViewHeaderFooterView：列表--HeaderFooterView
                 - CJBaseUIKit/CJSlider：滑块
                 - CJBaseUIKit/CJToast：Toast
                 - CJBaseUIKit/CJAlert：Alert
                 - CJBaseUIKit/UIViewController：自定义返回按钮

                   A longer description of CJBaseUIKit in Markdown format.

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
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseUIKit_0.4.6" }
  s.source_files  = "CJBaseUIKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "CJBaseUIKit/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  # s.dependency 'Masonry'

  s.subspec 'UIColor' do |ss|
    ss.source_files = "CJBaseUIKit/UIColor/**/*.{h,m}"
  end

  s.subspec 'UIImage' do |ss|
    ss.source_files = "CJBaseUIKit/UIImage/**/*.{h,m}"
  end


  s.subspec 'UINavigationBar' do |ss|
    ss.source_files = "CJBaseUIKit/UINavigationBar/**/*.{h,m}"
  end





  # UIView
  s.subspec 'UIView' do |ss|
    ss.source_files = "CJBaseUIKit/UIView/*.{h,m}"

    ss.subspec 'CJDragAction' do |sss|
      sss.source_files = "CJBaseUIKit/UIView/CJDragAction/**/*.{h,m}"
  	end

  	ss.subspec 'CJShakeAction' do |sss|
      sss.source_files = "CJBaseUIKit/UIView/CJShakeAction/**/*.{h,m}"
  	end

  	ss.subspec 'CJPopupAction' do |sss|
      sss.source_files = "CJBaseUIKit/UIView/CJPopupAction/**/*.{h,m}"
  	end

  	ss.subspec 'CJGestureRecognizer' do |sss|
      sss.source_files = "CJBaseUIKit/UIView/CJGestureRecognizer/**/*.{h,m}"
  	end

  end

  # UIWindow
  s.subspec 'UIWindow' do |ss|
    ss.source_files = "CJBaseUIKit/UIWindow/**/*.{h,m}"
  end

  s.subspec 'UIViewController' do |ss|
    ss.source_files = "CJBaseUIKit/UIViewController/**/*.{h,m}"
    ss.resources = "CJBaseUIKit/UIViewController/Resources/**/*.{png}"
  end

  s.subspec 'UIButton' do |ss|
    ss.source_files = "CJBaseUIKit/UIButton/**/*.{h,m}"
  end

  s.subspec 'UITextField' do |ss|
    ss.source_files = "CJBaseUIKit/UITextField/**/*.{h,m}"
  end

  s.subspec 'CJTextView' do |ss|
    ss.source_files = "CJBaseUIKit/CJTextView/**/*.{h,m}"
    # ss.resources = "CJBaseUIKit/CJTextView/**/*.{png,xib}"
  end

  s.subspec 'CJSlider' do |ss|
    # ss.source_files = "CJBaseUIKit/CJSlider/*.{h,m}", "CJBaseUIKit/CJSlider/CJAdsorbModel/**/*.{h,m}"
    ss.source_files = "CJBaseUIKit/CJSlider/**/*.{h,m}"
  end
  
  s.subspec 'UIToolbar' do |ss|
    ss.source_files = "CJBaseUIKit/UIToolbar/**/*.{h,m}"
  end


  # 与 UIScrollView 相关的基础类
  s.subspec 'UIScrollView' do |ss|
    ss.subspec 'CJKeyboardAvoiding' do |sss|
      sss.source_files = "CJBaseUIKit/UIScrollView/CJKeyboardAvoiding/**/*.{h,m}"
    end
  end

  # 与 UITableView 相关的基础类
  s.subspec 'CJBaseTableViewCell' do |ss|
    ss.source_files = "CJBaseUIKit/CJBaseTableViewCell/**/*.{h,m}"
    ss.resources = "CJBaseUIKit/CJBaseTableViewCell/**/*.{png}"
    ss.dependency "CJBaseUIKit/UIButton"
  end

  s.subspec 'CJBaseTableViewHeaderFooterView' do |ss|
    ss.source_files = "CJBaseUIKit/CJBaseTableViewHeaderFooterView/**/*.{h,m}"
  end


  s.subspec 'CJAlert' do |ss|
    ss.source_files = "CJBaseUIKit/CJAlert/**/*.{h,m}"
    #多个依赖就写多行
    ss.dependency 'Masonry'
    ss.dependency 'CJBaseUIKit/UIView/CJPopupAction'
  end

  s.subspec 'CJToast' do |ss|
    ss.source_files = "CJBaseUIKit/CJToast/**/*.{h,m}"
    ss.resources = "CJBaseUIKit/CJToast/**/*.{png,xib}"
    #多个依赖就写多行
    ss.dependency 'MBProgressHUD'
  end



end
