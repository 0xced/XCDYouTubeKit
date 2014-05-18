Pod::Spec.new do |s|
  s.name                  = "XCDYouTubeKit"
  s.version               = "1.1.2"
  s.summary               = "YouTube video player for iOS and OS X."
  s.homepage              = "https://github.com/0xced/XCDYouTubeVideoPlayerViewController"
  s.screenshot            = "https://raw.github.com/0xced/XCDYouTubeVideoPlayerViewController/#{s.version}/Screenshots/XCDYouTubeVideoPlayerViewController.png"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "Cédric Luthi" => "cedric.luthi@gmail.com" }
  s.social_media_url      = "https://twitter.com/0xced"
  s.source                = { :git => "https://github.com/0xced/XCDYouTubeVideoPlayerViewController.git", :tag => s.version.to_s }
  s.ios.deployment_target = "5.0"
  s.osx.deployment_target = "10.7"
  s.source_files          = "XCDYouTubeKit"
  s.public_header_files   = "XCDYouTubeKit/XCDYouTube{Client,Error,Operation,Video,VideoOperation,VideoPlayerViewController}.h"
  s.osx.exclude_files     = "XCDYouTubeKit/XCDYouTubeVideoPlayerViewController.{h,m}"
  s.ios.frameworks        = "JavaScriptCore", "MediaPlayer"
  s.osx.frameworks        = "JavaScriptCore"
  s.requires_arc          = true
end
