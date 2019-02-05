// swift-tools-version:4.0
import PackageDescription

let package = Package(
    name: "MediaSortr",
    dependencies: [
        // 💧 A server-side Swift web framework.
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor/fluent-postgresql.git", from: "1.0.0"),
        .package(url: "https://github.com/BrettRToomey/Jobs.git", from: "1.1.1"),
        .package(url: "https://github.com/IBM-Swift/Configuration.git", from: "3.0.2")
    ],
    targets: [
        .target(name: "App", dependencies: ["FluentPostgreSQL", "Vapor", "Jobs", "Configuration"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
