Pod::Spec.new do |s|

  s.name         = "CJBaseUIKit"
  s.version      = "0.1.3"
  s.summary      = "自定义的基础UI"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
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
                  5、CJDataScrollView：带数据的列表视图或集合视图(常用于搜索)

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

  s.author   = { "lichq" => "" }

  s.platform     = :ios, "7.0"
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseUIKit_0.1.3" }
  s.source_files  = "CJUIKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"


  s.subspec 'UIColor+CJCategory' do |ss|
    ss.source_files = "CJUIKit/UIColor+CJCategory/**/*.{h,m}"
  end

  s.subspec 'UIImage+CJCategory' do |ss|
    ss.source_files = "CJUIKit/UIImage+CJCategory/**/*.{h,m}"
  end






  s.subspec 'UIViewController' do |ss|
    ss.source_files = "CJUIKit/UIViewController/**/*.{h,m}"
    ss.resources = "CJUIKit/UIViewController/**/*.{png,xib}"
  end

  s.subspec 'UINavigationBar+CJCategory' do |ss|
    ss.source_files = "CJUIKit/UINavigationBar+CJCategory/**/*.{h,m}"
  end





  

  s.subspec 'UIView+CJCategory' do |ss|
    ss.source_files = "CJUIKit/UIView+CJCategory/**/*.{h,m}"
  end

  s.subspec 'UIWindow' do |ss|
    ss.source_files = "CJUIKit/UIWindow/**/*.{h,m}"
  end

  s.subspec 'UIButton+CJCategory' do |ss|
    ss.source_files = "CJUIKit/UIButton+CJCategory/**/*.{h,m}"
  end

  s.subspec 'CJImageView' do |ss|
    ss.source_files = "CJUIKit/CJImageView/**/*.{h,m}"
    # ss.resources = "CJUIKit/CJImageView/**/*.{png,xib}"
  end

  s.subspec 'UITextField' do |ss|
    ss.source_files = "CJUIKit/UITextField/**/*.{h,m}"
  end

  s.subspec 'CJTextView' do |ss|
    ss.source_files = "CJUIKit/CJTextView/**/*.{h,m}"
    # ss.resources = "CJUIKit/CJTextView/**/*.{png,xib}"
  end
  
  s.subspec 'UIToolbar' do |ss|
    ss.source_files = "CJUIKit/UIToolbar/**/*.{h,m}"
    # ss.resources = "CJUIKit/UIToolbar/**/*.{png,xib}"
  end

  s.subspec 'CJScrollView' do |ss|
    ss.source_files = "CJUIKit/CJScrollView/**/*.{h,m}"
    # ss.resources = "CJUIKit/CJScrollView/**/*.{png,xib}"
  end





  s.subspec 'CJTableView' do |ss|
    ss.subspec 'CJBaseTableViewCell' do |sss|
      sss.source_files = "CJUIKit/CJBaseScrollView/CJTableView/CJBaseTableViewCell/**/*.{h,m}"
      sss.resources = "CJUIKit/CJBaseScrollView/CJTableView/CJBaseTableViewCell/**/*.{png}"
      sss.dependency "CJBaseUIKit/CJImageView"
    end

    ss.subspec 'CJBaseTableViewHeaderFooterView' do |sss|
      sss.source_files = "CJUIKit/CJBaseScrollView/CJTableView/CJBaseTableViewHeaderFooterView/**/*.{h,m}"
    end

  end

  s.subspec 'CJCollectionView' do |ss|
    ss.subspec 'CJBaseCollectionViewCell' do |sss|
      sss.source_files = "CJUIKit/CJBaseScrollView/CJCollectionView/CJBaseCollectionViewCell/**/*.{h,m}"
    end

    ss.subspec 'CJCollectionViewLayout' do |sss|
      sss.source_files = "CJUIKit/CJBaseScrollView/CJCollectionView/CJCollectionViewLayout/**/*.{h,m}"
    end

    # 各种集合视图
    # 一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)
    ss.subspec 'MyEqualCellSizeCollectionView' do |sss|
      sss.source_files = "CJUIKit/CJBaseScrollView/CJCollectionView/MyEqualCellSizeCollectionView/**/*.{h,m}"
    end

    # 可展开的集合视图
    ss.subspec 'CJOpenCollectionView' do |sss|
      sss.source_files = "CJUIKit/CJBaseScrollView/CJCollectionView/CJOpenCollectionView/**/*.{h,m}"
    end

  end

  # 带数据的列表视图或集合视图(常用于搜索)
  s.subspec 'CJDataScrollView' do |ss|
    ss.source_files = "CJUIKit/CJBaseScrollView/CJDataScrollView/**/*.{h,m}"

    ss.dependency 'CJBaseUIKit/CJCollectionView/MyEqualCellSizeCollectionView'

    # MySearchEqualCellSizeCollectionView需要额外依赖的库
    ss.dependency 'CJBaseUtil/CJDataUtil', '~> 0.1.1'
    ss.dependency 'NSOperationQueueUtil', '~> 0.0.1'
  end









  s.subspec 'CJSlider' do |ss|
    # ss.source_files = "CJUIKit/CJSlider/*.{h,m}", "CJUIKit/CJSlider/CJAdsorbModel/**/*.{h,m}"
    ss.source_files = "CJUIKit/CJSlider/**/*.{h,m}"
  end
  




  s.subspec 'CJRefreshView' do |ss|
    ss.source_files = "CJUIKit/CJRefreshView/**/*.{h,m}"
    # ss.resources = "CJUIKit/CJRefreshView/**/*.{png,xib}"
  end

  s.subspec 'CJMJRefreshComponent' do |ss|
    ss.source_files = "CJUIKit/CJMJRefreshComponent/**/*.{h,m}"
    ss.resources = "CJUIKit/CJMJRefreshComponent/**/*.{png,xib}"

    #多个依赖就写多行
    #ss.dependency 'Masonry', '~> 1.0.2'
    ss.dependency 'MJRefresh'
  end





  s.subspec 'CJToast' do |ss|
    ss.source_files = "CJUIKit/CJToast/**/*.{h,m}"
    ss.resources = "CJUIKit/CJToast/**/*.{png,xib}"

    #多个依赖就写多行
    ss.dependency 'MBProgressHUD'
  end


  s.subspec 'CJManager' do |ss|
    ss.source_files = "CJUIKit/CJManager/**/*.{h,m}"
    #ss.resources = "CJUIKit/CJManager/**/*.{png,xib}"
  end




end
