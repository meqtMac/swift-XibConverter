// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "swift-XibConverter",
    platforms: [
        .macOS(.v13),
        .iOS(.v16),
        .watchOS(.v10),
    ],
    products: [
        .library(
            name: "XibConverter",
            targets: [ "XibConverter" ]
        )
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
