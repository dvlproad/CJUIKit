Pod::Spec.new do |s|
  s.name         = "CommonFMDBUtil"
  s.version      = "0.0.5"
  s.summary      = "一个FMDB数据库文件的管理和使用.在0.0.5版本这里停止使用，并改为pod‘CJFile/CJFMDBFileManager’"
  s.homepage     = "https://github.com/dvlproad/CJDatabase"
  s.license      = "MIT"
  s.author             = { "dvlproad" => "studyroad@qq.com" }
  # s.social_media_url   = "http://twitter.com/dvlproad"

  s.platform     = :ios, "7.0"

  s.source       = { :git => "https://github.com/dvlproad/CJDatabase.git", :tag => "CJFile_0.0.2" }
  s.source_files  = "CJFile/*.{h,m}"
  s.frameworks = 'UIKit'

  s.deprecated = true

end
