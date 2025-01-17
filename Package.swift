// swift-tools-version: 5.5
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VYSP",
    platforms: [
        .macOS(.v12), .iOS(.v15), .tvOS(.v15), .watchOS(.v8)
    ],
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "VYSP",
            targets: ["VYSP"]),
    ],
    dependencies: [
    ],
    targets: [
        .target(
            name: "VYSP",
            dependencies: []),
        .testTarget(
            name: "VYSPTests",
            dependencies: ["VYSP"]),
    ]
)
