Pod::Spec.new do |s|
  #验证方法：pod lib lint CJBaseUtil.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJBaseUtil"
  s.version      = "0.5.1"
  s.summary      = "自定义的基础工具类"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                  - CJBaseUtil/CJDataUtil：包含搜索、排序、分类等数据处理工具类
                  - CJBaseUtil/CJDateUtil：日期工具
                  - CJBaseUtil/CJKeyboardUtil：键盘工具
                  - CJBaseUtil/CJIndentedStringUtil：将 字符串/字典/数组转成含缩进字符串的字符串 的工具
                  - CJBaseUtil/CJAppLastUtil：APP上次信息+账号安全工具
                  - CJBaseUtil/CJManager：其他各种管理器(AppDelegate瘦身、位置变化、倒计时、悬浮框)
                  - CJBaseUtil/CJPinyinHelper：拼音相关工具
                  - CJBaseUtil/CJCallUtil：拨打电话工具
                  - CJBaseUtil/CJQRCodeUtil：二维码
                  - CJBaseUtil/CJLaunchImageUtil：启动图

                   A longer description of CJBaseUtil in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseUtil_0.5.1" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  s.subspec 'CJIndentedStringUtil' do |ss|
    ss.summary = "将 字符串/字典/数组转成含缩进字符串的字符串 的工具"
    ss.source_files = "CJBaseUtil/CJIndentedStringUtil/**/*.{h,m}"
  end


  s.subspec 'CJAppLastUtil' do |ss|
    ss.summary = "APP上次信息+账号安全工具"
    ss.source_files = "CJBaseUtil/CJAppLastUtil/**/*.{h,m}"
    ss.dependency "SAMKeychain"
  end

  # 包含搜索、排序等数据处理工具类
  s.subspec 'CJDataUtil' do |ss|
    ss.summary = "含排序+SortOrder、分类+SortCategory、搜索+NormalSearch 等"
    ss.source_files = "CJBaseUtil/CJDataUtil/**/*.{h,m}"
  end

  # 日期工具
  s.subspec 'CJDateUtil' do |ss|
    ss.summary = "日期工具"
    ss.source_files = "CJBaseUtil/CJDateUtil/**/*.{h,m}"
  end

  # 键盘工具
  s.subspec 'CJKeyboardUtil' do |ss|
    ss.summary = "键盘工具"
    ss.source_files = "CJBaseUtil/CJKeyboardUtil/**/*.{h,m}"
  end

  # s.subspec 'UIUtil' do |ss|
  #   ss.source_files = "CJBaseUtil/UIUtil/**/*.{h,m}"
  # end

  s.subspec 'CJCallUtil' do |ss|
    ss.summary = "拨打电话工具"
    ss.source_files = "CJBaseUtil/CJCallUtil/**/*.{h,m}"
  end


  s.subspec 'CJQRCodeUtil' do |ss|
    ss.summary = "二维码工具"
    ss.source_files = "CJBaseUtil/CJQRCodeUtil/**/*.{h,m}"
  end

  s.subspec 'CJLaunchImageUtil' do |ss|
    ss.summary = "启动图工具"
    ss.source_files = "CJBaseUtil/CJLaunchImageUtil/**/*.{h,m}"
  end


  s.subspec 'CJManager' do |ss|
    ss.summary = "其他各种管理器(AppDelegate瘦身、位置变化、倒计时、悬浮框)"

    ss.subspec 'CJModuleManager' do |sss|
      sss.summary = "AppDelegate瘦身管理器"
      sss.source_files = "CJBaseUtil/CJManager/CJModuleManager/**/*.{h,m}"
      #sss.resources = "CJBaseUtil/CJManager/**/*.{png,xib}"
    end

    ss.subspec 'CJLocationChangeManager' do |sss|
      sss.summary = "位置变化管理器"
      sss.source_files = "CJBaseUtil/CJManager/CJLocationChangeManager/**/*.{h,m}"
      sss.dependency "CJBaseUtil/CJDateUtil"
    end

    ss.subspec 'CJTimerManager' do |sss|
      sss.summary = "倒计时管理器"
      sss.source_files = "CJBaseUtil/CJManager/CJTimerManager/**/*.{h,m}"
      #sss.resources = "CJBaseUtil/CJManager/**/*.{png,xib}"
    end

    ss.subspec 'CJSuspendWindowManager' do |sss|
      sss.summary = "悬浮框管理器"
      sss.source_files = "CJBaseUtil/CJManager/CJSuspendWindowManager/**/*.{h,m}"
      #sss.resources = "CJBaseUtil/CJManager/**/*.{png,xib}"
    end

  end

  # 拼音相关工具
  s.subspec 'CJPinyinHelper' do |ss|
    ss.summary = "拼音相关工具"
    ss.source_files = "CJBaseUtil/CJPinyinHelper/**/*.{h,m}"
    ss.dependency "PinYin4Objc"
  end

end
