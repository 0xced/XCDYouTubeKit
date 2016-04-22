Pod::Spec.new do |s|
  s.name                   = "XCDYouTubeKit"
  s.version                = "2.5.2"
  s.summary                = "YouTube video player for iOS and OS X."
  s.homepage               = "https://github.com/0xced/XCDYouTubeKit"
  s.screenshot             = "https://raw.github.com/0xced/XCDYouTubeKit/#{s.version}/Screenshots/XCDYouTubeVideoPlayerViewController.png"
  s.license                = { :type => "MIT", :file => "LICENSE" }
  s.author                 = { "Cédric Luthi" => "cedric.luthi@gmail.com" }
  s.social_media_url       = "https://twitter.com/0xced"
  s.source                 = { :git => "https://github.com/0xced/XCDYouTubeKit.git", :tag => s.version.to_s }
  s.ios.deployment_target  = "7.0"
  s.osx.deployment_target  = "10.9"
  s.tvos.deployment_target = "9.0"
  s.source_files           = "XCDYouTubeKit"
  s.public_header_files    = "XCDYouTubeKit/XCDYouTube{Client,Error,Kit,Logger,Operation,Video,VideoOperation,VideoPlayerViewController}.h"
  s.osx.exclude_files      = "XCDYouTubeKit/XCDYouTubeVideoPlayerViewController.{h,m}"
  s.tvos.exclude_files     = "XCDYouTubeKit/XCDYouTubeVideoPlayerViewController.{h,m}"
  s.ios.frameworks         = "JavaScriptCore", "MediaPlayer"
  s.osx.frameworks         = "JavaScriptCore"
  s.tvos.frameworks        = "JavaScriptCore"
  s.requires_arc           = true
end
