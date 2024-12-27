// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "HTTPClient",
    platforms: [
        .macOS(.v10_15)
    ],
    products: [
        .library(
            name: "HTTPClient",
            targets: ["HTTPClient"]),
    ],
    dependencies: [
        .package(url: "https://github.com/coollazy/HTTPType.git", from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "HTTPClient",
            dependencies: [
                .product(name: "HTTPType", package: "HTTPType"),
            ]
        ),
    ]
)
