Pod::Spec.new do |s|
  s.name = "Dove"
  s.version = "1.0.0"
  s.summary = "Swift framework with helpful classes and extensions"
  s.homepage = "https://github.com/Contron/Dove"
  s.license = "MIT"
  s.author = { "Contron" => "https://github.com/Contron" }
  s.source = { :git => "https://github.com/Contron/Dove.git", :tag => s.version.to_s }
  s.platform = :ios, "9.0"
  s.source_files  = "Dove/**/*.{swift,h,m}"
end
