Pod::Spec.new do |s|
  # 验证方法：pod lib lint CJBaseOverlayKit.podspec --allow-warnings --use-libraries --verbose
  # pod的本地索引文件：~/Library/Caches/CocoaPods/search_index.json
  s.name         = "CJBaseOverlayKit"
  s.version      = "0.2.0"
  s.summary      = "自定义的基础悬浮UI(Toast、Alert、ActionSheet、HUD)"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 - CJBaseOverlayKit/UIView：视图
                 - CJBaseOverlayKit/UIView/CJDragAction：视图拖动
                 - CJBaseOverlayKit/UIView/CJShakeAction：视图抖动
                 - CJBaseOverlayKit/UIView/CJPopupAction：视图弹窗：UIView的类别，用来实现UIView弹出popupView的一个Uiew的类别
                 - CJBaseOverlayKit/UIView/CJGestureRecognizer：视图手势
                 - CJBaseOverlayKit/UIWindow：窗口
                 - CJBaseOverlayKit/CJToast：Toast
                 - CJBaseOverlayKit/CJAlert：Alert

                   A longer description of CJBaseOverlayKit in Markdown format.

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
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseOverlayKit_0.2.0" }
  s.source_files  = "CJBaseOverlayKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "CJBaseOverlayKit/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  # s.dependency 'Masonry'

  # Theme 主题
  s.subspec 'CJBaseOverlayTheme' do |ss|
    ss.source_files = "CJBaseOverlayKit/CJBaseOverlayTheme/**/*.{h,m}"
  end


  # Toast
  s.subspec 'CJToast' do |ss|
    ss.source_files = "CJBaseOverlayKit/CJToast/**/*.{h,m}"
    ss.resources = "CJBaseOverlayKit/CJToast/**/*.{png,xib}"
    #多个依赖就写多行
    ss.dependency 'MBProgressHUD'
    ss.dependency 'CJBaseOverlayKit/CJBaseOverlayTheme'
  end
  
  # Alert
  s.subspec 'CJAlert' do |ss|
    ss.source_files = "CJBaseOverlayKit/CJAlert/**/*.{h,m}"
    #多个依赖就写多行
    ss.dependency 'Masonry'
    # ss.dependency 'CJBaseOverlayKit/UIView/CJPopupAction'
    ss.dependency 'CJBaseOverlayKit/CJBaseOverlayTheme'
  end

  # ActionSheet
  s.subspec 'CJActionSheet' do |ss|
    ss.source_files = "CJBaseOverlayKit/CJActionSheet/**/*.{h,m}"
    #多个依赖就写多行
    ss.dependency 'Masonry'
    # ss.dependency 'CJBaseUIKit/UIView/CJPopupAction'
    ss.dependency 'CJBaseOverlayKit/CJBaseOverlayTheme'
  end

  # HUD
  s.subspec 'CJProgressHUD' do |ss|
    ss.source_files = "CJBaseOverlayKit/CJProgressHUD/**/*.{h,m}"
    #多个依赖就写多行
    ss.dependency 'Masonry'
    ss.dependency 'lottie-ios', '~> 2.5.3'
    ss.dependency 'CJBaseOverlayKit/CJBaseOverlayTheme'
  end



end
