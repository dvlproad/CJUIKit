# 上传到github公有库:
  #验证方法1：pod lib lint CJDataVientianeSDK.podspec --sources='https://github.com/CocoaPods/Specs.git' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint CJDataVientianeSDK.podspec --sources=cocoapods --allow-warnings --use-libraries --verbose
  #提交方法(github公有库)： pod trunk push CJDataVientianeSDK.podspec --allow-warnings --verbose
  


# CJDataVientianeSDK 统一收纳
# 一、CJBaseUIKit
# 1、CJBaseUIKit/UITextInputCJHelper/Helper 里的 
# ①CJSubStringUtil.h  指定位置、指定范围、最大长度字符串获取的方法
# ②UITextInputLimitCJHelper.h 复制粘贴新字符串获取的方法
# 2、CJBaseUIKit/UITextHeightCenterCJHelper/Helper 里的 UITextInputHeightCJHelper.h 文本在指定宽度下的高度计算
# 
# 二、CJBaseHelper
# 1、CJBaseHelper/NSCalendarCJHelper 里的 NSCalendarCJHelper.h 通过 NSCalendar 类，来计算 NSDate 的相等判断或者加减日期等方法的工具
# 
# 三、CJFoundation
# 1、CJFoundation/NSString 里的 
# ①NSString+CJTextLength.h 和 NSString+CJFormatValidate.h
# ②NSString+CJTextSize.h 和 NSString+CJTextSizeInView.h
# 
# 四、CJBaseUtil
# 1、CJBaseUtil/CJDecimalUtil 的 CJDecimalUtil+Distance.h 和 CJDecimalUtil+Money.h

# 即
# 一、CJBaseUIKit：从0.9.0开始，
# 1、①指定位置、指定范围、最大长度字符串获取；1②复制粘贴新字符串获取的方法，已移动到 CJDataVientianeSDK
# 2、文本在指定宽度下的高度计算，已移动到 CJDataVientianeSDK
# 
# 二、CJBaseHelper：从0.2.0开始，
# 1、CJBaseHelper/NSCalendarCJHelper，已移动到 CJDataVientianeSDK
# 
# 三、CJFoundation：从0.1.6开始，
# 1、NSString+CJTextLength.h 和 NSString+CJFormatValidate.h，已移动到 CJDataVientianeSDK
# 2、NSString+CJTextSize.h 和 NSString+CJTextSizeInView.h，已移动到 CJDataVientianeSDK
# 
# 四、CJBaseUtil：从0.6.0开始，
# 1、CJBaseUtil/CJDecimalUtil 的 CJDecimalUtil+Distance.h 和 CJDecimalUtil+Money.h，已移动到 CJDataVientianeSDK

Pod::Spec.new do |s|
  s.name         = "CJDataVientianeSDK"
  s.version      = "0.0.4"
  s.summary      = "数据万象SDK"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"
  s.license      = "MIT"
  s.author       = "dvlproad"

  s.description  = <<-DESC
                 Demo，可按需独立引入：
                 • CJDataVientianeSDK/TextLength - 字符串长度计算
                 • CJDataVientianeSDK/CJSubStringUtil - 指定位置、指定范围、最大长度字符串获取的方法
                 • CJDataVientianeSDK/UITextInputLimitCJHelper - 复制粘贴新字符串获取的方法
                 • CJDataVientianeSDK/UITextInputHeightCJHelper - 文本在指定宽度下的高度计算(与字体大小有关)
                 • CJDataVientianeSDK/TextSize - 文本在指定条件下的所占宽高计算(与字体大小有关)
                 • CJDataVientianeSDK/NSCalendarCJHelper - 通过 NSCalendar 类，来计算 NSDate 的相等判断或者加减日期等方法的工具
                 • CJDataVientianeSDK/CJDecimalUtil - 小数的处理（常用于价钱Money、距离Distance的计算)
                 • CJDataVientianeSDK/FormatValidate - 字符串格式验证（是否是邮箱、手机号等）

                 每个子库可独立引入，详见各子库描述。
                 DESC

  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "9.0"
  s.swift_version = '5.0'

  s.source       = { :git => "https://github.com/dvlproad/CJUIKit", :tag => "CJDataVientianeSDK_0.0.4" }
  # s.source_files  = "CJDataVientianeSDK/*.{h,m}"
  # s.resources = "CJDataVientianeSDK/**/*.{png}"
  s.frameworks = 'UIKit'

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

  # 字符串长度计算
  s.subspec 'TextLength' do |ss|
    ss.source_files = "CJDataVientianeSDK/TextLength/**/*.{h,m}"
  end

  # 指定位置、指定范围、最大长度字符串获取的方法
  s.subspec 'CJSubStringUtil' do |ss|
    ss.source_files = "CJDataVientianeSDK/CJSubStringUtil/**/*.{h,m}"
  end
  
  # 复制粘贴新字符串获取的方法
  s.subspec 'UITextInputLimitCJHelper' do |ss|
    ss.source_files = "CJDataVientianeSDK/UITextInputLimitCJHelper/**/*.{h,m}"
    ss.dependency 'CJDataVientianeSDK/CJSubStringUtil'
  end

  # 文本在指定宽度下的高度计算(与字体大小有关)
  s.subspec 'UITextInputHeightCJHelper' do |ss|
    ss.source_files = "CJDataVientianeSDK/UITextInputHeightCJHelper/**/*.{h,m}"
  end
  
  # 文本在指定条件下的所占宽高计算(与字体大小有关)
  s.subspec 'TextSize' do |ss|
    ss.source_files = "CJDataVientianeSDK/TextSize/**/*.{h,m}"
  end
  
  # 通过 NSCalendar 类，来计算 NSDate 的相等判断或者加减日期等方法的工具
  s.subspec 'NSCalendarCJHelper' do |ss|
    ss.source_files = "CJDataVientianeSDK/NSCalendarCJHelper/**/*.{h,m}"
  end
  
  
  # 小数的处理（常用于价钱Money、距离Distance的计算)
  s.subspec 'CJDecimalUtil' do |ss|
    ss.source_files = "CJDataVientianeSDK/CJDecimalUtil/**/*.{h,m}"
  end

  # 字符串格式验证（是否是邮箱、手机号等）
  s.subspec 'FormatValidate' do |ss|
    ss.source_files = "CJDataVientianeSDK/FormatValidate/**/*.{h,m}"
  end

end
