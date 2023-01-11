#
# Be sure to run `pod lib lint Design.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'Design'
  s.version          = '0.1.1'
  s.summary          = 'A short description of Design.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/13129840/Design'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '13129840' => 'linh.hd@neo-lab.vn' }
  s.source           = { :git => 'https://github.com/13129840/Design.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'Design/**/*.{swift}'
  
  s.resource_bundles = {
      'Design' => ['Design/**/*.{xib,strings,ttf,otf,png,jpg}']
  }
  
  s.resources = ['Design/**/*.{xcassets}']

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'Extension'
  s.dependency 'PopupDialog'
  s.dependency 'RxDataSources'
  s.dependency 'MJRefresh'
  s.dependency 'SideMenu'
  s.dependency 'FontBlaster'
end
