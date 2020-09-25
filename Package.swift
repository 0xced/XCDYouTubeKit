// swift-tools-version:5.1
import PackageDescription

let package = Package(
    name: "XCDYouTubeKit",
    products: [
        .library(name: "XCDYouTubeKit", targets: ["XCDYouTubeKit"])
    ],
    targets: [
        .target(
            name: "XCDYouTubeKit",
            path: ".",
            exclude: [
                "XCDYouTubeKit/Info.plist",
                "XCDYouTubeKit/Configuration.plist",
                "XCDYouTubeKit/AppledocSettings.plist"
            ],
            sources: ["XCDYouTubeKit"],
            publicHeadersPath: "XCDYouTubeKit"
        )
    ]
)
