  #验证方法1：pod lib lint CJComplexUIKit.podspec --sources='https://github.com/CocoaPods/Specs.git,https://gitee.com/dvlproad/dvlproadSpecs' --allow-warnings --use-libraries --verbose
  #验证方法2：pod lib lint CJComplexUIKit.podspec --sources=cocoapods,gitee-dvlproad-dvlproadspecs --allow-warnings --use-libraries --verbose
  #提交方法： pod trunk push CJComplexUIKit.podspec --sources=cocoapods,gitee-dvlproad-dvlproadspecs --allow-warnings --use-libraries --verbose

Pod::Spec.new do |s|
  #验证方法：pod lib lint CJComplexUIKit.podspec --sources=cocoapods,gitee-dvlproad-dvlproadspecs --allow-warnings --use-libraries --verbose
  s.name         = "CJComplexUIKit"
  s.version      = "0.4.0"
  s.summary      = "自定义的稍微复杂的UI( 内部有 CJUploadImageCollectionView 依赖到了私有的 CQImageAddDeleteListKit )"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 自定义的稍微复杂的UI，可按需独立引入：
                 • CJComplexUIKit/CJCollectionView/CJBaseCollectionViewCell - 集合单元格
                 • CJComplexUIKit/CJDataScrollView/ImagePickerCollectionlView - 图片选择集合视图

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

  s.platform     = :ios, "9.0"
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJComplexUIKit_0.4.0" }
  # s.source_files  = "CJComplexUIKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"

    # 与 UICollectionView 相关的基础类
  s.subspec 'CJCollectionView' do |ss|
    ss.subspec 'CJBaseCollectionViewCell' do |sss|
      sss.source_files = "CJComplexUIKit/CJCollectionView/CJBaseCollectionViewCell/**/*.{h,m}"
    end
  end

  # 带数据的列表视图或集合视图(常用于搜索、图片选择)
  s.subspec 'CJDataScrollView' do |ss|
    ss.subspec 'ImagePickerCollectionlView' do |sss|
      sss.source_files = "CJComplexUIKit/CJDataScrollView/ImagePickerCollectionlView/**/*.{h,m}"
      #sss.resources = "CJComplexUIKit/CJDataScrollView/ImagePickerCollectionlView/**/*.{png,xib,bundle}"
      sss.resource_bundle = {
        'CJComplexUIKit_ImagePickerCollectionlView' => ['CJComplexUIKit/CJDataScrollView/ImagePickerCollectionlView/**/*.{png,xib,bundle}'] # CJComplexUIKit_ImagePickerCollectionlView 为生成boudle的名称，随便起，记下，下面要用
      }

      sss.frameworks = "MediaPlayer"

      # 图片选择功能需要依赖的库
      sss.dependency 'JGActionSheet'
      sss.dependency 'CJComplexUIKit/CJCollectionView/CJBaseCollectionViewCell'

      sss.dependency 'CQImageAddDeleteListKit/AddDeletePickUpload'
      sss.dependency 'CJNetwork/AFNetworkingUploadComponent'
    end
  end


end
