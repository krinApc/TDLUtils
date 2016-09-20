Pod::Spec.new do |s|
  s.name         = "TDLUtils"
  s.version      = "1.0"
  s.summary      = "Some common classes created by TDL."
  s.homepage     = "https://github.com/krinApc/TDLUtils"
  s.license      = "MIT"
  s.author       = { "k_rin" => "k_rin@ap-com.co.jp" }
  s.platform     = :ios, '7.0'
  s.source       = { :git => "https://github.com/krinApc/TDLUtils.git", :tag => "1.0" }
  s.source_files = "Classes", "Classes/**/*.{h,m}"
  s.requires_arc = true
end
