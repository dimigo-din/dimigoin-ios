# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'dimigoin' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for dimigoin
  pod 'Firebase/Analytics'
  pod 'Firebase/Messaging'
end

target 'WidgetExtension' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for WidgetExtension

end

# post_install do |pi|
#   pi.pods_project.targets.each do |t|
#     t.build_configurations.each do |config|
#       config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
#     end
#   end
# end

post_install do |installer|
  installer.pods_project.targets.each do |target|
      if target.name.start_with?("Pods")
          puts "Updating #{target.name} OTHER_LDFLAGS to OTHER_LDFLAGS[sdk=iphone*]"
          target.build_configurations.each do |config|
              xcconfig_path = config.base_configuration_reference.real_path
              xcconfig = File.read(xcconfig_path)
              new_xcconfig = xcconfig.sub('OTHER_LDFLAGS =', 'OTHER_LDFLAGS[sdk=iphone*] =')
              File.open(xcconfig_path, "w") { |file| file << new_xcconfig }
          end
      end
  end
end