// swift-tools-version:5.0
import PackageDescription

let package = Package(
    name: "JobsTesting",
    platforms: [
       .macOS(.v10_14)
    ],
    products: [
        .executable(name: "Run", targets: ["Run"]),
        .library(name: "App", targets: ["App"]),
    ],
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "4.0.0-beta.3.1"),
        .package(url: "https://github.com/vapor/jobs-redis-driver.git", from: "1.0.0-beta.2.1.0")
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "JobsRedisDriver"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
