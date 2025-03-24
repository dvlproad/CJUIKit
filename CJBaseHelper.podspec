Pod::Spec.new do |s|
  # 验证方法：pod lib lint CJBaseHelper.podspec --allow-warnings --use-libraries --verbose
  # 上传方法：pod trunk push CJBaseHelper.podspec --allow-warnings --use-libraries --verbose
  # pod的本地索引文件：~/Library/Caches/CocoaPods/search_index.json
  # pod的owner操作：https://www.jianshu.com/p/a9b8c2a1f3cf
  s.name         = "CJBaseHelper"
  s.version      = "0.1.8"
  s.summary      = "自定义的基础帮助类"
  s.homepage     = "https://github.com/dvlproad/CJUIKit.git"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                  - CJBaseHelper/DeviceCJHelper：设备信息获取帮助类
                  - CJBaseHelper/NSObjectCJHelper：对象判空帮助类
                  - CJBaseHelper/HookCJHelper：Hook帮助类
                  - CJBaseHelper/UIViewControllerCJHelper：视图控制器帮助类：包含获取当前显示的视图控制器和通过视图找到它所在的视图控制器等
                  - CJBaseHelper/NSDateFormatterCJHelper：NSDateFormatter帮助类
                  - CJBaseHelper/NSCalendarCJHelper：NSCalendar帮助类
                  - CJBaseHelper/NSOperationQueueHelper：多任务处理
                  - CJBaseHelper/WebCJHelper：Web帮助类，包含清除缓存问题等
                  - CJBaseHelper/AuthorizationCJHelper：权限判断及系统设置打开
                  - CJBaseHelper/ServerCJHelper：服务器帮助类（服务器时间、服务器敏感词）
                  - CJBaseHelper/AppInfoCJHelper：app的版本号信息
                  

                   A longer description of CJBaseHelper in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseHelper_0.1.8" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  # Device 设备信息
  s.subspec 'DeviceCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/CJBaseHelper/DeviceCJHelper/**/*.{h,m}"
  end

  # NSObject
  s.subspec 'NSObjectCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/CJBaseHelper/NSObjectCJHelper/**/*.{h,m}"
  end

  # Hook
  s.subspec 'HookCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/CJBaseHelper/HookCJHelper/*.{h,m}"
  end

  # UIViewController
  s.subspec 'UIViewControllerCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/CJBaseHelper/UIViewControllerCJHelper/**/*.{h,m}"
  end

  # NSDateFormatter
  s.subspec 'NSDateFormatterCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/CJBaseHelper/NSDateFormatterCJHelper/**/*.{h,m}"
  end

  # NSCalendar
  s.subspec 'NSCalendarCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/CJBaseHelper/NSCalendarCJHelper/**/*.{h,m}"
  end

  # Web
  s.subspec 'WebCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/CJBaseHelper/WebCJHelper/**/*.{h,m}"
    ss.frameworks = 'WebKit'
  end

  # NSOperationQueue 搜索功能常常需要的多线程处理工具类
  s.subspec 'NSOperationQueueCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/CJBaseHelper/NSOperationQueueCJHelper/**/*.{h,m}"
  end

  # 权限判断
  s.subspec 'AuthorizationCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/CJBaseHelper/AuthorizationCJHelper/**/*.{h,m}"
    ss.frameworks = 'AVFoundation', 'Photos', 'CoreLocation'
  end

  # 服务器帮助类（服务器时间、服务器敏感词）
  s.subspec 'ServerCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/CJBaseHelper/ServerCJHelper/**/*.{h,m}"
  end

  # app的版本号信息
  s.subspec 'AppInfoCJHelper' do |ss|
    ss.source_files = "CJBaseHelper/CJBaseHelper/AppInfoCJHelper/**/*.{h,m}"
  end
  

end
