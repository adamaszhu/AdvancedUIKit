platform :ios, '9.0'
use_frameworks!

source 'https://github.com/adamaszhu/AdvancedFoundationSpecs.git'

target 'AdvancedUIKit' do

  pod 'AdvancedFoundation', '~> 1.6.5'

  target 'AdvancedUIKitHost' do
    pod 'AdvancedFoundation', '~> 1.6.5'
  end

  target 'AdvancedUIKitTests' do
    pod 'Nimble', '8.1.2'
    pod 'Quick', '3.1.2'
  end

end

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
  end
 end
end
