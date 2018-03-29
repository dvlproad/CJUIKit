Pod::Spec.new do |s|
  s.name         = "CJBaseUtil"
  s.version      = "0.2.5"
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
                  8、CJManager：其他各种工具类
                  9、CJPinyinHelper：拼音相关工具

                   A longer description of CJBaseUtil in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseUtil_0.2.5" }
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

  # 搜索功能常常需要的多线程处理工具类
  s.subspec 'NSOperationQueueUtil' do |ss|
   ss.source_files = "CJBaseUtil/NSOperationQueueUtil/**/*.{h,m}"
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


  s.subspec 'CJManager' do |ss|
  	# AppDelegate瘦身
    ss.subspec 'CJModuleManager' do |sss|
      sss.source_files = "CJBaseUtil/CJManager/CJModuleManager/**/*.{h,m}"
      #sss.resources = "CJBaseUtil/CJManager/**/*.{png,xib}"
    end

    # 位置变化
    ss.subspec 'CJLocationChangeManager' do |sss|
      sss.source_files = "CJBaseUtil/CJManager/CJLocationChangeManager/**/*.{h,m}"
      sss.dependency "CJBaseUtil/CJDateUtil"
    end

    # 倒计时
    ss.subspec 'MyCountDownTimeManager' do |sss|
      sss.source_files = "CJBaseUtil/CJManager/MyCountDownTimeManager/**/*.{h,m}"
      #sss.resources = "CJBaseUtil/CJManager/**/*.{png,xib}"
    end

  end

  # 拼音相关工具
  s.subspec 'CJPinyinHelper' do |ss|
    ss.source_files = "CJBaseUtil/CJPinyinHelper/**/*.{h,m}"
    ss.dependency "PinYin4Objc"
  end

end
