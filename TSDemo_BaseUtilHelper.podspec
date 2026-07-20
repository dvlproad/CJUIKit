Pod::Spec.new do |s|
  s.name         = "TSDemo_BaseUtilHelper"
  s.version      = "0.0.1"
  s.summary      = "CJBaseUtil 和 CJBaseHelper 的演示示例"
  s.homepage     = "https://gitee.com/dvlproad/CJUIKit.git"

  s.license      = {
    :type => 'Copyright',
    :text => <<-LICENSE
              © 2008-2016 dvlproad. All rights reserved.
    LICENSE
  }

  s.author   = { "dvlproad" => "" }

  s.description  = <<-DESC
                   CJBaseUtil 和 CJBaseHelper 的演示示例
                   DESC

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://gitee.com/dvlproad/CJUIKit.git", :tag => "TSDemo_BaseUtilHelper_#{s.version}" }

  s.frameworks = "UIKit"

  s.requires_arc = true

  s.source_files = "TSDemo_BaseUtilHelper/**/*.{h,m}"
  s.resource_bundles = { 'TSDemo_BaseUtilHelper' => ['TSDemo_BaseUtilHelper/**/*.xib', 'TSDemo_BaseUtilHelper/**/*.png'] }

  s.prefix_header_contents = '#import <Masonry/Masonry.h>'

  s.dependency 'CQDemoKit/BaseVC'
  s.dependency 'CQDemoKit/BaseUtil'
  s.dependency 'CQDemoKit/Auxiliary'

  s.dependency 'CJBaseUtil'
  s.dependency 'CJBaseHelper'
  s.dependency 'CJBaseUIKit'

  s.dependency 'CQBaseUIKit'
  s.dependency 'CQBaseUtilHelper'
  s.dependency 'TSDemo_BaseUIKit'

  s.dependency 'Masonry'
end
