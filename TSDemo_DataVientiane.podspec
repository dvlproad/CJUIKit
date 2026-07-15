	#验证方法1：pod lib lint TSDemo_DataVientiane.podspec --sources='https://github.com/CocoaPods/Specs.git,https://gitee.com/dvlproad/dvlproadSpecs' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint TSDemo_DataVientiane.podspec --sources=cocoapods,gitee-dvlproad-dvlproadspecs --allow-warnings --use-libraries --verbose
  #提交方法： pod repo push gitee-dvlproad-dvlproadspecs TSDemo_DataVientiane.podspec --sources=cocoapods,gitee-dvlproad-dvlproadspecs --allow-warnings --use-libraries --verbose
Pod::Spec.new do |s|
  s.name         = "TSDemo_DataVientiane"
  s.version      = "0.0.1"
  s.summary      = "列表List演示示例"
  s.homepage     = "https://gitee.com/dvlproad/CJUIKit.git"

  #s.license      = "MIT"
  s.license      = {
    :type => 'Copyright',
    :text => <<-LICENSE
              © 2008-2016 dvlproad. All rights reserved.
    LICENSE
  }

  s.author   = { "dvlproad" => "" }
  

  s.description  = <<-DESC
 				          -、演示示例

                   A longer description of TSDemo_DataVientiane in Markdown format.

                   * Think: Why did you write this? What is the focus? What does it do?
                   * CocoaPods will be using this to generate tags, and improve search results.
                   * Try to keep it short, snappy and to the point.
                   * Finally, don't worry about the indent, CocoaPods strips it!
                   DESC
  

  s.platform     = :ios, "9.0"
 
  s.source       = { :git => "https://gitee.com/dvlproad/CJUIKit.git", :tag => "TSDemo_DataVientiane_0.0.1" }
  #s.source_files  = "CJDemoCommon/*.{h,m}"
  #s.source_files = "CJChat/TestOSChinaPod.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"


  # TSDemo_DataVientiane
  s.source_files = "TSDemo_DataVientiane/**/*.{h,m}"
  s.resource_bundle = {
    'TSDemo_DataVientiane' => ['TSDemo_DataVientiane/**/*.xcassets', 'TSDemo_DataVientiane/**/*.{xib,png,jpg}'] # TSDemo_DataVientiane 为生成boudle的名称，可以随便起，但要记住，库里要用
  }
  #多个依赖就写多行
  s.dependency 'CQDemoKit/BaseVC'
  s.dependency 'CQDemoResource/Images'

  s.dependency 'CJDataVientianeSDK'
  s.dependency 'CJBaseUIKit/UITextField'
  s.dependency 'CJBaseUIKit/UIColor'
  s.dependency 'CJBaseUIKit/UIButton'
end
