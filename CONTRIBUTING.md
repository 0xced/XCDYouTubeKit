## Submitting issues

* First of all, please [search](https://github.com/0xced/XCDYouTubeKit/issues) if your issue has already been filed.
* Read the [documentation](http://cocoadocs.org/docsets/XCDYouTubeKit/), the solution to your issue might be there.
* Make sure you are using the [latest version](https://github.com/0xced/XCDYouTubeKit/releases) of XCDYouTubeKit.
* State which version of XCDYouTubeKit you use in your report.
* State which version of the iOS or OS X SDK you use.
* State which device (or simulator) you use and the exact OS version in your report.
* If you encounter a crash, provide a stack trace. At the time of the crash, just type the `bt all` command in the (lldb) command prompt. If you got a crash report from HockeyApp or Crashlytics for example, include the stack trace too, preferably in textual form instead of a screenshot for easier searching.
* In your report, describe exactly
  * **what you did**
  * **what you expected**
  * **what you observed**

---

Here is an example of a good bug report:

  1. With the provided XCDYouTubeKit Demo app
  2. Using XCDYouTubeKit 2.0.3 and iOS SDK 8.0
  3. Running iPhone 4s simulator on iOS 7.1
  4. In the *Full Screen Player* view of the demo app, I entered the video identifier `EdeVaT-zZt44` and pressed the *Play Full Screen* button. The *Low Quality* switch was off.
  5. I expected the video *Better* from Apple to play.
  6. Instead, the player closed immediately with the following log in the Xcode console:

```
2015-01-11 14:50:40.994 XCDYouTubeKit iOS Demo[67501:60b] Finish Reason: Playback Error
Error Domain=XCDYouTubeVideoErrorDomain Code=2 "Invalid parameters." UserInfo=0x7a6955a0 {NSURL=https://www.youtube.com/get_video_info?el=detailpage&hl=en&ps=default&video_id=EdeVaT-zZt44, NSLocalizedDescription=Invalid parameters.}
```

(The problem here is that the video identifier is invalid: `EdeVaT-zZt44` with an extra `4` instead of `EdeVaT-zZt4`)

---

If your problem can not be demonstrated with the demo app, please provide a test app yourself. A link to a zipped Xcode project is fine but a GitHub repository with your test app is even better. You don’t need to provide your whole app. Create a test app with the very minimum code required in order to exhibit your problem. During the process of reducing your test app to the minimum, you are very likely to find the solution to your problem by yourself, try it!

## Submitting pull requests

* Please try to follow the coding style of the project as much as you can.
* Unless your pull request is a trivial fix such as a typo, please make sure to have a unit test covering your changes.
* I am using git flow, so it means that the current development happens on the `develop` branch. Please submit your pull requests on the `develop` branch. See also the GitHub guide on [Forking Projects](https://guides.github.com/activities/forking/).