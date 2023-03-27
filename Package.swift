// swift-tools-version: 5.7
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "ExtensionHelper5",
    products: [
        // Products define the executables and libraries a package produces, and make them visible to other packages.
        .library(
            name: "ExtensionHelper5",
            targets: ["ExtensionHelper5"]),
    ],
    dependencies: [
        // Dependencies declare other packages that this package depends on.
         .package(url: "https://github.com/danha1998/ExtensionHelper5", from: "1.0.6"),
    ],
    targets: [
        // Targets are the basic building blocks of a package. A target can define a module or a test suite.
        // Targets can depend on other targets in this package, and on products in packages this package depends on.
        .target(
            name: "ExtensionHelper5",
            dependencies: []),
        .testTarget(
            name: "ExtensionHelper5Tests",
            dependencies: ["ExtensionHelper5"]),
    ]
)
