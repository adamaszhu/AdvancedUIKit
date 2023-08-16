// swift-tools-version:5.3
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AdvancedUIKit",
    defaultLocalization: "en",
    platforms: [
        .iOS(.v11)
    ],
    products: [
        .library(name: "AdvancedUIKit", targets: ["AdvancedUIKit"])
    ],
    dependencies: [
        .package(url: "https://github.com/Quick/Quick", .upToNextMajor(from: "5.0.0")),
        .package(url: "https://github.com/Quick/Nimble", .upToNextMajor(from: "10.0.0")),
        .package(url: "https://github.com/adamaszhu/AdvancedFoundation", .upToNextMajor(from: "1.9.7"))
    ],
    targets: [
        .target(name: "AdvancedUIKit",
                dependencies: ["AdvancedFoundation"],
                path: "AdvancedUIKit"),
        .testTarget(
            name: "AdvancedUIKitTests",
            dependencies: ["AdvancedUIKit",
                           "Nimble",
                           "Quick"],
            path: "AdvancedUIKitTests"),
    ]
)
