Pod::Spec.new do |s|
  #验证方法：pod lib lint CJBaseHelper.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJBaseHelper"
  s.version      = "0.0.5"
  s.summary      = "自定义的基础帮助类"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                  *、DeviceCJHelper：设备信息工具
  				        *、NSObjectHelper：对象判空等帮助类
                  *、UIViewControllerHelper：视图控制器帮助类
                  *、WebCJHelper：Web工具
                  *、NSOperationQueueHelper：任务队列帮助类
                  

                   A longer description of CJBaseHelper in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseHelper_0.0.5" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  # 设备信息
  s.subspec 'DeviceCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/DeviceCJHelper/**/*.{h,m}"
  end

  s.subspec 'NSObjectCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/NSObjectCJHelper/**/*.{h,m}"
  end

  s.subspec 'UIViewControllerCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/UIViewControllerCJHelper/**/*.{h,m}"
  end

  # Web
  s.subspec 'WebCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/WebCJHelper/**/*.{h,m}"
    ss.frameworks = 'WebKit'
  end

  # 搜索功能常常需要的多线程处理工具类
  s.subspec 'NSOperationQueueCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/NSOperationQueueCJHelper/**/*.{h,m}"
  end

  

end
