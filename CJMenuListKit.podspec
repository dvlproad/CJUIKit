Pod::Spec.new do |s|
  #验证方法：pod lib lint CJMenuListKit.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJMenuListKit"
  s.version      = "0.1.0"
  s.summary      = "自定义的稍微复杂的UI"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 - CJMenuListKit：一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)
                 
                   A longer description of CJMenuListKit in Markdown format.

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
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJMenuListKit_0.1.0" }
  # s.source_files  = "CJMenuListKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"



  # 各种集合视图
  # 一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)
  # s.subspec 'CJMenuListKit' do |ss|
    s.source_files = "CJMenuListKit/**/*.{h,m}"

    s.dependency 'Masonry'
    s.dependency 'SDWebImage'
    s.dependency 'CJBaseUtil/CJDataUtil'
  # end

  # # 可展开的集合视图
  # s.subspec 'CJHomeCollectionView' do |ss|
  #   ss.source_files = "CJComplexUIKit/CJHomeCollectionView/**/*.{h,m}"
  #   ss.platform     = :ios, "9.0"

  #   ss.dependency 'Masonry'
  #   ss.dependency 'SDCycleScrollView'
  #   ss.dependency 'CJBaseUtil/CJDataUtil'
  # end


  





end
