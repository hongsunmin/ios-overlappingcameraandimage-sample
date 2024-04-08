# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'ImageCompositingOverCamera' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for ImageCompositingOverCamera
  pod 'UIView+draggable'
  pod 'SwiftyCam'

  target 'ImageCompositingOverCameraTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'ImageCompositingOverCameraUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    puts "#{target.name}"
    target.build_configurations.each do |build_configuration|
      build_configuration.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
    end
  end
end
