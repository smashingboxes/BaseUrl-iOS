Pod::Spec.new do |s|
  s.name         = "BaseUrl"
  s.version      = "0.0.3"
  s.summary      = "Specify a base URL for your app with facility to change it in-app using a debug modal"
  s.platform      = :ios, "8.0"
  #s.description  = <<-DESC
  #                 DESC

  s.homepage     = "https://github.com/smashingboxes/BaseUrl-iOS"
  s.license      = "MIT"
  s.author       = { "David Sweetman" => "davids@smashingboxes.com" }
  s.source       = { :git => "https://github.com/smashingboxes/BaseUrl-iOS.git", :tag => "0.0.3" }

  s.source_files = "BaseUrl/**/*.{swift}"
  s.framework    = "UIKit"
end