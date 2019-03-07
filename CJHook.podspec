Pod::Spec.new do |s|
  #验证方法：pod lib lint CJHook.podspec --allow-warnings
  s.name         = "CJHook"
  s.version      = "0.0.2"
  s.summary      = "Hook"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 - CJHook/HookCJHelper：Hook帮助类

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
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJHook_0.0.2" }
  # s.source_files  = "CJHook/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "CJHook/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  # s.dependency 'Masonry'
  s.dependency "CJBaseHelper/HookCJHelper"

  s.subspec 'CJFileUploadPanel' do |ss|
    ss.source_files = "CJHook/CJFileUploadPanel/**/*.{h,m}"
  end

  s.subspec 'UIViewController' do |ss|
    ss.source_files = "CJHook/UIViewController/**/*.{h,m}"
    ss.dependency "CJBaseHelper/UIViewControllerCJHelper"
  end

  s.subspec 'UIButton' do |ss|
    ss.source_files = "CJHook/UIButton/**/*.{h,m}"
  end



end
