source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '13.0'
inhibit_all_warnings!
use_frameworks!

def pods_project

  # Networking
  
  pod 'atlantis-proxyman', '1.12.0', :configurations => ['Debug']

  # CLI
  
  pod 'SwiftFormat/CLI', '0.49.3', :configurations => ['Debug']

end

target 'SurfEducationProject' do

  pods_project

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '5.0'
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end