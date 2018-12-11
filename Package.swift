// swift-tools-version:4.2
import PackageDescription

let package = Package(
    name: "JobsTesting",
    dependencies: [
        .package(url: "https://github.com/vapor/vapor.git", from: "3.0.0"),
        .package(url: "https://github.com/vapor-community/redis-jobs.git", .branch("master"))
    ],
    targets: [
        .target(name: "App", dependencies: ["Vapor", "RedisJobs"]),
        .target(name: "Run", dependencies: ["App"]),
        .testTarget(name: "AppTests", dependencies: ["App"])
    ]
)
