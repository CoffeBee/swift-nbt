// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "SwiftNBT",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "SwiftNBT",
            targets: ["SwiftNBT"]),
    ],
    dependencies: [
        .package(url: "https://github.com/apple/swift-nio.git", from: "2.31.0"),
        .package(url: "https://github.com/adam-fowler/compress-nio.git", from: "0.4.1")
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "SwiftNBT",
            dependencies: [
                .product(name: "NIO", package: "swift-nio"),
                .product(name: "CompressNIO", package: "compress-nio")
            ]),
        .testTarget(
            name: "SwiftNBTTests",
            dependencies: ["SwiftNBT"],
            resources: [
                .process("TestData")
            ]
        ),
    ]
)
