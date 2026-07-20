Pod::Spec.new do |s|
  s.name         = "CQBaseUIKit"
  s.version      = "0.0.1"
  s.summary      = "CJBaseUIKit 的二次封装组件"
  s.homepage     = "https://gitee.com/dvlproad/CJUIKit.git"

  s.license      = {
    :type => 'Copyright',
    :text => <<-LICENSE
              © 2008-2016 dvlproad. All rights reserved.
    LICENSE
  }

  s.author   = { "dvlproad" => "" }

  s.description  = <<-DESC
                   基于 CJBaseUIKit 的二次封装组件：
                   • TSButtonFactory - UIButton 工厂
                   • DemoTextFieldFactory - 输入框工厂
                   • TSSliderFactory - 滑块控件封装
                   • CJDemoDatePickerView / CJDemoDateTextField - 日期选择
                   • CQBlockTextField - CJTextField 的 block 封装
                   • DemoLabelFactory - 标签工厂
                   DESC

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://gitee.com/dvlproad/CJUIKit.git", :tag => "CQBaseUIKit_#{s.version}" }

  s.frameworks = "UIKit"

  s.requires_arc = true

  s.source_files = "CQBaseUIKit/**/*.{h,m}"
  s.resource_bundles = { 'CQBaseUIKit' => ['CQBaseUIKit/**/*.png'] }

  # CJBaseUIKit
  s.dependency 'CJBaseUIKit'
  s.dependency 'CJBaseUIKit-Swift/UIView/as'

  # CJDataVientianeSDK (for CQSubStringUtil / UITextViewCQHelper)
  s.dependency 'CJDataVientianeSDK'

  # 第三方
  s.dependency 'Masonry'
end
