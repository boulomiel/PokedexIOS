// swift-tools-version: 6.0
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AppDI",
    platforms: [
        .iOS(.v18)
    ],
    products: [
        // Products define the executables and libraries a package produces, making them visible to other packages.
        .library(
            name: "AppDI",
            targets: ["AppDI"]),
    ],
    dependencies: [
        .package(name: "PokeApi", path: "../PokeApi"),
        .package(name: "Tools", path: "../Tools"),
        .package(name: "Resources", path: "../Resources"),
        .package(name: "ShareTeam", path: "../ShareTeam"),
        .package(name: "AppPersistence", path: "../AppPersistence")
    ],
    targets: [
        // Targets are the basic building blocks of a package, defining a module or a test suite.
        // Targets can depend on other targets in this package and products from dependencies.
        .target(
            name: "AppDI",
            dependencies: [
                "PokeApi", "Tools", "Resources", "ShareTeam", "AppPersistence"
            ]
        ),

    ]
)
