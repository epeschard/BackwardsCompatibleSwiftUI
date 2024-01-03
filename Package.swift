// swift-tools-version:5.3

import PackageDescription

let package = Package(
    name: "BackwardsCompatibleSwiftUI",
    products: [
        .library(
            name: "BackwardsCompatibleSwiftUI",
            targets: ["BackwardsCompatibleSwiftUI"]
        ),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        .target(
            name: "BackwardsCompatibleSwiftUI",
            dependencies: []
        ),
        .testTarget(
            name: "BackwardsCompatibleSwiftUITests",
            dependencies: ["BackwardsCompatibleSwiftUI"]
        ),
    ]
)
