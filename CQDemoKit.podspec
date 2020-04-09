Pod::Spec.new do |s|
  #验证方法：pod lib lint CQDemoKit.podspec --sources=cocoapods --allow-warnings
  #查看本地已同步的pod库：pod repo
  #上传方法：pod repo push cocoapods CQDemoKit.podspec --sources=cocoapods --allow-warnings
  s.name         = "CQDemoKit"
  s.version      = "0.1.0"
  s.summary      = "Demo"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 - CQDemoKit/xxx：Demo最基础类

                   A longer description of CJHook in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC
  

  #s.license      = {
  #  :type => 'Copyright',
  #  :text => <<-LICENSE
  #            © 2008-2016 Dvlproad. All rights reserved.
  #  LICENSE
  #}
  s.license      = "MIT"

  s.author   = { "dvlproad" => "" }

  s.platform     = :ios, "8.0"
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CQDemoKit_0.1.0" }
  #s.source_files  = "CQDemoKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "CJHook/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  

  s.subspec 'Home_Base' do |ss|
    ss.source_files = "CQDemoKit/Base/**/*.{h,m}"
    ss.dependency 'Masonry'
    ss.dependency "CJBaseUtil/CJDataUtil"
    ss.dependency "CJBaseOverlayKit/CJToast"
  end

  s.subspec 'Home_TextView' do |ss|
    ss.source_files = "CQDemoKit/TextView/**/*.{h,m}"

    ss.dependency 'CQDemoKit/Home_Base'
  end

  s.subspec 'Home_Collection' do |ss|
    ss.source_files = "CQDemoKit/Collection/**/*.{h,m}"

    ss.dependency 'CQDemoKit/Home_Base'
  end

end
