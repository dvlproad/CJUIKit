Pod::Spec.new do |s|
  #验证方法：pod lib lint LuckinBaseEffectKit.podspec --allow-warnings --verbose
  s.name         = "LuckinBaseEffectKit"
  s.version      = "0.0.2"
  s.summary      = "自定义的基础效果UI"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 - LuckinBaseUIKit/CJRefreshView：刷新
                 - LuckinBaseUIKit/CJRefreshWithJSON：使用json动画的刷新
                 - LuckinBaseUIKit/CJMJRefreshComponent：已包含pod 'MJRefresh'
                 - LuckinBaseUIKit/CJDataEmptyView：空视图(处理数据为空、网络加载失败等情况)
                 - LuckinBaseUIKit/CJScaleHeadView：个人中心头部的缩放视图

                   A longer description of LuckinBaseEffectKit in Markdown format.

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
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "LuckinBaseEffectKit_0.0.2" }
  #s.source_files  = "LuckinBaseEffectKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "LuckinBaseEffectKit/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  # s.dependency 'Masonry'


  # 使用json动画的刷新
  s.subspec 'CJRefreshWithJSON' do |ss|
    ss.source_files = "LuckinBaseEffectKit/CJRefreshWithJSON/**/*.{h,m}"
    # ss.resources = "LuckinBaseEffectKit/CJRefreshWithJSON/**/*.{png,xib}"
    
    ss.dependency 'Masonry'
    ss.dependency 'MJRefresh'
    ss.dependency 'lottie-ios', '~> 2.5.3'
  end

  s.subspec 'CJRefreshView' do |ss|
    ss.source_files = "LuckinBaseEffectKit/CJRefreshView/**/*.{h,m}"
    # ss.resources = "LuckinBaseEffectKit/CJRefreshView/**/*.{png,xib}"
  end

  s.subspec 'CJMJRefreshComponent' do |ss|
    ss.source_files = "LuckinBaseEffectKit/CJMJRefreshComponent/**/*.{h,m}"
    ss.resources = "LuckinBaseEffectKit/CJMJRefreshComponent/**/*.{png,xib}"

    #多个依赖就写多行
    #ss.dependency 'Masonry'
    ss.dependency 'MJRefresh'
  end


  s.subspec 'CJDataEmptyView' do |ss|
    ss.source_files = "LuckinBaseEffectKit/CJDataEmptyView/**/*.{h,m}"
    ss.resources = "LuckinBaseEffectKit/CJDataEmptyView/**/*.{png}"

    #多个依赖就写多行
    ss.dependency 'Masonry'
    ss.dependency 'CJFoundation/NSString'
  end

  s.subspec 'CJScaleHeadView' do |ss|
    ss.source_files = "LuckinBaseEffectKit/CJScaleHeadView/**/*.{h,m}"
  end


end
