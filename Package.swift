// swift-tools-version: 5.8
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-XibConverter",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .watchOS(.v9),
    ],
    products: [
        .library(
            name: "XibConverter",
            targets: [ "XibConverter" ]
        ),
        .executable(
            name: "XibConverterCLI",
            targets: ["XibConverterCLI"]
        )
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
    ],
    
    targets: [
        .target(
            name: "XibConverter"
        ),
        .executableTarget(
            name: "XibConverterExec",
            dependencies: [
                "XibConverter"
            ]
        ),
        .executableTarget(
            name: "XibConverterCLI",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                "XibConverter"
            ]
        ),
        .testTarget(
            name: "XibConverterTests",
            dependencies: [
                "XibConverter"
            ],
            resources: [
                .copy("Resources/")
            ]
        )
    ]
)
