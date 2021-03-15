// swift-tools-version:5.2

import PackageDescription

let package = Package(
    name: "RVS_Checkbox",
    platforms: [
        .iOS(.v13),
        .tvOS(.v13),
        .macOS(.v10_15),
        .watchOS(.v6)
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
            dependencies: []),
        .testTarget(
            name: "RVS_CheckboxTest",
            dependencies: ["RVS_Checkbox"])
    ]
)
