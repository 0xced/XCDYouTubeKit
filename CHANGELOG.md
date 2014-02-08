#### Version 1.2.0

* Refactors YouTube URL extraction code into separate class.

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

#### Version 1.0

* Initial version
