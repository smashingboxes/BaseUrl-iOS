#
#  Be sure to run `pod spec lint BaseUrl-iOS.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
  s.name         = "BaseUrl-iOS"
  s.version      = "0.0.1"
  s.summary      = "Specify a base URL for your app with facility to change it in-app using a debug modal"
  s.platform      = :ios, "8.0"
  #s.description  = <<-DESC
  #                 DESC

  s.homepage     = "https://github.com/smashingboxes/BaseUrl-iOS"
  s.license      = "MIT"
  s.author       = { "David Sweetman" => "davids@smashingboxes.com" }
  s.source       = { :git => "https://github.com/smashingboxes/BaseUrl-iOS.git", :tag => "0.0.1" }

  s.source_files = "BaseUrl/**/*.{swift}"
  s.framework    = "UIKit"
end
