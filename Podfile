$minSupportedOS = '11.0'
platform :ios, $minSupportedOS
install! 'cocoapods', :disable_input_output_paths => true

use_frameworks!
inhibit_all_warnings!

target 'FinerioConnectWidget' do
  pod 'Firebase/Analytics'
  pod 'Firebase/Database'
  pod 'SwiftyRSA'
  pod 'lottie-ios'
  pod 'Mixpanel-swift'
  pod 'ZendeskSDKMessaging'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|

        # Stop a app store connect error "Too many symbols"
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = $minSupportedOS
    end
  end
end
