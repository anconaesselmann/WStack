// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "WStack",
    platforms: [
        .iOS(.v17),
        .watchOS(.v10),
        .tvOS(.v17),
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
