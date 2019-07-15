Pod::Spec.new do |s|
  # 验证方法：pod lib lint CJBaseUIKit-Swift.podspec --allow-warnings --use-libraries --verbose
  # pod的本地索引文件：~/Library/Caches/CocoaPods/search_index.json
  s.name         = "CJBaseUIKit-Swift"
  s.version      = "0.4.7"
  s.summary      = "自定义的基础UI"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 - CJBaseUIKit-Swift/UIColor：颜色：用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
                 - CJBaseUIKit-Swift/UIImage：图片
                 - CJBaseUIKit-Swift/UINavigationBar：导航栏
                 - CJBaseUIKit-Swift/UIView：视图
                 - CJBaseUIKit-Swift/UIView/CJDragAction：视图拖动
                 - CJBaseUIKit-Swift/UIView/CJShakeAction：视图抖动
                 - CJBaseUIKit-Swift/UIView/CJPopupAction：视图弹窗：UIView的类别，用来实现UIView弹出popupView的一个Uiew的类别
                 - CJBaseUIKit-Swift/UIView/CJGestureRecognizer：视图手势
                 - CJBaseUIKit-Swift/UIWindow：窗口
                 - CJBaseUIKit-Swift/UIButton：按钮 及 CJBadgeButton
                 - CJBaseUIKit-Swift/UITextField：文本视图：包含文本框类别及新的自定义文本框
                 - CJBaseUIKit-Swift/CJTextView：文本视图：类似微信文本输入框实现
                 - CJBaseUIKit-Swift/UIToolbar：工具栏
                 - CJBaseUIKit-Swift/UIScrollView：滚动视图：含监听滚动视图的键盘
                 - CJBaseUIKit-Swift/CJBaseTableViewCell：基础的TableViewCell
                 - CJBaseUIKit-Swift/CJBaseTableViewHeaderFooterView：列表--HeaderFooterView
                 - CJBaseUIKit-Swift/CJSlider：滑块
                 - CJBaseUIKit-Swift/CJToast：Toast
                 - CJBaseUIKit-Swift/CJAlert：Alert
                 - CJBaseUIKit-Swift/UIViewController：自定义返回按钮

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
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseUIKit-Swift_0.4.7" }
  # s.source_files  = "CJBaseUIKit-Swift/*.{h}"

  s.frameworks = "UIKit"
  s.swift_version = '5.0'

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "CJBaseUIKit-Swift/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  # s.dependency 'Masonry'

  s.subspec 'UIColor' do |ss|
    ss.source_files = "CJBaseUIKit-Swift/UIColor/**/*.{swift}"
  end

  # s.subspec 'UIImage' do |ss|
  #   ss.source_files = "CJBaseUIKit-Swift/UIImage/**/*.{h,m}"
  # end


  # s.subspec 'UINavigationBar' do |ss|
  #   ss.source_files = "CJBaseUIKit-Swift/UINavigationBar/**/*.{h,m}"
  # end





  # UIView
  s.subspec 'UIView' do |ss|
    # ss.source_files = "CJBaseUIKit-Swift/UIView/*.{swift}"

   #  ss.subspec 'CJDragAction' do |sss|
   #    sss.source_files = "CJBaseUIKit-Swift/UIView/CJDragAction/**/*.{h,m}"
  	# end

  	# ss.subspec 'CJShakeAction' do |sss|
   #    sss.source_files = "CJBaseUIKit-Swift/UIView/CJShakeAction/**/*.{h,m}"
  	# end

  	ss.subspec 'CJPopupAction' do |sss|
      sss.source_files = "CJBaseUIKit-Swift/UIView/CJPopupAction/**/*.{swift}"
  	end

  	# ss.subspec 'CJGestureRecognizer' do |sss|
   #    sss.source_files = "CJBaseUIKit-Swift/UIView/CJGestureRecognizer/**/*.{h,m}"
  	# end

  end

  # # UIWindow
  # s.subspec 'UIWindow' do |ss|
  #   ss.source_files = "CJBaseUIKit-Swift/UIWindow/**/*.{h,m}"
  # end

  # s.subspec 'UIViewController' do |ss|
  #   ss.source_files = "CJBaseUIKit-Swift/UIViewController/**/*.{h,m}"
  #   ss.resources = "CJBaseUIKit-Swift/UIViewController/Resources/**/*.{png}"
  # end

  # s.subspec 'UIButton' do |ss|
  #   ss.source_files = "CJBaseUIKit-Swift/UIButton/**/*.{h,m}"
  # end

  # s.subspec 'UITextField' do |ss|
  #   ss.source_files = "CJBaseUIKit-Swift/UITextField/**/*.{h,m}"
  #   ss.dependency "CJBaseUIKit-Swift/UIView/CJPopupAction"
  # end

  # s.subspec 'CJTextView' do |ss|
  #   ss.source_files = "CJBaseUIKit-Swift/CJTextView/**/*.{h,m}"
  #   # ss.resources = "CJBaseUIKit-Swift/CJTextView/**/*.{png,xib}"
  # end

  # s.subspec 'CJSlider' do |ss|
  #   # ss.source_files = "CJBaseUIKit-Swift/CJSlider/*.{h,m}", "CJBaseUIKit-Swift/CJSlider/CJAdsorbModel/**/*.{h,m}"
  #   ss.source_files = "CJBaseUIKit-Swift/CJSlider/**/*.{h,m}"
  # end
  
  # s.subspec 'UIToolbar' do |ss|
  #   ss.source_files = "CJBaseUIKit-Swift/UIToolbar/**/*.{h,m}"
  #   ss.dependency "CJBaseUIKit-Swift/UIImage"
  # end


  # # 与 UIScrollView 相关的基础类
  # s.subspec 'UIScrollView' do |ss|
  #   ss.subspec 'CJKeyboardAvoiding' do |sss|
  #     sss.source_files = "CJBaseUIKit-Swift/UIScrollView/CJKeyboardAvoiding/**/*.{h,m}"
  #   end
  # end

  # # 与 UITableView 相关的基础类
  # s.subspec 'CJBaseTableViewCell' do |ss|
  #   ss.source_files = "CJBaseUIKit-Swift/CJBaseTableViewCell/**/*.{h,m}"
  #   ss.resources = "CJBaseUIKit-Swift/CJBaseTableViewCell/**/*.{png}"
  #   ss.dependency "CJBaseUIKit-Swift/UIButton"
  # end

  # s.subspec 'CJBaseTableViewHeaderFooterView' do |ss|
  #   ss.source_files = "CJBaseUIKit-Swift/CJBaseTableViewHeaderFooterView/**/*.{h,m}"
  # end


  s.subspec 'CJAlert' do |ss|
    ss.source_files = "CJBaseUIKit-Swift/CJAlert/**/*.{swift}"
    #多个依赖就写多行
    ss.dependency 'SnapKit'
    ss.dependency 'CJBaseUIKit-Swift/UIView/CJPopupAction'
  end

  # s.subspec 'CJToast' do |ss|
  #   ss.source_files = "CJBaseUIKit-Swift/CJToast/**/*.{swift}"
  #   ss.resources = "CJBaseUIKit-Swift/CJToast/**/*.{png}"
  #   #多个依赖就写多行
  #   ss.dependency 'MBProgressHUD'
  # end


end
