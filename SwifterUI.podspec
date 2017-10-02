Pod::Spec.new do |s|
  s.name             = 'SwifterUI'
  s.version          = '0.2.3'
  s.summary          = 'UI Library made with Texture'
 
  s.description      = 'This is a UI Library'
 
  s.homepage         = 'https://github.com/BrandonMA/SwifterUI'
  s.license          = { :type => 'Apache-2.0', :file => 'LICENSE' }
  s.author           = { '<Brandon>' => '<maldonado.brandon177@gmail.com>' }
  s.source           = { :git => 'https://github.com/BrandonMA/SwifterUI.git', :tag => s.version.to_s }
 
  s.ios.deployment_target = '11.0'
  s.pod_target_xcconfig = { 'SWIFT_VERSION' => '3.2' }
  s.source_files = 'SwifterUI/SwifterUI/SwifterUI/*.swift'
  s.dependency 'Texture'
  s.dependency 'YouTubePlayer'
 
end