$minSupportedOS = '11.0'
platform :ios, $minSupportedOS
install! 'cocoapods', :disable_input_output_paths => true

use_frameworks!
inhibit_all_warnings!

target 'FinerioConnectWidget' do
  pod 'Firebase/Analytics', '~> 8.0.0'
  pod 'Firebase/Database', '~> 8.0.0'
  pod 'SwiftyRSA', '1.6.0'
  pod 'lottie-ios', '3.2.3'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|

        # Stop a app store connect error "Too many symbols"
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $minSupportedOS
    end
  end
end
