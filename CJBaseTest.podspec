Pod::Spec.new do |s|
  #验证方法：pod lib lint CJBaseTest.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJBaseTest"
  s.version      = "0.0.1"
  s.summary      = "自定义的基础帮助类"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                  - CJBaseTest/Test：单元测试类
                  - CJBaseTest/UITest：自动化测试类
                  

                   A longer description of CJBaseTest in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJBaseTest_0.0.1" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'XCTest'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  # 单元测试
  s.subspec 'Test' do |ss|
    ss.source_files = "CJBaseTest/Test/**/*.{h,m}"
  end

  # 自动化测试
  s.subspec 'UITest' do |ss|
    ss.source_files = "CJBaseTest/UITest/**/*.{h,m}"
  end  

end
