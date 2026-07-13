Pod::Spec.new do |s|
  #验证方法：pod lib lint CJComplexUIKit.podspec --allow-warnings --use-libraries --verbose
  s.name         = "CJComplexUIKit"
  s.version      = "0.3.0"
  s.summary      = "自定义的稍微复杂的UI"
  s.homepage     = "https://github.com/dvlproad/CJUIKit"

  s.description  = <<-DESC
                 自定义的稍微复杂的UI，可按需独立引入：

                 • CJComplexUIKit/CJScrollView - 滚动视图：自定义的基础滚动视图
                 
                 • CJComplexUIKit/CJCollectionView - 自定义的集合视图
                 • CJComplexUIKit/CJCollectionView/CJBaseCollectionViewCell - 集合单元格
                 • CJComplexUIKit/CJCollectionView/CJCollectionViewLayout - 集合视图布局
                 • CJComplexUIKit/CJCollectionView/MyEqualCellSizeCollectionView - 一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)

                 • CJComplexUIKit/CJDataScrollView - 带数据的列表视图或集合视图(常用于搜索、图片选择)
                 • CJComplexUIKit/CJDataScrollView/SearchScrollView - 搜索滚动视图
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

  s.platform     = :ios, "8.0"
 
  s.source       = { :git => "https://github.com/dvlproad/CJUIKit.git", :tag => "CJComplexUIKit_0.3.0" }
  s.source_files  = "CJComplexUIKit/*.{h,m}"

  s.frameworks = "UIKit"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"


  # 与 UIScrollView 相关的基础类
  s.subspec 'CJScrollView' do |ss|
    ss.source_files = "CJComplexUIKit/CJScrollView/**/*.{h,m}"
  end


    # 与 UICollectionView 相关的基础类
  s.subspec 'CJCollectionView' do |ss|
    ss.subspec 'CJBaseCollectionViewCell' do |sss|
      sss.source_files = "CJComplexUIKit/CJCollectionView/CJBaseCollectionViewCell/**/*.{h,m}"
    end

    ss.subspec 'CJCollectionViewLayout' do |sss|
      sss.source_files = "CJComplexUIKit/CJCollectionView/CJCollectionViewLayout/**/*.{h,m}"
    end

    # 各种集合视图
    # 一个只有一个分区且分区中的每个cell大小相等的集合视图(cell的大小可通过方法①设置cell的固定大小和方法②通过设置每行最大显示的cell个数获得)
    ss.subspec 'MyEqualCellSizeCollectionView' do |sss|
      sss.source_files = "CJComplexUIKit/CJCollectionView/MyEqualCellSizeCollectionView/**/*.{h,m}"
    end

  end

  # 带数据的列表视图或集合视图(常用于搜索、图片选择)
  s.subspec 'CJDataScrollView' do |ss|
    ss.subspec 'SearchScrollView' do |sss|
      sss.source_files = "CJComplexUIKit/CJDataScrollView/SearchScrollView/**/*.{h,m}"

      # 搜索功能需要依赖的库
      sss.dependency 'CJComplexUIKit/CJCollectionView/MyEqualCellSizeCollectionView'
      sss.dependency 'CJBaseUtil/CJDataUtil'
      sss.dependency 'JGActionSheet'
    end

    ss.subspec 'ImagePickerCollectionlView' do |sss|
      sss.source_files = "CJComplexUIKit/CJDataScrollView/ImagePickerCollectionlView/**/*.{h,m}"
      #sss.resources = "CJComplexUIKit/CJDataScrollView/ImagePickerCollectionlView/**/*.{png,xib,bundle}"
      sss.resource_bundle = {
        'CJComplexUIKit_ImagePickerCollectionlView' => ['CJComplexUIKit/CJDataScrollView/ImagePickerCollectionlView/**/*.{png,xib,bundle}'] # CJComplexUIKit_ImagePickerCollectionlView 为生成boudle的名称，随便起，记下，下面要用
      }

      sss.frameworks = "MediaPlayer"

      # 图片选择功能需要依赖的库
      sss.dependency 'JGActionSheet'
      sss.dependency 'CJComplexUIKit/CJCollectionView/MyEqualCellSizeCollectionView'
      sss.dependency 'CJComplexUIKit/CJCollectionView/CJBaseCollectionViewCell'

      sss.dependency 'CQImageAddDeleteListKit/AddDeletePickUpload'
      sss.dependency 'CJNetwork/AFNetworkingUploadComponent'
    end

    
  end





end
