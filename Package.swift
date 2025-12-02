// swift-tools-version: 6.2
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AoC2025",
    platforms: [
        .macOS(.v26)
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .executableTarget(
            name: "AoC2025",
            dependencies: [
                "Solutions",
                "InputFetcher",
            ]
        ),
        .target(
            name: "InputFetcher",
        ),
        .target(
            name: "Solutions",
            dependencies: ["InputFetcher"]
        ),
        .testTarget(
            name: "SolutionsTests",
            dependencies: [
                "Solutions",
                "InputFetcher",
            ]
        ),
    ]
)
