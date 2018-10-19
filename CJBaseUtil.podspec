Pod::Spec.new do |s|
  #验证方法：pod lib lint CJBaseUtil.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJBaseUtil"
  s.version      = "0.4.3"
  s.summary      = "自定义的基础工具类"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                  1、CJDataUtil：包含搜索、排序等数据处理工具类
                  2、CJDateUtil：日期工具
                  3、CJKeyboardUtil：键盘工具
                  4、CJLog：日志工具
                  *、CJIndentedStringUtil：将 字符串/字典/数组转成含缩进字符串的字符串 的工具
                  7、CJAppLastUtil：APP上次信息+账号安全工具
                  8、CJManager：其他各种工具类
                  9、CJPinyinHelper：拼音相关工具
                  10、CJCallUtil：拨打电话工具
                  *、CJQRCodeUtil：二维码
                  *、CJLaunchImageUtil：启动图

                   A longer description of CJBaseUtil in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseUtil_0.4.3" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  s.subspec 'CJLog' do |ss|
    ss.source_files = "CJBaseUtil/CJLog/**/*.{h,m}"
    ss.dependency 'Masonry'
    ss.dependency 'CJBaseUIKit/UIView/CJDragAction' #CJLogSuspendWindow用于控制log视图的弹出与隐藏的悬浮球需要依赖到
  end

  # 将 字符串/字典/数组转成含缩进字符串的字符串 的工具
  s.subspec 'CJIndentedStringUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJIndentedStringUtil/**/*.{h,m}"
  end

  # 上次信息(账号安全)
  s.subspec 'CJAppLastUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJAppLastUtil/**/*.{h,m}"
    ss.dependency "SAMKeychain"
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

  # 拨打电话
  s.subspec 'CJCallUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJCallUtil/**/*.{h,m}"
  end

  # 二维码
  s.subspec 'CJQRCodeUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJQRCodeUtil/**/*.{h,m}"
  end

  # 启动图
  s.subspec 'CJLaunchImageUtil' do |ss|
    ss.source_files = "CJBaseUtil/CJLaunchImageUtil/**/*.{h,m}"
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
    ss.subspec 'CJTimerManager' do |sss|
      sss.source_files = "CJBaseUtil/CJManager/CJTimerManager/**/*.{h,m}"
      #sss.resources = "CJBaseUtil/CJManager/**/*.{png,xib}"
    end

    ## 悬浮框管理器
    ss.subspec 'CJSuspendWindowManager' do |sss|
      sss.source_files = "CJBaseUtil/CJManager/CJTimerManager/**/*.{h,m}"
      #sss.resources = "CJBaseUtil/CJManager/**/*.{png,xib}"
    end

  end

  # 拼音相关工具
  s.subspec 'CJPinyinHelper' do |ss|
    ss.source_files = "CJBaseUtil/CJPinyinHelper/**/*.{h,m}"
    ss.dependency "PinYin4Objc"
  end

end
