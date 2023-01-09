use_frameworks!
inhibit_all_warnings!
platform :ios, '13.0'

workspace 'SwiftBase'

project 'SwiftBase/SwiftBase.xcodeproj'

target 'SwiftBase' do
    project 'SwiftBase/SwiftBase.xcodeproj'
    pod 'Design', :path => './Design'
    pod 'Services', :path => './Services'
    pod 'Domain', :path => './Domain'
    pod 'Data', :path => './Data'
    pod 'Extension', :path => './Extension'
    pod 'SwiftLint'
end

target 'SwiftBaseTests' do
    project 'SwiftBase/SwiftBase.xcodeproj'
    pod 'RxSwift', '6.5.0'
    pod 'Quick', '2.2.0'
    pod 'Nimble', '10.0.0'
    pod 'RxTest', '6.5.0'
    pod 'Domain', :path => './Domain'
    pod 'Services', :path => './Services'
    pod 'Data', :path => './Data'
    pod 'Extension', :path => './Extension'
end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['GCC_WARN_INHIBIT_ALL_WARNINGS'] = "YES"
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
            config.build_settings['ONLY_ACTIVE_ARCH'] = 'NO'
            config.build_settings['ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES'] = 'NO'
        end
    end
end
