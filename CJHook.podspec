Pod::Spec.new do |s|
  #验证方法：pod lib lint CJHook.podspec --allow-warnings
  s.name         = "CJHook"
  s.version      = "0.0.2"
  s.summary      = "Hook 方法（拦截 H5 图片上传、防止按钮重复点击）"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 Hook，可按需独立引入：
                 • CJHook/CJFileUploadPanel - hook:H5 <input> 选取图片的拦截处理，替换原图后，继续走系统上传流程
                 • CJHook/UIViewController - hook:拦截 H5 <input> 触发文件上传面板（拦截 present + 拦截图片选择结果）
                 • CJHook/UIButton - hook:防止按钮重复点击

                 每个子库可独立引入，详见各子库描述。
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
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJHook_0.0.2" }
  # s.source_files  = "CJHook/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
  # s.resources = "CJHook/**/*.{png,xib}"
  # s.frameworks = "MediaPlayer"
  # s.dependency 'Masonry'
  s.dependency "CJBaseHelper/HookCJHelper"

  # hook:H5 <input> 选取图片的拦截处理，替换原图后，继续走系统上传流程
  s.subspec 'CJFileUploadPanel' do |ss|
    ss.source_files = "CJHook/CJFileUploadPanel/**/*.{h,m}"
  end

  # hook:拦截 H5 <input> 触发文件上传面板（拦截 present + 拦截图片选择结果）
  s.subspec 'UIViewController' do |ss|
    ss.source_files = "CJHook/UIViewController/**/*.{h,m}"
    ss.dependency "CJBaseHelper/UIViewControllerCJHelper"
  end

  # hook:防止按钮重复点击
  s.subspec 'UIButton' do |ss|
    ss.source_files = "CJHook/UIButton/**/*.{h,m}"
  end



end
