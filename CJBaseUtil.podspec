Pod::Spec.new do |s|
  #验证方法：pod lib lint CJBaseUtil.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJBaseUtil"
  s.version      = "0.5.2"
  s.summary      = "自定义的基础工具类"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                 自定义的基础工具类，可按需独立引入：
                 • CJBaseUtil/CJIndentedStringUtil - 将 字符串/字典/数组转成含缩进字符串的字符串 的工具
                 • CJBaseUtil/CJAppLastUtil - APP上次信息+账号安全工具
                 • CJBaseUtil/CJDataUtil - 包含排序+SortOrder、分类+SortCategory、搜索+NormalSearch 等的数据处理工具类
                 • CJBaseUtil/CJDecimalUtil - 小数的处理（常用于价钱Money、距离Distance的计算)
                 • CJBaseUtil/CJDateUtil - 日期工具
                 • CJBaseUtil/CJKeyboardUtil - 键盘工具
                 • CJBaseUtil/CJCallUtil - 拨打电话工具
                 • CJBaseUtil/CJQRCodeUtil - 二维码工具
                 • CJBaseUtil/CJLaunchImageUtil - 启动图工具
                 • CJBaseUtil/CJManager - 其他各种管理器(AppDelegate瘦身、位置变化、倒计时、悬浮框)
                 • CJBaseUtil/CJManager/CJModuleManager - AppDelegate瘦身管理器
                 • CJBaseUtil/CJManager/CJLocationChangeManager - 位置变化管理器
                 • CJBaseUtil/CJManager/CJTimerManager - 倒计时管理器
                 • CJBaseUtil/CJManager/CJSuspendWindowManager - 悬浮框管理器
                 • CJBaseUtil/CJPinyinHelper - 拼音相关工具

                 每个子库可独立引入，详见各子库描述。
                 DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseUtil_0.5.2" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  # 将 字符串/字典/数组转成含缩进字符串的字符串 的工具
  s.subspec 'CJIndentedStringUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJIndentedStringUtil/**/*.{h,m}"
  end


  # APP上次信息+账号安全工具
  s.subspec 'CJAppLastUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJAppLastUtil/**/*.{h,m}"
    ss.dependency "SAMKeychain"
  end

  # 包含排序+SortOrder、分类+SortCategory、搜索+NormalSearch 等的数据处理工具类
  s.subspec 'CJDataUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJDataUtil/**/*.{h,m}"
  end


  # 小数的处理（常用于价钱Money、距离Distance的计算)
  s.subspec 'CJDecimalUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJDecimalUtil/**/*.{h,m}"
  end

  # 日期工具
  s.subspec 'CJDateUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJDateUtil/**/*.{h,m}"
  end

  # 键盘工具
  s.subspec 'CJKeyboardUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJKeyboardUtil/**/*.{h,m}"
  end

  # s.subspec 'UIUtil' do |ss|
  #   ss.source_files = "CJBaseUtil/UIUtil/**/*.{h,m}"
  # end

  # 拨打电话工具
  s.subspec 'CJCallUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJCallUtil/**/*.{h,m}"
  end


  # 二维码工具
  s.subspec 'CJQRCodeUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJQRCodeUtil/**/*.{h,m}"
  end

  # 启动图工具
  s.subspec 'CJLaunchImageUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJLaunchImageUtil/**/*.{h,m}"
  end


  # 其他各种管理器(AppDelegate瘦身、位置变化、倒计时、悬浮框)
  s.subspec 'CJManager' do |ss|

    # AppDelegate瘦身管理器
    ss.subspec 'CJModuleManager' do |sss|
      sss.source_files = "CJBaseUtil/CJManager/CJModuleManager/**/*.{h,m}"
      #sss.resources = "CJBaseUtil/CJManager/**/*.{png,xib}"
    end

    # 位置变化管理器
    ss.subspec 'CJLocationChangeManager' do |sss|
      sss.source_files = "CJBaseUtil/CJManager/CJLocationChangeManager/**/*.{h,m}"
      sss.dependency "CJBaseUtil/CJDateUtil"
    end

    # 倒计时管理器
    ss.subspec 'CJTimerManager' do |sss|
      sss.source_files = "CJBaseUtil/CJManager/CJTimerManager/**/*.{h,m}"
      #sss.resources = "CJBaseUtil/CJManager/**/*.{png,xib}"
    end

    # 悬浮框管理器
    ss.subspec 'CJSuspendWindowManager' do |sss|
      sss.source_files = "CJBaseUtil/CJManager/CJSuspendWindowManager/**/*.{h,m}"
      #sss.resources = "CJBaseUtil/CJManager/**/*.{png,xib}"
    end

    # 混淆类名时候需要生成随机值来替代
    ss.subspec 'CJConfuseManager' do |sss|
      sss.source_files = "CJBaseUtil/CJManager/CJConfuseManager/**/*.{h,m}"
    end

  end

  # 拼音相关工具
  s.subspec 'CJPinyinHelper' do |ss|
    ss.source_files = "CJBaseUtil/CJPinyinHelper/**/*.{h,m}"
    ss.dependency "PinYin4Objc"
  end

end
