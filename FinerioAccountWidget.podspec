Pod::Spec.new do |s|
  s.name                  = 'FinerioAccountWidget'
  s.version               = '2.5.3'
  s.swift_version         = '5.0'
  s.summary               = 'Finerio Connect Widget'
  s.homepage              = 'https://finerioconnect.com'
  s.license               = { :type => "GLP", :file => "LICENSE" }
  s.author                = 'Finerio Connect'
  s.source                = { :git => 'https://github.com/Finerio-Connect/widget-ios.git', :tag => s.version }
  
  s.default_subspec       = 'Sources'
  s.platform              = :ios, '11.0'

  s.subspec 'Sources' do |default|
    default.ios.deployment_target = '11.0'
    default.source_files          = ['FinerioConnectWidget/**/**/**.{h,m,swift}']
    default.resource_bundles      = {'FinerioConnectWidget' => ['FinerioConnectWidget/Resources/**/*.{lproj,json,png,xcassets,plist,strings,ttf}']}
  end
  
  s.dependency 'Firebase/Analytics'
  s.dependency 'Firebase/Database'
  s.dependency 'SwiftyRSA'
  s.dependency 'lottie-ios'
  s.dependency 'Mixpanel-swift'
  s.dependency 'ZendeskSDKMessaging'
  
  s.requires_arc          = true
end
