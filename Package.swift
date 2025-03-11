// // swift-tools-version: 5.9
// // swift-tools-version:5.9
// import PackageDescription

// let package = Package(
//     name: "NailDiseaseSDK",
//     platforms: [
//         .iOS(.v13)  
//     ],
//     products: [
//         .library(
//             name: "NailDiseaseSDK",
//             targets: ["NailDiseaseSDK"]
//         ),
//     ],
//     dependencies: [
//         // Add third-party dependencies here if needed
//     ],
//     targets: [
//         .target(
//             name: "NailDiseaseSDK",
//             dependencies: [],
//             path: "NailDiseaseSDK",
//             exclude: [],  
//             resources: [   
//                 .process("model.tflite")  
//             ]
//         ),
//         .testTarget(
//             name: "NailDiseaseSDKTests",
//             dependencies: ["NailDiseaseSDK"],
//             path: "NailDiseaseSDKTests",
//             exclude: [],
//             resources: [
//                 .process("TestImages/test_image.jpg")  
//             ]
//         ),
//     ]
// )
// swift-tools-version: 5.9

import PackageDescription

let package = Package(
    name: "NailDiseaseSDK",
    platforms: [
        .iOS(.v14) // Supports iOS 14 and above
    ],
    products: [
        .library(
            name: "NailDiseaseSDK",
            targets: ["NailDiseaseSDK"]
        ),
    ],
    targets: [
        .binaryTarget(
            name: "NailDiseaseSDK",
            url: "https://github.com/piumal96/iOS-SDK-Nail-Disease-Identification/releases/download/v1.0.0/NailDiseaseSDK.xcframework.zip",
            checksum: "87e661cf8642f9a8d1ddaa17c71018a0bebc291ec9f9ea74c5700de96f764c17" // Auto-updated in CI
        )
    ]
)
