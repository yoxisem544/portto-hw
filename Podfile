# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Homework' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Homework
  pod 'Kingfisher'
  pod "KingfisherWebP"
  pod "SVGKit"
  pod 'Moya'
  pod 'Moya/RxSwift'
  pod 'RxSwift'
  pod 'RxCocoa'
  pod 'RxRelay'
  pod "BigInt"

end

post_install do |installer|

  installer.generated_projects.each do |project|
    project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
            end
        end
    end
end