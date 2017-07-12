# Uncomment the next line to define a global platform for your project

# platform :ios, '10.0'

plugin 'cocoapods-keys', {
    :project => 'Moviestar',
    :keys => [
    'MovieStarAPIClientSecret',
    'MovieStarAPIClientID'
    ]
}


target 'moviestar' do
  
  use_frameworks!

  # Pods for moviestar

   pod 'SwiftGen'
   pod 'Marshal'
   pod 'RxSwift'
   pod 'NSObject+Rx'
   pod 'RxCocoa'
   pod 'Moya/RxSwift'
   pod 'Action'
   pod 'Kingfisher'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
    end
  end
end
