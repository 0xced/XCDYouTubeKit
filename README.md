## About

**XCDYouTubeVideoPlayerViewController** is a YouTube video player for iPhone and iPad. 

<img src="Screenshots/XCDYouTubeVideoPlayerViewController.png" width="480" height="320">

To the best of my knowledge, the only *official* way of playing a YouTube video on iOS is with a UIWebView and the [iframe player API](https://developers.google.com/youtube/iframe_api_reference). Unfortunately, this is very slow and quite ugly, so I wrote XCDYouTubeVideoPlayerViewController which gives the user a better viewing experience.

XCDYouTubeVideoPlayerViewController uses progressive download, so remember that some restrictions apply if you submit your app to the App Store, as stated in 
[HTTP Live Streaming — Requirements for Apps](https://developer.apple.com/library/ios/documentation/NetworkingInternet/Conceptual/StreamingMediaGuide/UsingHTTPLiveStreaming/UsingHTTPLiveStreaming.html#//apple_ref/doc/uid/TP40008332-CH102-SW5):
> **Warning**: iOS apps submitted for distribution in the App Store must conform to these requirements.
> 
> If your app delivers video over cellular networks, and the video exceeds either 10 minutes duration or 5 MB of data in a five minute period, you are required to use HTTP Live Streaming. (Progressive download may be used for smaller clips.)

## Requirements

- Runs on iOS 5.0 and later
- Must be compiled with ARC

## Installation

XCDYouTubeVideoPlayerViewController is available through CocoaPods.

Alternatively, you can install it manually:

1. Copy the `XCDYouTubeVideoPlayerViewController.h` and `XCDYouTubeVideoPlayerViewController.m` files in your project.
2. Add `MediaPlayer.framework` and `AVFoundation.framework` in your project.

## Usage

Use `XCDYouTubeVideoPlayerViewController` the same way you use a `MPMoviePlayerViewController`, except you initialize it with a YouTube video identifier instead of a content URL.

#### Present the video in full-screen

```
XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"9bZkp7q19f0"];
[self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];
```

#### Fetch the video identifier asynchronously

```
XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [XCDYouTubeVideoPlayerViewController new];
[self presentMoviePlayerViewControllerAnimated:videoPlayerViewController];

NSURL *url = [NSURL URLWithString:@"https://gdata.youtube.com/feeds/api/standardfeeds/on_the_web?v=2&alt=json&max-results=1"];
[NSURLConnection sendAsynchronousRequest:[NSURLRequest requestWithURL:url] queue:[NSOperationQueue new] completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
	id json = [NSJSONSerialization JSONObjectWithData:data ?: [NSData new] options:0 error:NULL];
	NSString *videoIdentifier = [[[json valueForKeyPath:@"feed.entry.media$group.yt$videoid.$t"] lastObject] description];
	videoPlayerViewController.videoIdentifier = videoIdentifier;
}];
```

#### Present the video in a non full-screen view

```
XCDYouTubeVideoPlayerViewController *videoPlayerViewController = [[XCDYouTubeVideoPlayerViewController alloc] initWithVideoIdentifier:@"9bZkp7q19f0"];
[videoPlayerViewController presentInView:self.videoContainerView];
```

See the demo project for more sample code.

## Contact

Cédric Luthi

- http://github.com/0xced
- http://twitter.com/0xced
- cedric.luthi@gmail.com

## License

XCDYouTubeVideoPlayerViewController is available under the MIT license. See the LICENSE file for more information.