import XCDYouTubeKit
#if swift(>=3.0)
	import PlaygroundSupport
#else
	import XCPlayground
	typealias Error = NSError
#endif

setenv("XCDYouTubeKitLogLevel", "0", 1)

var client = XCDYouTubeClient(languageIdentifier: "en")

client.getVideoWithIdentifier("6v2L2UGZJAM") { (video: XCDYouTubeVideo?, error: Error?) -> Void in
	video
	error?.localizedDescription
}

client.getVideoWithIdentifier("xxxxxxxxxxx") { (video: XCDYouTubeVideo?, error: Error?) -> Void in
	video
	error?.localizedDescription
}

#if swift(>=3.0)
	PlaygroundPage.current.needsIndefiniteExecution = true
#else
	XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
#endif
