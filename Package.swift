// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "XCDYouTubeKit",
    // platforms: [.iOS("8.0"), .macOS("10.10"), tvOS("9.0")],
    products: [
        .library(name: "XCDYouTubeKit", targets: ["XCDYouTubeKit"])
    ],
    targets: [
        .target(
            name: "XCDYouTubeKit",
            path: "XCDYouTubeKit"
        )
    ]
)
