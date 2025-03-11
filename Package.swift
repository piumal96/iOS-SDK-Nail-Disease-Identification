// swift-tools-version: 5.9
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
    targets: [
        .binaryTarget(
            name: "NailDiseaseSDK",
            url: "https://github.com/piumal96/iOS-SDK-Nail-Disease-Identification/releases/download/v1.0.0/NailDiseaseSDK.xcframework.zip",
            checksum: "PASTE_YOUR_CHECKSUM_HERE"
        )
    ]
)
