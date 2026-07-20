Pod::Spec.new do |s|
  s.name         = "TSDemo_BaseUIKit"
  s.version      = "0.0.1"
  s.summary      = "CJBaseUIKit 的演示示例"
  s.homepage     = "https://gitee.com/dvlproad/CJUIKit.git"

  s.license      = {
    :type => 'Copyright',
    :text => <<-LICENSE
              © 2008-2016 dvlproad. All rights reserved.
    LICENSE
  }

  s.author   = { "dvlproad" => "" }

  s.description  = <<-DESC
                   CJBaseUIKit 各功能模块的演示示例：
                   • UIColor - 颜色分类
                   • UIView - 视图分类（拖拽、摇晃、手势等）
                   • UIButton - 按钮分类
                   • UITextField - 输入框分类
                   • UIScrollView - 滚动视图
                   • UIViewController - 控制器
                   • UINavigationBar - 导航栏
                   • UIWindow - 悬浮窗
                   DESC

  s.platform     = :ios, "9.0"

  s.source       = { :git => "https://gitee.com/dvlproad/CJUIKit.git", :tag => "TSDemo_BaseUIKit_0.0.1" }

  s.frameworks = "UIKit"

  s.requires_arc = true

  s.source_files = "TSDemo_BaseUIKit/**/*.{h,m}"
  s.resource_bundles = { 'TSDemo_BaseUIKit' => ['TSDemo_BaseUIKit/**/*.xib'] }
  s.prefix_header_contents = '#import <Masonry/Masonry.h>', '#import <CJBaseUIKit/UIColor+CJHex.h>'

  # CQBaseUIKit (二次封装组件)
  s.dependency 'CQBaseUIKit'

  # CQDemoKit
  s.dependency 'CQDemoKit/BaseVC'
  s.dependency 'CQDemoKit/BaseUIKit'
  s.dependency 'CQDemoKit/Demo_RipeView'

  # CJBaseUIKit
  s.dependency 'CJBaseUIKit'
  s.dependency 'CJBaseUIKit-Swift/UIView/as'

  # CJBaseUtil
  s.dependency 'CJBaseUtil'

  # CJPopupView
  s.dependency 'CJPopupView/CJPopoverView'
  s.dependency 'CJPopupAction'

  # CJBaseEffectKit
  s.dependency 'CJBaseEffectKit/CJScaleHeadView'

  # 第三方
  s.dependency 'Masonry'
  s.dependency 'Shimmer', '~> 1.0.2'
  s.dependency 'IQKeyboardManager'
  s.dependency 'UINavigation-SXFixSpace'
end
