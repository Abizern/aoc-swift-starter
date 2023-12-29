// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "aoc-00",
    platforms: [.macOS(.v14)],
    dependencies: [
        .package(
            url: "https://github.com/apple/swift-argument-parser.git",
            .upToNextMajor(from: "1.3.0")
        ),
        .package(
            url: "https://github.com/Abizern/Advent-Utilities.git",
            branch: "main"
        ),
        .package(
            url: "https://github.com/pointfreeco/swift-parsing",
            .upToNextMajor(from: "0.13.0")
        ),
        .package(
            url: "https://github.com/apple/swift-algorithms.git",
            .upToNextMajor(from: "1.2.0")
        ),
        .package(
            url: "https://github.com/apple/swift-collections.git",
            .upToNextMajor(from: "1.0.0")
        ),
    ],
    targets: [
        .executableTarget(
            name: "aoc-00",
            dependencies: [
                .product(name: "ArgumentParser", package: "swift-argument-parser"),
                .product(name: "Utilities", package: "Advent-Utilities"),
                "Challenges",
            ]
        ),
        .target(
            name: "Challenges",
            dependencies: [
                .product(name: "Utilities", package: "Advent-Utilities"),
                .product(name: "Algorithms", package: "swift-algorithms"),
                .product(name: "Collections", package: "swift-collections"),
                .product(name: "Parsing", package: "swift-parsing"),
            ],
            resources: [.copy("Inputs")]
        ),
        .testTarget(
            name: "ChallengesTests",
            dependencies: ["Challenges"]
        ),
    ]
)
