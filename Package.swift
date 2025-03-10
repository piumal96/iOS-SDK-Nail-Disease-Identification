// swift-tools-version: 5.9
import PackageDescription

let package = Package(
    name: "NailDiseaseSDK",
    platforms: [
        .iOS(.v14)  // Set your minimum iOS version
    ],
    products: [
        .library(
            name: "NailDiseaseSDK",
            targets: ["NailDiseaseSDK"]
        ),
    ],
    dependencies: [
        // Add third-party dependencies if needed
    ],
    targets: [
        .target(
            name: "NailDiseaseSDK",
            dependencies: [],
            path: "NailDiseaseSDK"   
        ),
        .testTarget(
            name: "NailDiseaseSDKTests",
            dependencies: ["NailDiseaseSDK"],
            path: "NailDiseaseSDKTests"  
        ),
    ]
)
