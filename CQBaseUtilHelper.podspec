Pod::Spec.new do |s|
  s.name         = "CQBaseUtilHelper"
  s.version      = "0.0.1"
  s.summary      = "CJBaseUtil 和 CJBaseHelper 的二次封装组件"
  s.homepage     = "https://gitee.com/dvlproad/CJUIKit.git"

  s.license      = {
    :type => 'Copyright',
    :text => <<-LICENSE
              © 2008-2016 dvlproad. All rights reserved.
    LICENSE
  }

  s.author   = { "dvlproad" => "" }

  s.description  = <<-DESC
                  基于 CJBaseUtil 和 CJBaseHelper 的二次封装组件：
                  • UIView+CJPopupInSuspendWindow - 在悬浮窗中弹出自定义视图
                  • SuspendWindowFactory - 悬浮窗工厂
                  • DemoFloatingWindow - 浮窗基类
  DESC

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://gitee.com/dvlproad/CJUIKit.git", :tag => "CQBaseUtilHelper_#{s.version}" }

  s.frameworks = "UIKit"

  s.requires_arc = true

  s.source_files = "CQBaseUtilHelper/**/*.{h,m}"

  s.dependency 'CJBaseUtil'
  s.dependency 'CQDemoKit/BaseVC'
end
