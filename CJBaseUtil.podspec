Pod::Spec.new do |s|
  s.name         = "CJBaseUtil"
  s.version      = "0.2.1"
  s.summary      = "自定义的基础工具类"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                  1、CJDataUtil：包含搜索、排序等数据处理工具类
                  2、CJDateUtil：日期工具
                  3、CJKeyboardUtil：键盘工具
                  4、CJLog：日志工具
                  5、CJWebUtil：Web工具
                  6、CJDevice：设备信息工具
                  7、CJApp：App信息工具

                   A longer description of CJBaseUtil in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseUtil_0.2.1" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
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

  # 日期工具
  s.subspec 'CJDateUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJDateUtil/**/*.{h,m}"
  end

  # 键盘工具
  s.subspec 'CJKeyboardUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJKeyboardUtil/**/*.{h,m}"
  end

  s.subspec 'UIUtil' do |ss|
    ss.source_files = "CJBaseUtil/UIUtil/**/*.{h,m}"
  end

  s.subspec 'CJWebUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJWebUtil/**/*.{h,m}"
    ss.frameworks = 'WebKit'
  end

end
