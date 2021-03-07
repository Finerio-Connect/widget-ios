Pod::Spec.new do |s|
  s.name                  = "FinerioAccountWidget"
  s.version               = "1.0.0"
  s.swift_version         = '5.0'
  s.summary               = "Finerio Connect Widget"
  s.homepage              = "https://finerioconnect.com"
  s.license               = { :type => "GLP", :file => "LICENSE" }
  s.author                = "Finerio Connect"
  s.source                = { :git => "https://github.com/Finerio-Connect/widget-ios.git", :tag => s.version }
  
  s.default_subspec       = 'Sources'
  s.platform              = :ios, '11.0'

  s.subspec 'Sources' do |default|
    default.ios.deployment_target = '11.0'
    default.source_files          = ['FinerioConnectWidget/**/**/**.{h,m,swift}']
    default.resource_bundles      = {'FinerioConnectWidget' => ['FinerioConnectWidget/Resources/**/*.{lproj,json,png,xcassets,plist,strings}']}
  end
  
  s.dependency 'Firebase/Analytics', '~> 7.7.0'
  s.dependency 'Firebase/Database', '~> 7.7.0'
  s.dependency 'SwiftyRSA', '1.6.0'
  s.dependency 'lottie-ios', '3.2.1'
  
  s.requires_arc          = true
  s.pod_target_xcconfig   = {
      'FRAMEWORK_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/**',
      'HEADER_SEARCH_PATHS' => '$(inherited) $(PODS_ROOT)/**',
      'VALID_ARCHS' => 'armv7 arm64 x86_64',
      'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64'
    }
  s.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
end
