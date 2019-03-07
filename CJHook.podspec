Pod::Spec.new do |s|
  #验证方法：pod lib lint CJHook.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJHook"
  s.version      = "0.0.1"
  s.summary      = "Hook"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 - CJBaseUIKit/UIColor：颜色：用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
                 - CJBaseUIKit/UIImage：图片
                 - CJBaseUIKit/UINavigationBar：导航栏
                 - CJBaseUIKit/UIView：视图

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
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJHook_0.0.1" }
  s.source_files  = "CJHook/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "CJHook/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  # s.dependency 'Masonry'

  s.subspec 'UIViewController' do |ss|
    ss.source_files = "CJHook/UIViewController/**/*.{h,m}"
  end

  s.subspec 'UIButton' do |ss|
    ss.source_files = "CJHook/UIButton/**/*.{h,m}"
  end


  # s.subspec 'UINavigationBar' do |ss|
  #   ss.source_files = "CJHook/UINavigationBar/**/*.{h,m}"
  # end



end
