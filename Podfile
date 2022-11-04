# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'
inhibit_all_warnings!

target 'TheMovieDBSwift' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for TheMovieDBSwift
  pod 'R.swift'
  pod 'SwiftLint'
  pod 'Swinject'
  pod 'RxSwift'
  pod 'Moya'
  pod 'RealmSwift'
  pod 'RxRealm'
  pod 'Willow'
  pod 'Action'
  pod 'XCGLogger'
  pod 'ProgressHUD'
  pod 'SideMenu'
  pod 'SwiftPrettyPrint'
  pod 'RxDataSources'
  pod 'Kingfisher'
  pod 'SwifterSwift'
  pod 'RxSwiftExt'
  pod 'SwiftyJSON'
  
#  pod 'RxSwiftExt'
#  target 'TheMovieDBSwiftTests' do
#    inherit! :search_paths
#    # Pods for testing
#  end

end

post_install do |installer|
 installer.pods_project.targets.each do |target|
  target.build_configurations.each do |config|
   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
  end
 end
end
