platform :ios, '8.0'
use_frameworks!

Example = 'Example/iOS Example.xcodeproj'
Example_ObjC = 'Example-ObjC/iOS Example Obj-C.xcodeproj'
OpenLocate = 'OpenLocate.xcodeproj'

workspace 'OpenLocate'
project Example

def fabric_pods
  pod 'Fabric'
  pod 'Crashlytics'
end
 
target 'iOS Example' do
  fabric_pods
  pod 'SwiftLint'
  pod 'Alamofire'
end

target 'iOS Example Obj-C' do
  project Example_ObjC
  fabric_pods
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '4.0'
        end
    end
end
