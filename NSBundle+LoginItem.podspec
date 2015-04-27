Pod::Spec.new do |s|
  s.name             = "NSBundle+LoginItem"
  s.version          = "1.0.3"
  s.summary          = "A NSBundle category for adding / removing the bundle to LoginItems"
  s.homepage         = "https://github.com/nklizhe/NSBundle-LoginItem"
  s.license          = 'MIT'
  s.author           = { "Tom Li" => "nklizhe@gmail.com" }
  s.source           = { :git => "https://github.com/nklizhe/NSBundle-LoginItem.git", :tag => 'v1.0.3' }

  s.platform     = :osx, '10.6'
  s.requires_arc = true

  s.source_files = 'Pod/Classes'
  s.public_header_files = 'Pod/Classes/**/*.h'
end
