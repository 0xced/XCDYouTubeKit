import XCPlayground
import XCDYouTubeKit

setenv("XCDYouTubeKitLogLevel", "0", 1)

var client = XCDYouTubeClient(languageIdentifier: "en")

client.getVideoWithIdentifier("6v2L2UGZJAM") { (video: XCDYouTubeVideo?, error: NSError?) -> Void in
	video
	error?.localizedDescription
}

client.getVideoWithIdentifier("xxxxxxxxxxx") { (video: XCDYouTubeVideo?, error: NSError?) -> Void in
	video
	error?.localizedDescription
}

XCPlaygroundPage.currentPage.needsIndefiniteExecution = true
