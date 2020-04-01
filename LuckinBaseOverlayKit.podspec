Pod::Spec.new do |s|
  # 验证方法：pod lib lint LuckinBaseOverlayKit.podspec --allow-warnings --use-libraries --verbose
  # pod的本地索引文件：~/Library/Caches/CocoaPods/search_index.json
  s.name         = "LuckinBaseOverlayKit"
  s.version      = "0.2.1"
  s.summary      = "自定义的基础悬浮UI(Toast、Alert、ActionSheet、HUD)"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 - LuckinBaseOverlayKit/UIView：视图
                 - LuckinBaseOverlayKit/UIView/CJDragAction：视图拖动
                 - LuckinBaseOverlayKit/UIView/CJShakeAction：视图抖动
                 - LuckinBaseOverlayKit/UIView/CJPopupAction：视图弹窗：UIView的类别，用来实现UIView弹出popupView的一个Uiew的类别
                 - LuckinBaseOverlayKit/UIView/CJGestureRecognizer：视图手势
                 - LuckinBaseOverlayKit/UIWindow：窗口
                 - LuckinBaseOverlayKit/CJToast：Toast
                 - LuckinBaseOverlayKit/CJAlert：Alert

                   A longer description of LuckinBaseOverlayKit in Markdown format.

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
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "LuckinBaseOverlayKit_0.2.1" }
  s.source_files  = "LuckinBaseOverlayKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "LuckinBaseOverlayKit/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  # s.dependency 'Masonry'

  # Theme 主题
  s.subspec 'CJBaseOverlayTheme' do |ss|
    ss.source_files = "LuckinBaseOverlayKit/CJBaseOverlayTheme/**/*.{h,m}"
  end


  # Toast
  s.subspec 'CJToast' do |ss|
    ss.source_files = "LuckinBaseOverlayKit/CJToast/**/*.{h,m}"
    ss.resources = "LuckinBaseOverlayKit/CJToast/**/*.{png,xib}"
    #多个依赖就写多行
    ss.dependency 'MBProgressHUD'
    ss.dependency 'LuckinBaseOverlayKit/CJBaseOverlayTheme'
  end
  
  # Alert
  s.subspec 'CJAlert' do |ss|
    ss.source_files = "LuckinBaseOverlayKit/CJAlert/**/*.{h,m}"
    #多个依赖就写多行
    ss.dependency 'Masonry'
    # ss.dependency 'LuckinBaseOverlayKit/UIView/CJPopupAction'
    ss.dependency 'LuckinBaseOverlayKit/CJBaseOverlayTheme'
  end

  # ActionSheet
  s.subspec 'CJActionSheet' do |ss|
    ss.source_files = "LuckinBaseOverlayKit/CJActionSheet/**/*.{h,m}"
    #多个依赖就写多行
    ss.dependency 'Masonry'
    # ss.dependency 'CJBaseUIKit/UIView/CJPopupAction'
    ss.dependency 'LuckinBaseOverlayKit/CJBaseOverlayTheme'
  end

  # HUD
  s.subspec 'CJProgressHUD' do |ss|
    ss.source_files = "LuckinBaseOverlayKit/CJProgressHUD/**/*.{h,m}"
    #多个依赖就写多行
    ss.dependency 'Masonry'
    ss.dependency 'lottie-ios', '~> 2.5.3'
    ss.dependency 'LuckinBaseOverlayKit/CJBaseOverlayTheme'
    ss.dependency 'MBProgressHUD'
  end



end
