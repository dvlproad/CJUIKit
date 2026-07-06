Pod::Spec.new do |s|
  #验证方法1：pod lib lint CJBaseUtil-Swift.podspec --sources='https://github.com/CocoaPods/Specs.git' --allow-warnings --verbose
  #提交方法(github公有库)： pod trunk push CJBaseUtil-Swift.podspec --allow-warnings --verbose

  s.name         = "CJBaseUtil-Swift"
  s.version      = "0.1.1"
  s.summary      = "自定义的基础工具类（Swift版）"
  s.homepage     = "https://github.com/dvlproad/CJUIKit.git"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                 自定义的基础工具类，可按需独立引入：
                 • CJBaseUtil-Swift/FrameworkCJHelper - Framework 帮助类（解决 use_frameworks! 命名空间前缀问题）

                 每个子库可独立引入，详见各子库描述。
                 DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "9.0"
  s.swift_version = '5.0'

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseUtil-Swift_0.1.1" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  # Framework 帮助类（解决 use_frameworks! 命名空间前缀问题）
  s.subspec 'FrameworkCJHelper' do |ss|
    ss.source_files = "CJBaseUtil-Swift/FrameworkCJHelper/**/*.{swift}"
  end

end
