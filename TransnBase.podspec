#
# Be sure to run `pod lib lint TransnBase.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'TransnBase'
  s.version          = '0.1.0'
  s.summary          = 'A short description of TransnBase.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/huqigu/TransnBase'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'huqigu' => 'huqigu@163.com' }
  s.source           = { :git => 'https://github.com/huqigu/TransnBase.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'TransnBase/*.{h,m}'
  
  s.resource = 'TransnBase/Assets/TransnBase.bundle'
  
  s.subspec 'Public' do |ps|
    ps.source_files = 'TransnBase/Public/*.{h,m}'
    ps.public_header_files = 'TransnBase/Public/*.h'
  end
  
  s.subspec 'Manager' do |ms|
    ms.source_files = 'TransnBase/Manager/*.{h,m}'
    ms.public_header_files = 'TransnBase/Manager/*.h'
  end
  
  s.subspec 'Kit' do |ks|
    ks.source_files = 'TransnBase/Kit/*/*.{h,m}'
    ks.public_header_files = 'TransnBase/Kit/*/*.h'
  end
  
  s.subspec 'Extension' do |es|
    es.source_files = 'TransnBase/Extension/*.{h,m}'
    es.public_header_files = 'TransnBase/Extension/*.h'
  end
  
  s.subspec 'ViewModel' do |vs|
    vs.source_files = 'TransnBase/ViewModel/*.{h,m}'
    vs.public_header_files = 'TransnBase/ViewModel/*.h'
  end
  
  s.subspec 'Model' do |ms|
    ms.source_files = 'TransnBase/Model/*.{h,m}'
    ms.public_header_files = 'TransnBase/Model/*.h'
  end
  
  s.subspec 'Net' do |ns|
    ns.source_files = 'TransnBase/Net/*.{h,m}'
    ns.public_header_files = 'TransnBase/Net/*.h'
  end
  
  s.subspec 'Utilities' do |us|
    us.source_files = 'TransnBase/Utilities/*.{h,m}'
    us.public_header_files = 'TransnBase/Utilities/*.h'
  end
  
  s.subspec 'Global' do |gs|
    gs.source_files = 'TransnBase/Global/*.{h,m}'
    gs.public_header_files = 'TransnBase/Global/*.h'
  end
  
  s.subspec 'Agent' do |as|
    as.source_files = 'TransnBase/Agent/*.{h,m}'
    as.public_header_files = 'TransnBase/Agent/*.h'
  end
  
  # s.resource_bundles = {
  #   'TransnBase' => ['TransnBase/Assets/*.{xib,png,xcassets}']
  # }

  s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit'
  s.dependency 'MJExtension' , '~>  3.3.0'
  s.dependency 'RTRootNavigationController' , '~>  0.8.0'
  s.dependency 'Masonry'
end
