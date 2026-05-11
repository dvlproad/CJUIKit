Pod::Spec.new do |s|
  #验证方法1：pod lib lint SwiftExtraCJHelper.podspec --sources='https://github.com/CocoaPods/Specs.git' --allow-warnings --verbose
  #提交方法(github公有库)： pod trunk push SwiftExtraCJHelper.podspec --allow-warnings --verbose

  s.name         = "SwiftExtraCJHelper"
  s.version      = "0.1.2"
  s.summary      = "NSClassFromString 帮助类（解决 Swift 命名空间前缀问题）"
  s.homepage     = "https://github.com/dvlproad/CJUIKit.git"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                 NSClassFromString 帮助类，可按需独立引入：
                 • SwiftExtraCJHelper/Base - NSClassFromString 获取 Swift/OC 类（处理命名空间前缀）

                 每个子库可独立引入，详见各子库描述。
                 DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "9.0"
  s.swift_version = '4.0'

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "SwiftExtraCJHelper_0.1.2" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  # NSClassFromString 获取 Swift/OC 类（处理命名空间前缀）
  s.subspec 'Base' do |ss|
    ss.source_files = "SwiftExtraCJHelper/Base/**/*.{swift}"
  end

end
