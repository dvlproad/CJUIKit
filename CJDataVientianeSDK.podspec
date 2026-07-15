# 上传到github公有库:
  #验证方法1：pod lib lint CJDataVientianeSDK.podspec --sources='https://github.com/CocoaPods/Specs.git' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint CJDataVientianeSDK.podspec --sources=master --allow-warnings --use-libraries --verbose
  #提交方法(github公有库)： pod trunk push CJDataVientianeSDK.podspec --allow-warnings
  


# CJDataVientianeSDK 统一收纳
# 1、CJBaseUIKit/UITextInputCJHelper/Helper 里的 
# ①CJSubStringUtil.h  指定位置、指定范围、最大长度字符串获取的方法
# ②UITextInputLimitCJHelper.h 复制粘贴新字符串获取的方法
# 2、CJBaseUIKit/UITextHeightCenterCJHelper/Helper 里的 
# UITextInputHeightCJHelper.h 文本在指定宽度下的高度计算

# 即从0.9.0开始，
# 1、①指定位置、指定范围、最大长度字符串获取；1②复制粘贴新字符串获取的方法，已移动到 CJDataVientianeSDK
# 2、文本在指定宽度下的高度计算，已移动到 CJDataVientianeSDK



Pod::Spec.new do |s|
  s.name         = "CJDataVientianeSDK"
  s.version      = "0.0.1"
  s.summary      = "数据万象SDK"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                 Demo，可按需独立引入：
                 • CQDemoKit/CJSubStringUtil - 指定位置、指定范围、最大长度字符串获取的方法
                 • CQDemoKit/UITextInputLimitCJHelper - 复制粘贴新字符串获取的方法
                 • CQDemoKit/UITextInputHeightCJHelper - 文本在指定宽度下的高度计算

                 每个子库可独立引入，详见各子库描述。
                 DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "8.0"
  s.swift_version = '5.0'

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit", :tag => "CJDataVientianeSDK_0.0.1" }
  # s.source_files  = "CJBaseUtil/*.{h,m}"
  # s.resources = "CJBaseUtil/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  # 指定位置、指定范围、最大长度字符串获取的方法
  s.subspec 'CJSubStringUtil' do |ss|
    ss.source_files = "CJDataVientianeSDK/CJSubStringUtil/**/*.{h,m}"
  end
  
  # 复制粘贴新字符串获取的方法
  s.subspec 'UITextInputLimitCJHelper' do |ss|
    ss.source_files = "CJDataVientianeSDK/UITextInputLimitCJHelper/**/*.{h,m}"
  end

  # 文本在指定宽度下的高度计算
  s.subspec 'UITextInputHeightCJHelper' do |ss|
    ss.source_files = "CJDataVientianeSDK/UITextInputHeightCJHelper/**/*.{h,m}"
  end

end
