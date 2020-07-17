Pod::Spec.new do |s|
  s.name             = 'SwiftDateTime'
  s.version          = '0.1.4'
  s.summary          = 'Library to work with dates and times'
  s.homepage         = 'https://github.com/dmitriykotenko/SwiftDateTime'
  s.license          = { :type => 'MIT', :file => 'License' }
  s.author           = { 'Dmitry Kotenko' => 'd.kotenko@yandex.ru' }
  s.source           = { :git => 'https://github.com/dmitriykotenko/SwiftDateTime.git',
                         :tag => s.version.to_s }
  s.source_files     = 'Sources/**/*.swift'
  s.frameworks       = 'Foundation'
  s.requires_arc     = true
  s.swift_version    = "5.0"

  s.ios.deployment_target = '11.0'
end
