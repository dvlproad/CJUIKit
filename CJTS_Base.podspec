Pod::Spec.new do |s|
  #验证方法：pod lib lint CJTS_Base.podspec --allow-warnings
  #查看本地已同步的pod库：pod repo
  #上传方法：pod repo push cocoapods CJTS_Base.podspec --allow-warnings
  s.name         = "CJTS_Base"
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
  s.source_files  = "CJTS_Base/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "CJHook/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  # s.dependency 'Masonry'
  s.dependency "CJBaseUtil/CJDataUtil"
  s.dependency "CJBaseOverlayKit/CJToast"

  s.subspec 'Home_TextView' do |ss|
    ss.source_files = "CJTS_Base/BaseTextViewController/**/*.{h,m}"
    ss.dependency "CJBaseUtil/CJDataUtil"
  end

  s.subspec 'Home_Collection' do |ss|
    ss.source_files = "CJTS_Base/Collection/**/*.{h,m}"
    s.dependency "CJComplexUIKit/CJCollectionView"
  end

end
