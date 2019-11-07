// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "XCDYouTubeKit",
    products: [
        .library(name: "XCDYouTubeKit" , targets: ["XCDYouTubeKit"])
    ],
    targets: [
        .target(
            name: "XCDYouTubeKit",
            path: ".",
            exclude: ["Screenshots",
                      "Scripts",
                      "XCDYouTubeKit Demo",
                      "XCDYouTubeKit/AppledocSettings.plist",
                      "XCDYouTubeKit/Configuration.plist",
                      "XCDYouTubeKit/Info.plist"
            ],
            sources: ["XCDYouTubeKit"],
            publicHeadersPath: "XCDYouTubeKit"
        )
    ]
)
