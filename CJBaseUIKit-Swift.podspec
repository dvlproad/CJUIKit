  # pod的本地索引文件：~/Library/Caches/CocoaPods/search_index.json
  # pod的owner操作：https://www.jianshu.com/p/a9b8c2a1f3cf

  # 验证方法：pod lib lint CJBaseUIKit-Swift.podspec --allow-warnings --use-libraries --verbose
  # 上传方法：pod trunk push CJBaseUIKit-Swift.podspec --allow-warnings --use-libraries --verbose

Pod::Spec.new do |s|
  s.name         = "CJBaseUIKit-Swift"
  s.version      = "0.0.2"
  s.summary      = "自定义的基础UI"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 自定义的基础UI，可按需独立引入：
                 • CJBaseUIKit-Swift/String - 字符串：获取字符串的方法
                 • CJBaseUIKit-Swift/Color - 颜色：用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
                 • CJBaseUIKit-Swift/UIView - UIView
                 • CJBaseUIKit-Swift/UIView/adapt - 自适应宽\高\字体等
                 • CJBaseUIKit-Swift/UIView/as - SwiftUI 与 UIKit 互转的方法
                 • CJBaseUIKit-Swift/UIView/appear - 生命周期
                 • CJBaseUIKit-Swift/UIView/CJPopupAction - 视图弹窗：UIView的类别，用来实现UIView弹出popupView的一个Uiew的类别
                 • CJBaseUIKit-Swift/CJAlert - Alert

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

  s.platform     = :ios, "10.0"
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseUIKit-Swift_0.0.2" }
  # s.source_files  = "CJBaseUIKit-Swift/*.{h}"

  s.frameworks = "UIKit"
  s.swift_version = '5.0'

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "CJBaseUIKit-Swift/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  # s.dependency 'Masonry'

  # 字符串：获取字符串的方法
  s.subspec 'String' do |ss|
    ss.source_files = "CJBaseUIKit-Swift/String/**/*.{swift}"
  end

  # 颜色：用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
  s.subspec 'Color' do |ss|
    ss.source_files = "CJBaseUIKit-Swift/Color/**/*.{swift}"
    ss.dependency "CJBaseUIKit-Swift/String"
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

    # 自适应宽\高\字体等
    ss.subspec 'adapt' do |sss|
      sss.source_files = "CJBaseUIKit-Swift/UIView/adapt/**/*.{swift}"
    end

    # SwiftUI 与 UIKit 互转的方法
    ss.subspec 'as' do |sss|
      sss.source_files = "CJBaseUIKit-Swift/UIView/as/**/*.{swift}"
    end

    # 生命周期
    ss.subspec 'appear' do |sss|
      sss.source_files = "CJBaseUIKit-Swift/UIView/appear/**/*.{swift}"
    end

    # 视图拖动
   #  ss.subspec 'CJDragAction' do |sss|
   #    sss.source_files = "CJBaseUIKit-Swift/UIView/CJDragAction/**/*.{h,m}"
  	# end

    # 视图抖动
  	# ss.subspec 'CJShakeAction' do |sss|
   #    sss.source_files = "CJBaseUIKit-Swift/UIView/CJShakeAction/**/*.{h,m}"
  	# end

  	# 视图弹窗：UIView的类别，用来实现UIView弹出popupView的一个Uiew的类别
  	ss.subspec 'CJPopupAction' do |sss|
      sss.source_files = "CJBaseUIKit-Swift/UIView/CJPopupAction/**/*.{swift}"
  	end

    # 视图手势
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


  # Alert
  # s.subspec 'CJAlert' do |ss|
  #   ss.source_files = "CJBaseUIKit-Swift/CJAlert/**/*.{swift}"
  #   #多个依赖就写多行
  #   ss.dependency 'SnapKit'
  #   ss.dependency 'CJBaseUIKit-Swift/UIView/CJPopupAction'
  #   ss.dependency 'CJBaseHelper/AuthorizationCJHelper'
  # end

  # s.subspec 'CJToast' do |ss|
  #   ss.source_files = "CJBaseUIKit-Swift/CJToast/**/*.{swift}"
  #   ss.resources = "CJBaseUIKit-Swift/CJToast/**/*.{png}"
  #   #多个依赖就写多行
  #   ss.dependency 'MBProgressHUD'
  # end


end
