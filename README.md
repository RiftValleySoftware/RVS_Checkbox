![Icon](icon.png)

# RVS_Checkbox

## INTRODUCTION
This project is a robust, Swift-only, high-quality, "drop-in replacement" for the traditional [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch), provided by Apple. It derives from [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch), and provides almost exactly the same API as [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch).

It is implemented with no dependencies.

Integrating RVS_Checkbox into your application is as simple as adding a [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch) or [`UIView`](https://developer.apple.com/documentation/uikit/uiview) in [Interface Builder](https://developer.apple.com/xcode/interface-builder/https://developer.apple.com/xcode/interface-builder/), and specifying it to be an instance of [`RVS_Checkbox`](https://github.com/RiftValleySoftware/RVS_Checkbox).

You may also create instances of [`RVS_Checkbox`](https://github.com/RiftValleySoftware/RVS_Checkbox) programmatically.

## WHAT PROBLEM DOES THIS SOLVE?
The classic [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch):

![The Standard UISwitch Control](img/UISwitch.png)

Is a great UI element, and is used in place of the classic ["checkbox"](https://developer.apple.com/documentation/appkit/nsbutton) for Mac:

![The Standard Mac Checkbox Control](img/CheckBoxes_Selected.png)

Which doesn't actually work as well, in the "fat finger" world of iOS UI.
### So, What's the Problem?
The issue is that the [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch) is a big, rather awkwardly-shaped element. It is "lozenge"-shaped, and always horizontal, so can require a bit of creativity, when it comes to fitting it into a UI. Also, it has a specific design aesthetic, and can be difficult to customize *(to be fair, Apple doesn't encourage us to customize **ANY** UI, so that's no surprise).*

Because of the horizontal aspect of the control, it is fairly "natural" to have the label to the left:
![A Switch, With the Label on the Left](img/UISwitchLabels-Left.png)

...or the right:

![A Switch, With the Label on the Right](img/UISwitchLabels-Right.png)

But it looks "awkward" to have it below the switch:

![A Switch, With the Label on the Bottom](img/UISwitchLabels-Bottom.png)

This is especially true, if you use "label buttons," like I do (run the test harness, to see them in action).
It is also a bit "weird," as the slider appearance seems to ask for a swipe gesture, as opposed to a tap gesture (which is really what we want). That means that the gesture also requires some "mental runway."
The `RVS_Checkbox` allows a square aspect, and a directionless (tap) affordance, like a regular checkbox.

[`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch) also has a strictly "binary" action. If you have three choices, you are expected to use a [`UISegmentedControl`](https://developer.apple.com/documentation/uikit/uisegmentedcontrol), which is actually quite sensible. Apple obviously put a lot of research into their UX, and there's a good reason for this. Mobile interfaces are a compromise, at best.

### Why Does the RVS_Checkbox Solve This Problem?
Glad you asked. The `RVS_Checkbox` comes with two "built-in" appearances: A default, circular checkbox, and a fairly "classic" appearance that uses the built-in [SF Symbols](https://developer.apple.com/design/human-interface-guidelines/sf-symbols/overview/) to mimic the way the Mac checkboxes appear.

You can also add your own images.

Images are simple. They are always rendered in ["template" mode](https://developer.apple.com/documentation/uikit/uiimage/renderingmode/alwaystemplate), so they are "silhouettes," and are colored by the control's tint.

Additionally, `RVS_Checkbox` brings the "three-state" checkbox that is found in the Mac, to iOS. That means it is possible to have an "OFF," "ON," and "indeterminate" mode (I call it "CLEAR"). The default appearence is the circular checkbox, and the default mode is "binary," like [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch).

Here are what the images look like (the color is controlled by the [`tintColor` property](https://developer.apple.com/documentation/uikit/uiview/1622467-tintcolor) of the control):
<table style="text-align:center">
    <thead>
        <tr>
            <td>&nbsp;</td>
            <td><strong>Default SF Symbols (TINTED RED)</strong></td>
            <td><strong>User-Provided (TEMPLATE)</strong></td>
            <td><strong>User-Provided (FULL COLOR)</strong></td>
        </tr>
    </thead>
    <tbody>
    <tr>
        <td><strong>ON</strong></td>
        <td><img src="img/SFOn.png" alt="The SF Symbols Image for the ON State." /></td>
        <td><img src="img/TestImage-2.png" alt="An Example Customer-Supplied Image for the ON State." /></td>
        <td><img src="img/CHICK.png" alt="An Example Customer-Supplied Image for the ON State." /></td>
    </tr>
    <tr>
        <td><strong>OFF</strong></td>
        <td><img src="img/SFOff.png" alt="The SF Symbols Image for the OFF State." /></td>
        <td><img src="img/TestImage-0.png" alt="An Example Customer-Supplied Image for the OFF State." /></td>
        <td><img src="img/EGG.png" alt="An Example Customer-Supplied Image for the OFF State." /></td>
    </tr>
    <tr>
        <td><strong>CLEAR</strong></td>
        <td><img src="img/SFClear.png" alt="The SF Symbols Image for the CLEAR State." /></td>
        <td><img src="img/TestImage-1.png" alt="An Example Customer-Supplied Image for the CLEAR State." /></td>
        <td><img src="img/HATCHING.png" alt="An Example Customer-Supplied Image for the CLEAR State." /></td>
    </tr>
    </tbody>
</table>

The "Default" images are [SF Symbols](https://developer.apple.com/sf-symbols/) images, that are "baked into" the class, and the "User-Provided" images are three arbitrary images that can be added in the storyboard, or assigned directly. They can be template, or full-color.

The images will resize with the control, but will retain their aspect (Aspect fit mode).

> NOTE: Only "always template" images will be displayed as tinted.

## REQUIREMENTS

``RVS_Checkbox`` is an [iOS](https://apple.com/ios)/[iPadOS](https://apple.com/ipados)-only [`UIKit`](https://developer.apple.com/documentation/uikit)/[Cocoa Touch](https://developer.apple.com/library/archive/documentation/General/Conceptual/DevPedia-CocoaCore/Cocoa.html) [framework](https://developer.apple.com/library/archive/documentation/MacOSX/Conceptual/BPFrameworks/Concepts/WhatAreFrameworks.html) [UIControl](https://developer.apple.com/documentation/uikit/uicontrol), designed for use by [Swift](https://swift.org) language applications.

It is designed for native Swift iOS application development.

This requires [iOS](https://apple.com/ios)/[iPadOS](https://apple.com/ipados) version 17.0 or above.

## DEPENDENCIES

There are no dependencies for the module. If you will be running [the test harness](https://github.com/RiftValleySoftware/RVS_Checkbox/tree/main/TestHarness/RVS_Checkbox_TestHarness), you will need to load [the RVS_Generic_Swift_Toolbox project](https://github.com/RiftValleySoftware/RVS_Generic_Swift_Toolbox), as well.

> NOTE: The [the RVS_Generic_Swift_Toolbox project](https://github.com/RiftValleySoftware/RVS_Generic_Swift_Toolbox) is only for the test harness. The control, itself, has no dependencies.

## INSTALLATION

The control is provided as a [Swift Package Manager](https://swift.org/package-manager/) package, and can also be installed using [Carthage](https://github.com/Carthage/Carthage).

The URL for the SPM module, is [git@github.com:RiftValleySoftware/RVS_Checkbox.git](git@github.com:RiftValleySoftware/RVS_Checkbox.git).

Once the package has been added to your project, remember to import it, when you use it:

    import RVS_Checkbox

If you are using Carthage, then you should add the following line to your [Cartfile](https://github.com/Carthage/Carthage/blob/master/Documentation/Artifacts.md#cartfile):

    github "RiftValleySoftware/RVS_Checkbox"

Then, open Terminal, and navigate to the top of the project directory, and type this into Terminal:

    carthage update
    
It will create a directory at the same level as the Cartfile, called "Carthage." Inside of this directory, will be another directory, called "Checkouts." Inside of that directory, will be another one, called "RVS_Checkbox." You want to go into "Sources/RVS_Checkout," and access [the RVS_Checkbox.swift file](https://github.com/RiftValleySoftware/RVS_Checkbox/blob/main/Sources/RVS_Checkbox/RVS_Checkbox.swift). Drag a reference to this into your project, and associate it with your app build target.

Once you have the reference, then you won't need to import the module.

## USAGE

In Interface Builder/Storyboard Editor, simply drag in a [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch) or [`UIView`](https://developer.apple.com/documentation/uikit/uiview) reference, and rename the class to ``RVS_Checkbox``. The inspectable elements should be immediately available in the Attributes Inspector.

![The Attributes Inspector](img/Attributes.png)

A "Clear" image is not required, unless Is Three State is On.

If you do not supply any images, then the default SF Symbols will be used.

> NOTE: It is also possible to [programmatically disable display of custom images](https://github.com/RiftValleySoftware/RVS_Checkbox/blob/main/Sources/RVS_Checkbox/RVS_Checkbox.swift#L296).
