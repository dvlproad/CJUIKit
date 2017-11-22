Pod::Spec.new do |s|
  s.name         = "CJBaseUtil"
  s.version      = "0.1.2"
  s.summary      = "自定义的基础工具类"
  s.homepage     = "https://github.com/dvlproad/CJFoundation"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                  1、CJDataUtil：包含搜索、排序等数据处理工具类

                   A longer description of CJBaseUtil in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/dvlproad/CJFoundation.git", :tag => "CJBaseUtil_0.1.2" }
  # s.source_files  = "CJFoundation/*.{h,m}"
  # s.resources = "CJFoundation/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  s.subspec 'CJApp' do |ss|
    ss.source_files = "CJBaseUtil/CJApp/**/*.{h,m}"
  end

  s.subspec 'CJDevice' do |ss|
    ss.source_files = "CJBaseUtil/CJDevice/**/*.{h,m}"
  end

  s.subspec 'CJLog' do |ss|
    ss.source_files = "CJBaseUtil/CJLog/**/*.{h,m}"
  end

  # 包含搜索、排序等数据处理工具类
  s.subspec 'CJDataUtil' do |ss|
   ss.source_files = "CJBaseUtil/CJDataUtil/**/*.{h,m}"
  end

  s.subspec 'UIUtil' do |ss|
    ss.source_files = "CJBaseUtil/UIUtil/**/*.{h,m}"
  end

  s.subspec 'CJWebUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJWebUtil/**/*.{h,m}"
    ss.frameworks = 'WebKit'
  end

end
