// swift-tools-version: 5.9
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
        // Add third-party dependencies here if needed
    ],
    targets: [
        .target(
            name: "NailDiseaseSDK",
            dependencies: [],
            path: "NailDiseaseSDK",
            exclude: [],  
            resources: [   
                .process("model.tflite")  
            ]
        ),
        .testTarget(
            name: "NailDiseaseSDKTests",
            dependencies: ["NailDiseaseSDK"],
            path: "NailDiseaseSDKTests",
            exclude: [],
            resources: [
                .process("TestImages/test_image.jpg")  
            ]
        ),
    ]
)
