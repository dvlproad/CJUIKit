Pod::Spec.new do |s|

  s.name         = "CJBaseUIKit"
  s.version      = "0.0.3"
  s.summary      = "自定义的基础UI"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                    1、CJImageView(包含CJBadgeImageView),用于设置imageView的title和badge;
                   2、已在CJRefreshComponent中包含pod 'MJRefresh', '~> 3.1.12'

                   A longer description of CJPopupAction in Markdown format.

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

  s.author   = { "lichq" => "" }

  s.platform     = :ios, "7.0"
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJImageView_0.0.3" }
  s.source_files  = "CJUIKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  s.subspec 'CJImageView' do |ss|
    ss.source_files = "CJUIKit/CJImageView/**/*.{h,m}"
    # ss.resources = "CJUIKit/CJImageView/**/*.{png,xib}"
  end

  s.subspec 'CJTextView' do |ss|
    ss.source_files = "CJUIKit/CJTextView/**/*.{h,m}"
    # ss.resources = "CJUIKit/CJTextView/**/*.{png,xib}"
  end

  s.subspec 'CJRefreshComponent' do |ss|
    ss.source_files = "CJUIKit/CJRefreshComponent/**/*.{h,m}"
    ss.resources = "CJUIKit/CJRefreshComponent/**/*.{png,xib}"
    ss.dependency 'MJRefresh', '~> 3.1.12'
  end

end
