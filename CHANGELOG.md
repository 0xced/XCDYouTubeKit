#### Version 1.1.1

* For errors of the `XCDYouTubeVideoErrorDomain` domain, `-[NSError localizedDescription]` is actually localized and doesn’t contain HTML tags, making it suitable for displaying to the user.

#### Version 1.1.0

* Video metadata information (thumbnails and title) is provided through `XCDYouTubeVideoPlayerViewControllerDidReceiveMetadataNotification`. (#1)
* Workaround a case where the status bar could disappear after the video ends playback. (#3)
* Error reporting is more accurate, especially for VEVO videos. (#6)
* `prepareToPlay` is not automatically called, it’s the programmer responsibility to call it if appropriate.

#### Version 1.0

* Initial version
