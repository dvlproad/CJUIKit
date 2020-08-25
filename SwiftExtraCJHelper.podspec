Pod::Spec.new do |s|
  #验证方法：pod lib lint SwiftExtraCJHelper.podspec --allow-warnings --use-libraries --verbose
  s.name         = "SwiftExtraCJHelper"
  s.version      = "0.1.0"
  s.summary      = "Swift/OC帮助类"
  s.homepage     = "https://github.com/dvlproad/CJUIKit.git"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                   A longer description of SwiftExtraCJHelper in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "SwiftExtraCJHelper_0.1.0" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  # 基础的帮助类
  s.subspec 'Base' do |ss|
    ss.source_files = "SwiftExtraCJHelper/Base/**/*.{swift}"
  end

end
