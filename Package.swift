// swift-tools-version:5.3
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
            exclude: ["./XCDYouTubeKit Tests",
                      "./XCDYouTubeKit Demo"
            ],
            sources: ["XCDYouTubeKit"],
            publicHeadersPath: "XCDYouTubeKit"
        )
    ]
)
