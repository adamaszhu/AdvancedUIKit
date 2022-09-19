Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '9.0'
s.name = "AdvancedUI"
s.summary = "AdvancedUIKit contains utility UI functions built on top of UIKit framework."
s.requires_arc = true
s.version = "1.9.11"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Adamas Zhu" => "developer@adamaszhu.com" }
s.homepage = "https://github.com/adamaszhu/AdvancedUIKit"
s.source = { :git => "https://github.com/adamaszhu/AdvancedUIKit.git",
             :tag => "#{s.version}" }
s.frameworks = "Foundation", "UIKit"
s.dependency 'AdvancedFoundation', '~> 1.8.6'
s.source_files = "AdvancedUIKit/**/*.{swift}"
s.resources = "AdvancedUIKit/**/*.{strings}"
s.swift_version = "5"

end
