Pod::Spec.new do |s|
  #验证方法：pod lib lint CJBaseHelper.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJBaseHelper"
  s.version      = "0.0.2"
  s.summary      = "自定义的基础帮助类"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
  				  *、NSStringHelper：字符串判空等帮助类
                  *、UIViewControllerHelper：视图控制器帮助类
                  *、NSOperationQueueHelper：任务队列帮助类
                  

                   A longer description of CJBaseHelper in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseHelper_0.0.2" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  s.subspec 'NSStringHelper' do |ss|
    ss.source_files = "CJBaseHelper/NSStringHelper/**/*.{h,m}"
  end

  s.subspec 'UIViewControllerHelper' do |ss|
    ss.source_files = "CJBaseHelper/UIViewControllerHelper/**/*.{h,m}"
  end

  # 搜索功能常常需要的多线程处理工具类
  s.subspec 'NSOperationQueueHelper' do |ss|
    ss.source_files = "CJBaseHelper/NSOperationQueueHelper/**/*.{h,m}"
  end

  

end
