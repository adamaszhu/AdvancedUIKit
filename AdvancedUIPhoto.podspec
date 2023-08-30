Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "AdvancedUIPhoto"
s.summary = "AdvancedUIKitPhoto contains photo functions built on top of AdvancedUIKit framework."
s.requires_arc = true
s.version = "1.9.26"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Adamas Zhu" => "developer@adamaszhu.com" }
s.homepage = "https://github.com/adamaszhu/AdvancedUIKit"
s.source = { :git => "https://github.com/adamaszhu/AdvancedUIKit.git",
             :tag => "#{s.version}" }
s.frameworks = "Foundation", "UIKit", "AdvancedUI"
s.dependency 'AdvancedFoundation', '~> 1.9.7'
s.dependency 'AdvancedUI', '~> 1.9.26'
s.source_files = "AdvancedUIKit/Camera/*.{swift}"
s.resources = "AdvancedUIKit/Camera/**/*.{strings}"
s.swift_version = "5"

end
