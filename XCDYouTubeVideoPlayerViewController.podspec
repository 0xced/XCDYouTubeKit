Pod::Spec.new do |s|
  s.name         = "XCDYouTubeVideoPlayerViewController"
  s.version      = "1.2.0"
  s.summary      = "YouTube video player for iPhone and iPad."
  s.homepage     = "https://github.com/0xced/XCDYouTubeVideoPlayerViewController"
  s.license      = 'MIT'
  s.author       = { "Cédric Luthi" => "cedric.luthi@gmail.com" }
  s.source       = { :git => "https://github.com/0xced/XCDYouTubeVideoPlayerViewController.git", :tag => s.version.to_s }
  s.requires_arc = true
  s.ios.deployment_target = '5.0'
  s.osx.deployment_target = '10.6'

  s.subspec 'Extractor' do |extractor|
    extractor.source_files = 'XCDYouTubeVideoPlayerViewController/{XCDYouTubeExtractor,XCDYouTubeConstants}.{h,m}'
  end

  s.subspec 'iOSVideoPlayer' do |video|
    video.platform = :ios, '5.0'
    video.ios.source_files = 'XCDYouTubeVideoPlayerViewController/XCDYouTubeVideoPlayerViewController.{h,m}'
    video.osx.source_files = ''
    video.dependency 'XCDYouTubeVideoPlayerViewController/Extractor'
    video.ios.frameworks = 'AVFoundation', 'MediaPlayer'
  end
end
