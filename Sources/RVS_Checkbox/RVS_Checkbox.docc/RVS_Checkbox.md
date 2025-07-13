# ``RVS_Checkbox``

![Icon](icon.png)

## Overview
This project is a robust, Swift-only, high-quality, "drop-in replacement" for the traditional [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch), provided by Apple. It derives from [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch), and provides almost exactly the same API as [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch).

It is implemented with no dependencies.

Integrating RVS_Checkbox into your application is as simple as adding a [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch) or [`UIView`](https://developer.apple.com/documentation/uikit/uiview) in [Interface Builder](https://developer.apple.com/xcode/interface-builder/https://developer.apple.com/xcode/interface-builder/), and specifying it to be an instance of [`RVS_Checkbox`](https://github.com/RiftValleySoftware/RVS_Checkbox).

You may also create instances of [`RVS_Checkbox`](https://github.com/RiftValleySoftware/RVS_Checkbox) programmatically.

## WHAT PROBLEM DOES THIS SOLVE?
The classic [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch):

![The Standard UISwitch Control](UISwitch.png)

Is a great UI element, and is used in place of the classic ["checkbox"](https://developer.apple.com/documentation/appkit/nsbutton) for Mac:

![The Standard Mac Checkbox Control](CheckBoxes_Selected.png)

Which doesn't actually work as well, in the "fat finger" world of iOS UI.
### So, What's the Problem?
The issue is that the [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch) is a big, rather awkwardly-shaped element. It is "lozenge"-shaped, and always horizontal, so can require a bit of creativity, when it comes to fitting it into a UI. Also, it has a specific design aesthetic, and can be difficult to customize *(to be fair, Apple doesn't encourage us to customize **ANY** UI, so that's no surprise).*

Because of the horizontal aspect of the control, it is fairly "natural" to have the label to the left:
![A Switch, With the Label on the Left](UISwitchLabels-Left.png)

...or the right:

![A Switch, With the Label on the Right](UISwitchLabels-Right.png)

But it looks "awkward" to have it below the switch:

![A Switch, With the Label on the Bottom](UISwitchLabels-Bottom.png)

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
        <td><img src="SFOn.png" alt="The SF Symbols Image for the ON State." /></td>
        <td><img src="TestImage-2.png" alt="An Example Customer-Supplied Image for the ON State." /></td>
        <td><img src="CHICK.png" alt="An Example Customer-Supplied Image for the ON State." /></td>
    </tr>
    <tr>
        <td><strong>OFF</strong></td>
        <td><img src="SFOff.png" alt="The SF Symbols Image for the OFF State." /></td>
        <td><img src="TestImage-0.png" alt="An Example Customer-Supplied Image for the OFF State." /></td>
        <td><img src="EGG.png" alt="An Example Customer-Supplied Image for the OFF State." /></td>
    </tr>
    <tr>
        <td><strong>CLEAR</strong></td>
        <td><img src="SFClear.png" alt="The SF Symbols Image for the CLEAR State." /></td>
        <td><img src="TestImage-1.png" alt="An Example Customer-Supplied Image for the CLEAR State." /></td>
        <td><img src="HATCHING.png" alt="An Example Customer-Supplied Image for the CLEAR State." /></td>
    </tr>
    </tbody>
</table>

The "Default" images are [SF Symbols](https://developer.apple.com/sf-symbols/) images, that are "baked into" the class, and the "User-Provided" images are three arbitrary images that can be added in the storyboard, or assinged directly. They can be template, or full-color.

The images will resize with the control, but will retain their aspect (Aspect fit mode).

> NOTE: Only "always template" images will be displayed as tinted.

## DEPENDENCIES

There are no dependencies for the module. If you will be running [the test harness](https://github.com/RiftValleySoftware/RVS_Checkbox/tree/main/TestHarness/RVS_Checkbox_TestHarness), you will need to load [the RVS_Generic_Swift_Toolbox project](https://github.com/RiftValleySoftware/RVS_Generic_Swift_Toolbox), as well.

> NOTE: The [the RVS_Generic_Swift_Toolbox project](https://github.com/RiftValleySoftware/RVS_Generic_Swift_Toolbox) is only for the test harness. The control, itself, has no dependencies.

## USAGE

In Interface Builder/Storyboard Editor, simply drag in a [`UISwitch`](https://developer.apple.com/documentation/uikit/uiswitch) or [`UIView`](https://developer.apple.com/documentation/uikit/uiview) reference, and rename the class to ``RVS_Checkbox``. The inspectable elements should be immediately available in the Attributes Inspector.

![The Attributes Inspector](Attributes.png)

A "Clear" image is not required, unless Is Three State is On.

If you do not supply any images, then the default SF Symbols will be used.

> NOTE: It is also possible to [programmatically disable display of custom images](https://github.com/RiftValleySoftware/RVS_Checkbox/blob/main/Sources/RVS_Checkbox/RVS_Checkbox.swift#L296).

# LICENSE
=
MIT License

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation
files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,
modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the
Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF
CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

[The Great Rift Valley Software Company: https://riftvalleysoftware.com](https://riftvalleysoftware.com)
