Pod::Spec.new do |s|
  #验证方法：pod lib lint CJFoundation.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJFoundation"
  s.version      = "0.1.2"
  s.summary      = "系统Foundation的扩展"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"
  s.license      = "MIT"
  s.author             = "dvlproad"
  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJFoundation_0.1.2" }
  # s.source_files  = "CJFoundation/**/*.{h,m}"
  # s.resources     = "CJFoundation/**/*.{png,xib}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  # s.vendored_libraries = '/Pod/Classes/*.a' #代码中包含静态库

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  
  s.subspec 'NSString' do |ss|
    ss.source_files = "CJFoundation/NSString/*.{h,m}"
  end


  s.subspec 'NSDictionary' do |ss|
    ss.source_files = "CJFoundation/NSDictionary/*.{h,m}"
  end

  s.subspec 'NSJSONSerialization' do |ss|
    ss.source_files = "CJFoundation/NSJSONSerialization/**/*.{h,m}"
  end

end
