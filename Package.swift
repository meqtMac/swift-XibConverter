// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-XibConverter",
    platforms: [
        .macOS(.v13),
        .iOS(.v11),
        .watchOS(.v10),
    ],
    products: [
        .library(
            name: "XibConverter",
            targets: [ "XibConverter" ]
        )
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "XibConverter"
        ),
        .executableTarget(
            name: "XibConverterExec",
            dependencies: [
                "XibConverter"
            ]
        ),
        .testTarget(
            name: "XibConverterTests",
            dependencies: [
                "XibConverter"
            ]
        )
    ]
)
