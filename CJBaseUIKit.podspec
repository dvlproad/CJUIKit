Pod::Spec.new do |s|

  s.name         = "CJBaseUIKit"
  s.version      = "0.0.9"
  s.summary      = "自定义的基础UI"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                  1、CJImageView(包含CJBadgeImageView),用于设置imageView的title和badge;
                  2、CJTextView：类似微信文本输入框实现
                  3、已在CJMJRefreshComponent中包含pod 'MJRefresh', '~> 3.1.12'
                  *、UIColor+CJHex：用来通过十六进制来设置颜色。 支持@“#123456”、 @“0X123456”、 @“123456”三种格式
                  *、UIImage+CJCategory：
                  4、CJSlider

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
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "UIImage+CJCategory_0.0.9" }
  s.source_files  = "CJUIKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"


  s.subspec 'UIColor+CJCategory' do |ss|
    ss.source_files = "CJUIKit/UIColor+CJCategory/**/*.{h,m}"
  end

  s.subspec 'UIImage+CJCategory' do |ss|
    ss.source_files = "CJUIKit/UIImage+CJCategory/**/*.{h,m}"
  end

  s.subspec 'UIView+Category' do |ss|
    ss.source_files = "CJUIKit/UIView+Category/**/*.{h,m}"
  end

  s.subspec 'UIButton+CJCategory' do |ss|
    ss.source_files = "CJUIKit/UIButton+CJCategory/**/*.{h,m}"
  end

  s.subspec 'CJImageView' do |ss|
    ss.source_files = "CJUIKit/CJImageView/**/*.{h,m}"
    # ss.resources = "CJUIKit/CJImageView/**/*.{png,xib}"
  end

  s.subspec 'CJTextField' do |ss|
    ss.source_files = "CJUIKit/CJTextField/**/*.{h,m}"
  end

  s.subspec 'CJTextView' do |ss|
    ss.source_files = "CJUIKit/CJTextView/**/*.{h,m}"
    # ss.resources = "CJUIKit/CJTextView/**/*.{png,xib}"
  end

  s.subspec 'CJScrollView' do |ss|
    ss.source_files = "CJUIKit/CJScrollView/**/*.{h,m}"
    # ss.resources = "CJUIKit/CJScrollView/**/*.{png,xib}"
  end


  s.subspec 'CJSlider' do |ss|
    ss.source_files = "CJUIKit/CJSlider/*.{h,m}", "CJUIKit/CJSlider/Model/**/*.{h,m}"

    ss.subspec 'CJPlayerSlider' do |sss|
      sss.source_files = "CJUIKit/CJSlider/CJPlayerSlider/**/*.{h,m}"
    end

    ss.subspec 'CJSliderControl' do |sss|
      sss.source_files = "CJUIKit/CJSlider/CJSliderControl/**/*.{h,m}"
      sss.dependency 'CJBaseUIKit/UIImage+CJCategory', '~> 0.0.7'
    end
    
  end
  

  s.subspec 'CJRefreshView' do |ss|
    ss.source_files = "CJUIKit/CJRefreshView/**/*.{h,m}"
    # ss.resources = "CJUIKit/CJRefreshView/**/*.{png,xib}"
  end

  s.subspec 'CJMJRefreshComponent' do |ss|
    ss.source_files = "CJUIKit/CJMJRefreshComponent/**/*.{h,m}"
    ss.resources = "CJUIKit/CJMJRefreshComponent/**/*.{png,xib}"
    ss.dependency 'MJRefresh', '~> 3.1.12'
  end

end
