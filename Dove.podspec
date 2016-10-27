Pod::Spec.new do |specification|
  specification.name = "Dove"
  specification.version = "1.0.0"
  specification.description = "Swift framework with helpful classes and extensions"
  specification.homepage = "https://github.com/Contron/Dove"
  specification.license = { :type => "MIT", :file => "LICENSE" }
  specification.authors = { "Contron" => "https://github.com/Contron" }
  specification.source = { :git => "https://github.com/Contron/Dove.git" }
  specification.source_files = "Dove", "*.swift", "*.{h,m}"
end
