Pod::Spec.new do |spec|
    spec.name               = 'RVS_Checkbox'
    spec.summary            = 'A robust, simple "drop-in" replacement for the Apple UISwitch UI element.'
    spec.description        = 'The RVS_Checkbox is a Swift shared framework designed to allow easy implementation of a powerful, robust, simple, and highly-usable checkbox control.'
    spec.version            = '1.0.3'
    spec.platform           = :ios, '13.0'
    spec.homepage           = 'https://cocoapods.org/pods/RVS_Checkbox'
    spec.social_media_url   = 'https://twitter.com/GrtRiftValley'
    spec.author             = { 'The Great Rift Valley Software Company' => 'chris@riftvalleysoftware.com' }
    spec.documentation_url  = 'https://riftvalleysoftware.github.io/RVS_Checkbox/'
    spec.license            = { :type => 'MIT', :file => 'LICENSE' }
    spec.source             = { :git => 'https://github.com/RiftValleySoftware/RVS_Checkbox.git', :tag => spec.version.to_s }
    spec.source_files       = 'Sources/RVS_Checkbox/RVS_Checkbox.swift'
    spec.swift_version      = '5.0'
    spec.ios.framework      = 'UIKit'
end
