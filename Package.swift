// swift-tools-version: 5.6
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "VisionLiveText_SwiftUICompatible",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "VisionLiveText_SwiftUICompatible",
            targets: ["VisionLiveText_SwiftUICompatible"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
        // .package(url: /* package url */, from: "1.0.0"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "VisionLiveText_SwiftUICompatible",
            dependencies: []),
        .testTarget(
            name: "VisionLiveText_SwiftUICompatibleTests",
            dependencies: ["VisionLiveText_SwiftUICompatible"]),
    ]
)
