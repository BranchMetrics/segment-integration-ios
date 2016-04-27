#
# Be sure to run `pod lib lint Segment-Tune.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "Segment-Tune"
  s.version          = "1.0.0"
  s.summary          = "Tune Integration for Segment iOS SDK."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                       Analytics for iOS provides a single API that lets you
                       integrate with over 100s of tools.

                       This is the TUNE integration for the iOS library.
                       DESC

  s.homepage         = "https://github.com/MobileAppTracking/segment-integration-ios"
  s.license          = 'MIT'
  s.author           = { "TUNE" => "mobile@tune.com" }
  s.source           = { :git => "https://github.com/MobileAppTracking/segment-integration-ios.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tune'

  s.ios.deployment_target = '8.0'

  s.source_files = 'Segment-Tune/Classes/**/*'

  s.public_header_files = 'Segment-Tune/Classes/**/*.h'

  s.dependency 'Analytics', '~> 3.0.0'
  s.dependency 'Tune', '~> 4.2.0'
end
