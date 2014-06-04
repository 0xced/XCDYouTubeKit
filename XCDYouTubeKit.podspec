Pod::Spec.new do |s|
  s.name                  = "XCDYouTubeKit"
  s.version               = "1.1.2"
  s.summary               = "YouTube video player for iOS and OS X."
  s.homepage              = "https://github.com/0xced/XCDYouTubeKit"
  s.screenshot            = "https://raw.github.com/0xced/XCDYouTubeKit/#{s.version}/Screenshots/XCDYouTubeVideoPlayerViewController.png"
  s.license               = { :type => "MIT", :file => "LICENSE" }
  s.author                = { "Cédric Luthi" => "cedric.luthi@gmail.com" }
  s.social_media_url      = "https://twitter.com/0xced"
  s.source                = { :git => "https://github.com/0xced/XCDYouTubeKit.git", :tag => s.version.to_s }
  s.ios.deployment_target = "5.0"
  s.osx.deployment_target = "10.7"
  s.source_files          = "XCDYouTubeKit"
  s.public_header_files   = "XCDYouTubeKit/XCDYouTube{Client,Error,Kit,Operation,Video,VideoOperation,VideoPlayerViewController}.h"
  s.osx.exclude_files     = "XCDYouTubeKit/XCDYouTubeVideoPlayerViewController.{h,m}"
  s.ios.frameworks        = "MediaPlayer"
  s.ios.xcconfig          = { "OTHER_LDFLAGS" => "-Wl,-U,_JSEvaluateScript -Wl,-U,_JSGlobalContextCreate -Wl,-U,_JSGlobalContextRelease -Wl,-U,_JSObjectCallAsFunction -Wl,-U,_JSObjectIsFunction -Wl,-U,_JSStringCopyCFString -Wl,-U,_JSStringCreateWithCFString -Wl,-U,_JSStringRelease -Wl,-U,_JSValueIsObject -Wl,-U,_JSValueIsString -Wl,-U,_JSValueMakeString -Wl,-U,_JSValueToStringCopy" }
  s.osx.frameworks        = "JavaScriptCore"
  s.requires_arc          = true
end
