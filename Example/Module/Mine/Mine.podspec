

Pod::Spec.new do |s|
  s.name             = 'Mine'
  s.version          = '0.1.0'
  s.summary          = 'A short description of Find.'



  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com'
  
  #s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'liucaide' => '565726319@qq.com' }
  s.source           = { :git => '' }
  

  s.ios.deployment_target = '10.0'

  s.source_files = 'Classes/**/*'
  
  s.resource_bundles = {
    'Mine' => ['Nib/*.{storyboard,xib}']
    
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'CaamDau'
  s.dependency 'Router'
  s.dependency 'Utility'
  s.dependency 'SnapKit'
end
