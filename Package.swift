// swift-tools-version:5.9
import PackageDescription

let package = Package(
    name: "NailDiseaseSDK",
    platforms: [
        .iOS(.v14)  
    ],
    products: [
        .library(
            name: "NailDiseaseSDK",
            targets: ["NailDiseaseSDK"]
        ),
    ],
    dependencies: [
        
    ],
    targets: [
        .target(
            name: "NailDiseaseSDK",
            dependencies: []
        ),
        .testTarget(
            name: "NailDiseaseSDKTests",
            dependencies: ["NailDiseaseSDK"]
        ),
    ]
)

