// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "WStack",
    platforms: [
        .iOS(.v16),
        .watchOS(.v6),
        .tvOS(.v16),
        .macOS(.v14)
    ],
    products: [
        .library(
            name: "WStack",
            targets: ["WStack"]),
    ],
    targets: [
        .target(
            name: "WStack"),
        .testTarget(
            name: "WStackTests",
            dependencies: ["WStack"]),
    ]
)
