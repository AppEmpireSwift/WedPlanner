# Uncomment the next line to define a global platform for your project
platform :ios, '15.6'

target 'WedPlanner' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WedPlanner
  pod 'RealmSwift', '~> 10.38.0'  # Используем версию, которая совместима с iOS 15.6

end

# Настройка IPHONEOS_DEPLOYMENT_TARGET для совместимости
post_install do |installer|
  installer.pods_project.targets.each do |target|
    if target.name == 'Realm' or target.name == 'RealmSwift'
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end
end