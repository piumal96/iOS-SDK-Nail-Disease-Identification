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
            url: "https://github.com/piumal96/iOS-SDK-Nail-Disease-Identification/releases/download/v1.0.3/NailDiseaseSDK.xcframework.zip",
            checksum: "PASTE_a7867774ab59b1d25f77ede8e951f7507ac94cf1d44cd3b7bc49294f28d5cb93"
        )
    ]
)
