#### Version 2.3.0

* Raised deployment target to iOS 7.0 and OS X 10.9.
* Xcode 7 support.
* Nullability annotations.
* Fixed CocoaPods integration issue with Xcode 7 beta. (#165)

#### Version 2.2.0

* Networking and parsing code is executed on a background thread for better performance. The `XCDYouTubeVideoOperation` class has changed from an asynchronous to a synchronous operation and must not be started on the main thread. (#147)
* Logging support, see the [README](README.md#logging) for documentation.
* Improved documentation.

#### Version 2.1.3

* Adaptation to YouTube API change. (#144)

#### Version 2.1.2

* Fixed playback of some protected videos. (#122)
* Fixed playback of some age restricted videos. (#137)

#### Version 2.1.1

* Adaptation to YouTube API change. (#116)

#### Version 2.1.0

* New `expirationDate` property on the `XCDYouTubeVideo` class. (#96)
* Create proper (non generic) Xcode archives when integrated manually. (#102)
* Adaptation to YouTube API change. (#105)
* Fixed protected age restricted videos.

#### Version 2.0.3

* Adaptation to YouTube API change. (#94)
* Support for age restricted videos.
* Project upgraded to Xcode 6.

#### Version 2.0.2

* Fixed errors on protected videos. (#52)
* Better error reporting if a protected video is not available.
* Updated README about YouTube Terms of Service.

#### Version 2.0.1

* Fixed crash on protected videos. (#46)
* Ensure that the video doesn’t disappear after locking the device. (#36)
* Demo app: do not crash when going to background very quickly after presenting a video. (#44)

#### Version 2.0.0

* Project renamed to `XCDYouTubeKit`.
* Support for protected videos. (#6, #11, #12, #21, #27, #31, #33)
* OS X compatibility thanks to the new `XCDYouTubeClient` class. (#14, #18)
* OS X dynamic framework target
* Support for live videos. (#34)
* Unit tested.
* [Fully documented](http://cocoadocs.org/docsets/XCDYouTubeKit/).
* Support for iOS 8 beta.
* Improved demo projects.
  * New OS X demo project.
  * New settings screen on iOS for background playback and audio session category.
  * Demonstrates how to use the notifications to fill the *Now Playing Info Center*.

#### Version 1.1.2

* Adaptation to YouTube API change. (#19)

#### Version 1.1.1

* For errors of the `XCDYouTubeVideoErrorDomain` domain, `-[NSError localizedDescription]` is actually localized and doesn’t contain HTML tags, making it suitable for displaying to the user.
* Setting the `preferredVideoQualities` property to nil restores its default values.
* Added some documentation in the XCDYouTubeVideoPlayerViewController header file.
* XCDYouTubeVideoPlayerViewController is built as a static library.
* Better demo project with one feature illustrated per view controller.
* iOS 7 compatible demo project.

#### Version 1.1.0

* Video metadata information (thumbnails and title) is provided through `XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification`. (#1)
* Workaround a case where the status bar could disappear after the video ends playback. (#3)
* Error reporting is more accurate, especially for VEVO videos. (#6)
* `prepareToPlay` is not automatically called, it’s the programmer responsibility to call it if appropriate.

#### Version 1.0.0

* Initial version
