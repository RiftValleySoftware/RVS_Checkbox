// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "RVS_Checkbox",
    platforms: [
        .iOS(.v13)
    ],
    products: [
        .library(name: "RVS-Checkbox",
                 targets: [
                    "RVS_Checkbox"
                    ]
        )
    ],
    targets: [
        .target(
            name: "RVS_Checkbox",
            dependencies: [])
    ]
)
