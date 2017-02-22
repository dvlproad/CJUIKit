Pod::Spec.new do |s|

  s.name         = "CJUIKit"
  s.version      = "0.0.1"
  s.summary      = "自定义的基础UI"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  #s.license      = {
  #  :type => 'Copyright',
  #  :text => <<-LICENSE
  #            © 2008-2016 Dvlproad. All rights reserved.
  #  LICENSE
  #}
  s.license      = "MIT"

  s.author   = { "lichq" => "" }

  s.platform     = :ios, "7.0"
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJRefreshComponent_0.0.1" }
  s.source_files  = "CJUIKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  s.subspec 'CJRefreshComponent' do |ss|
    ss.source_files = "CJUIKit/CJRefreshComponent/**/*.{h,m}"
    ss.dependency 'MJRefresh', '~> 3.1.12'
  end

end
