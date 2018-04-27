Pod::Spec.new do |s|
#验证方法：pod lib lint CJBaseUIKit.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJBaseUIKit"
  s.version      = "0.2.0"
  s.summary      = "自定义的基础UI"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                  *、UIView 之CJPopupAction： UIView的类别，用来实现UIView弹出popupView的一个Uiew的类别
                  *、CJImageView(包含CJBadgeImageView),用于设置imageView的title和badge;
                  *、UITextField：包含文本框类别及新的自定义文本框
                  *、CJTextView：类似微信文本输入框实现
                  *、已在CJMJRefreshComponent中包含pod 'MJRefresh', '~> 3.1.12'
                  *、UIColor+CJHex：用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
                  *、UIImage+CJCategory：
                  *、CJSlider
                  #、CJBaseScrollView：自定义的基础滚动视图
                  1、CJBaseTableViewCell：基础的TableViewCell;
                  2、CJBaseCollectionViewCell：基础的CollectionViewCell;
                  3、MyEqualCellSizeCollectionView：一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)
                  4、CJOpenCollectionView：可展开的集合视图

                   A longer description of CJPopupAction in Markdown format.

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

  s.platform     = :ios, "7.0"
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseUIKit_0.2.0" }
  s.source_files  = "CJBaseUIKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"


  s.subspec 'UIColor+CJCategory' do |ss|
    ss.source_files = "CJBaseUIKit/UIColor+CJCategory/**/*.{h,m}"
  end

  s.subspec 'UIImage+CJCategory' do |ss|
    ss.source_files = "CJBaseUIKit/UIImage+CJCategory/**/*.{h,m}"
  end






  s.subspec 'UIViewController' do |ss|
    ss.source_files = "CJBaseUIKit/UIViewController/**/*.{h,m}"
    ss.resources = "CJBaseUIKit/UIViewController/**/*.{png,xib}"
  end

  s.subspec 'UINavigationBar+CJCategory' do |ss|
    ss.source_files = "CJBaseUIKit/UINavigationBar+CJCategory/**/*.{h,m}"
  end





  

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

  s.subspec 'UIWindow' do |ss|
    ss.source_files = "CJBaseUIKit/UIWindow/**/*.{h,m}"
  end

  s.subspec 'UIButton+CJCategory' do |ss|
    ss.source_files = "CJBaseUIKit/UIButton+CJCategory/**/*.{h,m}"
  end

  s.subspec 'CJImageView' do |ss|
    ss.source_files = "CJBaseUIKit/CJImageView/**/*.{h,m}"
    # ss.resources = "CJBaseUIKit/CJImageView/**/*.{png,xib}"
  end

  s.subspec 'UITextField' do |ss|
    ss.source_files = "CJBaseUIKit/UITextField/**/*.{h,m}"
  end

  s.subspec 'CJTextView' do |ss|
    ss.source_files = "CJBaseUIKit/CJTextView/**/*.{h,m}"
    # ss.resources = "CJBaseUIKit/CJTextView/**/*.{png,xib}"
  end
  
  s.subspec 'UIToolbar' do |ss|
    ss.source_files = "CJBaseUIKit/UIToolbar/**/*.{h,m}"
    # ss.resources = "CJBaseUIKit/UIToolbar/**/*.{png,xib}"
  end

  s.subspec 'CJScrollView' do |ss|
    ss.source_files = "CJBaseUIKit/CJScrollView/**/*.{h,m}"
    # ss.resources = "CJBaseUIKit/CJScrollView/**/*.{png,xib}"
  end





  s.subspec 'CJTableView' do |ss|
    ss.subspec 'CJBaseTableViewCell' do |sss|
      sss.source_files = "CJBaseUIKit/CJBaseScrollView/CJTableView/CJBaseTableViewCell/**/*.{h,m}"
      sss.resources = "CJBaseUIKit/CJBaseScrollView/CJTableView/CJBaseTableViewCell/**/*.{png}"
      sss.dependency "CJBaseUIKit/CJImageView"
    end

    ss.subspec 'CJBaseTableViewHeaderFooterView' do |sss|
      sss.source_files = "CJBaseUIKit/CJBaseScrollView/CJTableView/CJBaseTableViewHeaderFooterView/**/*.{h,m}"
    end

  end

  s.subspec 'CJCollectionView' do |ss|
    ss.subspec 'CJBaseCollectionViewCell' do |sss|
      sss.source_files = "CJBaseUIKit/CJBaseScrollView/CJCollectionView/CJBaseCollectionViewCell/**/*.{h,m}"
    end

    ss.subspec 'CJCollectionViewLayout' do |sss|
      sss.source_files = "CJBaseUIKit/CJBaseScrollView/CJCollectionView/CJCollectionViewLayout/**/*.{h,m}"
    end

    # 各种集合视图
    # 一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)
    ss.subspec 'MyEqualCellSizeCollectionView' do |sss|
      sss.source_files = "CJBaseUIKit/CJBaseScrollView/CJCollectionView/MyEqualCellSizeCollectionView/**/*.{h,m}"
    end

    # 可展开的集合视图
    ss.subspec 'CJOpenCollectionView' do |sss|
      sss.source_files = "CJBaseUIKit/CJBaseScrollView/CJCollectionView/CJOpenCollectionView/**/*.{h,m}"
    end

  end





  s.subspec 'CJSlider' do |ss|
    # ss.source_files = "CJBaseUIKit/CJSlider/*.{h,m}", "CJBaseUIKit/CJSlider/CJAdsorbModel/**/*.{h,m}"
    ss.source_files = "CJBaseUIKit/CJSlider/**/*.{h,m}"
  end
  




  s.subspec 'CJRefreshView' do |ss|
    ss.source_files = "CJBaseUIKit/CJRefreshView/**/*.{h,m}"
    # ss.resources = "CJBaseUIKit/CJRefreshView/**/*.{png,xib}"
  end

  s.subspec 'CJMJRefreshComponent' do |ss|
    ss.source_files = "CJBaseUIKit/CJMJRefreshComponent/**/*.{h,m}"
    ss.resources = "CJBaseUIKit/CJMJRefreshComponent/**/*.{png,xib}"

    #多个依赖就写多行
    #ss.dependency 'Masonry'
    ss.dependency 'MJRefresh'
  end

  
  s.subspec 'WebView' do |ss|
    ss.source_files = "CJBaseUIKit/WebView/**/*.{h,m}"
    # ss.resources = "CJBaseUIKit/WebView/**/*.{png,xib}"

    ss.dependency 'NJKWebViewProgress'
    ss.dependency 'SVProgressHUD'
  end


  s.subspec 'CJToast' do |ss|
    ss.source_files = "CJBaseUIKit/CJToast/**/*.{h,m}"
    ss.resources = "CJBaseUIKit/CJToast/**/*.{png,xib}"

    #多个依赖就写多行
    ss.dependency 'MBProgressHUD'
  end

  s.subspec 'CJAlert' do |ss|
    ss.source_files = "CJBaseUIKit/CJAlert/**/*.{h,m}"

    #多个依赖就写多行
    ss.dependency 'Masonry'
    ss.dependency 'CJBaseUIKit/UIView/CJPopupAction'
  end



end
